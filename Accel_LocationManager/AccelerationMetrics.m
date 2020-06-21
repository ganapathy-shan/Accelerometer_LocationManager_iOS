//
//  AccelerationMetrics.m
//  Accel_LocationManager
//
//  Created by Shanmuganathan on 19/04/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

#import "AccelerationMetrics.h"
#import "NSArray+Metrics.h"

@implementation AccelerationMetrics

- (instancetype)init
{
    self = [super init];
    if (self) {
        _min = INT_MAX;
        _max = INT_MIN;
        _allValues = [[NSMutableArray alloc]init];
    }
    return self;
}
/* add the current acceleration value into array*/
-(void)addToArray:(double)value
{
    [self.allValues addObject:[NSNumber numberWithDouble:value]];
}

/* Calculate min, max, median, mean, standard deviation, zero crossings and store those valsue in properties*/
- (void)calculateMetrics
{
    @synchronized (self) {
        NSArray<NSNumber *> *values = [self.allValues copy];
        self.min = [values min].doubleValue;
        self.max = [values max].doubleValue;
        self.count = values.count;
        self.median = [values median].doubleValue ;
        self.mean = [values mean].doubleValue;
        self.zeroCrossingsCount = [values zeroCrossingsCount].doubleValue;
        self.standardDeviation = [values standardDeviation].doubleValue;
    }
}

@end
