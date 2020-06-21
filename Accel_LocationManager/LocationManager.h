//
//  LocationManager.h
//  Accel_LocationManager
//
//  Created by Shanmuganathan on 18/04/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
@class LocationManager

@brief The Location Manager class

@discussion    This class responsible for start and stop location updates and stores value of distance travelled in last three minutes.
*/

@interface LocationManager : NSObject

- (void)startLocationUpdates;
- (void)stopLocationUpdates;

/* Total distance travelled in last three minutes. UI registeres changes
 for this property and updates itself when this property value is updated.*/
@property (nonatomic, assign) double distanceTravelledInThreeMinutes;

@end

NS_ASSUME_NONNULL_END
