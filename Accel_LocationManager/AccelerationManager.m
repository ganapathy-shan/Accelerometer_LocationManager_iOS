//
//  AccelerationManager.m
//  Accel_LocationManager
//
//  Created by Shanmuganathan on 19/04/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

#import "AccelerationManager.h"
#import <CoreMotion/CoreMotion.h>

#define AccelerometerUpdateInterval 0.05

@interface AccelerationManager ()

@property (strong, nonatomic) CMMotionManager *motionManager;

/* Background queue which receives acceleration updates in the callback */
@property (nonatomic,strong) NSOperationQueue *accelartionUpdatesQueue;

@end

@implementation AccelerationManager

- (id)init
{
    self = [super init];
    if (self)
    {
        _motionManager = [[CMMotionManager alloc]init];

        _xAccelerationMetrics = [[AccelerationMetrics alloc] init];
        _yAccelerationMetrics = [[AccelerationMetrics alloc] init];
        _zAccelerationMetrics = [[AccelerationMetrics alloc] init];
        _accelartionUpdatesQueue =  [[NSOperationQueue alloc] init];
        /* Concurrent queue which receives acceleration updates*/
        _accelartionUpdatesQueue.maxConcurrentOperationCount = 4;
    }
    return self;
}

- (void)startAccelerationUpdates
{
    self.motionManager.accelerometerUpdateInterval = AccelerometerUpdateInterval;
    [self.motionManager startAccelerometerUpdatesToQueue:self.accelartionUpdatesQueue
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 if(error)
                                                 {
                                                    NSLog(@"Failed to start Accelerometer. Error: %@", error);
                                                 }
                                                 else
                                                 {
                                                     [self.xAccelerationMetrics addToArray:accelerometerData.acceleration.x];
                                                     [self.yAccelerationMetrics addToArray:accelerometerData.acceleration.y];
                                                     [self.zAccelerationMetrics addToArray:accelerometerData.acceleration.z];
                                                 }
                                             }];
}

- (void)stopAccelerationUpdates
{
    [self.motionManager stopAccelerometerUpdates];
}

- (void)calculateAccelerationMetrics
{
    [self.xAccelerationMetrics calculateMetrics];
    [self.yAccelerationMetrics calculateMetrics];
    [self.zAccelerationMetrics calculateMetrics];
}
@end
