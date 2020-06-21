//
//  NSArray+Metrics.h
//  Accel_LocationManager
//
//  Created by Shanmuganathan on 19/04/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
@category NSArray (Metrics)

@brief The NSArray Metrics category

@discussion    This class responsible for calculating mean, min, max, median, standard deviation, zero crossings .
*/

@interface NSArray (Metrics)

- (NSNumber *)mean;

- (NSNumber *)min;

- (NSNumber *)max;

- (NSNumber *)median;

- (NSNumber *)standardDeviation;

- (NSNumber *)zeroCrossingsCount;

@end

NS_ASSUME_NONNULL_END
