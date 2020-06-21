//
//  NSArray+Metrics.m
//  Accel_LocationManager
//
//  Created by Shanmuganathan on 19/04/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

#import "NSArray+Metrics.h"

@implementation NSArray (Metrics)

-(NSNumber *)mean
{
    double sum = 0, mean = 0;
    for(NSNumber *element in self)
    {
        sum = sum + element.doubleValue;
    }
    mean = sum/self.count;
    return [NSNumber numberWithDouble:mean];
}

-(NSNumber *)min
{
    NSNumber *min = [self valueForKeyPath:@"@min.self"];
    return min;
}

-(NSNumber *)max
{
    NSNumber *max = [self valueForKeyPath:@"@max.self"];
    return max;
}

-(NSNumber *)median
{
    NSArray *sortedArray = [self sortedArrayUsingSelector:@selector(compare:)];
    NSNumber *median;
    if(sortedArray.count != 1)
    {
        if(sortedArray.count % 2 == 0)
        {
            median = @(([[sortedArray objectAtIndex:(sortedArray.count-1) / 2]doubleValue] +
                        [[sortedArray objectAtIndex:sortedArray.count / 2 ]doubleValue])/2);
        }
        else
        {
            median = @([[sortedArray objectAtIndex:sortedArray.count / 2] doubleValue]);
        }
    }
    else
    {
        median = [sortedArray objectAtIndex:0];
    }
    return median;
}

-(NSNumber *)zeroCrossingsCount
{
    double count = 0;
    if(self.count > 0)
    {
        NSNumber *prevValue = [self objectAtIndex:0];
        for(NSNumber *element in self)
        {
            if ((prevValue.doubleValue > 0 && element.doubleValue <0) || (prevValue.doubleValue < 0 && element.doubleValue > 0))
                count = count + 1;
            prevValue = element;
        }
    }
    return [NSNumber numberWithDouble:count];
}

-(NSNumber *)standardDeviation
{
    double sumOfSquaredDifferencesFromMean = 0;
    double meanValue = [self mean].doubleValue;
    for(NSNumber *score in self)
    {
        sumOfSquaredDifferencesFromMean += ((score.doubleValue - meanValue) * (score.doubleValue - meanValue));
    }
    
    NSNumber *standardDeviation = @(sqrt(sumOfSquaredDifferencesFromMean / self.count));
    
    return standardDeviation;
}

@end
