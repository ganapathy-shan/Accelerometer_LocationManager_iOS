//
//  AccelerationMetrics.h
//  Accel_LocationManager
//
//  Created by Shanmuganathan on 19/04/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
@class AccelerationMetrics

@brief The Acceleration Metrics class

@discussion    This class responsible for stroing acceleration statistics and calculate metrics.
*/

@interface AccelerationMetrics : NSObject

@property (strong, nonatomic) NSMutableArray<NSNumber *>* allValues;
@property (assign, nonatomic) double currentValue;
@property (assign, nonatomic) double count;
@property (assign, nonatomic) double min;
@property (assign, nonatomic) double max;
@property (assign, nonatomic) double mean;
@property (assign, nonatomic) double median;
@property (assign, nonatomic) double zeroCrossingsCount;
@property (assign, nonatomic) double standardDeviation;

-(void)addToArray:(double)value;
-(void)calculateMetrics;
@end

NS_ASSUME_NONNULL_END
