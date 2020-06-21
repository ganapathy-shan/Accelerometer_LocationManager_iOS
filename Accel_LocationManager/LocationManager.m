//
//  LocationManager.m
//  Accel_LocationManager
//
//  Created by Shanmuganathan on 18/04/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

#import "LocationManager.h"
#import "TravelData.h"
#import <CoreLocation/CoreLocation.h>

static double ThreeMinutesTimeIntervalInSeconds = 180;

@interface LocationManager () <CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

/* Background queue calculate distance covered in three minutes with every location update */
@property (nonatomic,strong) dispatch_queue_t locationUpdatesQueue;

/* Stores all location data in last three minutes*/
@property (atomic, strong) NSMutableArray<TravelData *> *travelledDataInThreeLastThreeMinutes;

@end

@implementation LocationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _travelledDataInThreeLastThreeMinutes = [[NSMutableArray alloc] init];
        
        /* We need best accuracy*/
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        /* We need updates for minumum distance changes of 5 meters*/
        _locationManager.distanceFilter = 5.0;
        
        /* Pause location updates when there is no movement for long time*/
        _locationManager.pausesLocationUpdatesAutomatically = YES;
        
        /* Activity type set for Automotive navigation like Car. This enables
         iOS to pause location update hwne there is no movement for long time*/
        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        
        /* Make it serial queue, so distance calculation will be in accurate order for every location update*/
        _locationUpdatesQueue =  dispatch_queue_create("com.travel.queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)startLocationUpdates
{
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void)stopLocationUpdates
{
    [self.locationManager stopUpdatingLocation];
    [self.travelledDataInThreeLastThreeMinutes removeAllObjects];
    self.distanceTravelledInThreeMinutes = 0.0;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations.lastObject;
    
    /* Discard updates which are more than 3 minutes as they are old cached update and we don't need it*/
    /* We will consider only the high accuracy location update, only if horizontal accuracy is greater than 0 and less than 50*/
    if(location &&
       [location.timestamp timeIntervalSinceNow] < ThreeMinutesTimeIntervalInSeconds &&
       location.horizontalAccuracy >= 0 &&
       location.horizontalAccuracy < 50)
    {
        //Dispatch calculation of distance covered in last three minutes to background serial queue
        dispatch_async(self.locationUpdatesQueue, ^{
            [self calculateDistanceTravelledInThreeMinutesFrom:location];
        });
    }
}

- (void) calculateDistanceTravelledInThreeMinutesFrom : (CLLocation *)location
{
    unsigned long count = self.travelledDataInThreeLastThreeMinutes.count;
    TravelData *travelData = [[TravelData alloc] init];
    travelData.location = location;
    travelData.travelledDistance = 0.0;
    double distanceTravelledInThreeMinutes = self.distanceTravelledInThreeMinutes;

    /* Calculate distance only if array has some lcoation data*/
    if(count > 0)
    {
        CLLocation *previousLocation = self.travelledDataInThreeLastThreeMinutes.lastObject.location;
        travelData.travelledDistance = [location distanceFromLocation:previousLocation];
        
        /* If current location update came after three minutes, then remove all location data from array,
         as we need to calculate only the distance traveeled in last three minutes and looks user
         is not travelled for atleast three minutes*/
        if([location.timestamp timeIntervalSinceDate:previousLocation.timestamp] > ThreeMinutesTimeIntervalInSeconds)
        {
            [self.travelledDataInThreeLastThreeMinutes removeAllObjects];
            self.distanceTravelledInThreeMinutes = 0.0;
            return;
        }
        else
        {
            /* Calculate distance travelled in last three minutes*/
            for (int i = 0; i < count ; i++)
            {
                TravelData *data = self.travelledDataInThreeLastThreeMinutes[i];
                /* Current location update is within three minutes from the first location update.
                 So, add the distance travelled into distanceTravelledInThreeMinutes variable*/
                if([location.timestamp timeIntervalSinceDate:data.location.timestamp] < ThreeMinutesTimeIntervalInSeconds)
                {
                    distanceTravelledInThreeMinutes = distanceTravelledInThreeMinutes + travelData.travelledDistance;
                    break;
                }
                else
                {
                    /* TRICKY: Current location update is more then three minutes from the first location update.
                    So, we need to remove all the older location updates which are more than three minutes old
                    Also, we need to subtract the distance travelled as we are removing it in array(distance travelled
                    for the current element will be present in next element location data)*/
                    if(i+1 < count)
                        distanceTravelledInThreeMinutes = distanceTravelledInThreeMinutes - self.travelledDataInThreeLastThreeMinutes[i+1].travelledDistance;
                    [self.travelledDataInThreeLastThreeMinutes removeObject:data];
                }
            }
        }
    }

    [self.travelledDataInThreeLastThreeMinutes addObject:travelData];
    self.distanceTravelledInThreeMinutes = distanceTravelledInThreeMinutes;
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    NSLog(@"Location updates paused");
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error : %@",[error localizedDescription]);
    [manager stopUpdatingLocation];
    [manager startUpdatingLocation];
}
@end
