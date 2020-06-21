//
//  AccelerationManager.h
//  Accel_LocationManager
//
//  Created by Shanmuganathan on 19/04/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccelerationMetrics.h"

NS_ASSUME_NONNULL_BEGIN

/*!
@class AccelerationManager

@brief The Acceleration Manager class

@discussion    This class responsible for start and stop device acceleration sampling and it makes calls to calculate acceleration statistics.
*/
@interface AccelerationManager : NSObject

@property (strong, nonatomic) AccelerationMetrics *xAccelerationMetrics;
@property (strong, nonatomic) AccelerationMetrics *yAccelerationMetrics;
@property (strong, nonatomic) AccelerationMetrics *zAccelerationMetrics;


- (void)startAccelerationUpdates;
- (void)stopAccelerationUpdates;
- (void)calculateAccelerationMetrics;


@end

NS_ASSUME_NONNULL_END
