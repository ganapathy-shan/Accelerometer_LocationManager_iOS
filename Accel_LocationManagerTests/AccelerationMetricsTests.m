//
//  AccelerationMetricsTests.m
//  Accel_LocationManagerTests
//
//  Created by Shanmuganathan on 19/04/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AccelerationMetrics.h"

@interface AccelerationMetricsTests : XCTestCase

@property (nonatomic,strong) AccelerationMetrics *accelerationMetrics;

@end

@implementation AccelerationMetricsTests

- (void)setUp {
    self.accelerationMetrics = [[AccelerationMetrics alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testAddToArray {
    [self.accelerationMetrics addToArray:0.6];
    [self.accelerationMetrics addToArray:2.8089];
    [self.accelerationMetrics addToArray:-9.6983490];
    [self.accelerationMetrics addToArray:1.667];
    [self.accelerationMetrics addToArray:890.667];
    [self.accelerationMetrics addToArray:7.1234];
    
    NSArray *allValues = self.accelerationMetrics.allValues;
    XCTAssertEqual(allValues.count, (unsigned long)6);
    
    XCTAssertTrue([allValues[0] isEqual:@0.6]);
    XCTAssertTrue([allValues[1] isEqual:@2.8089]);
    XCTAssertTrue([allValues[2] isEqual:@-9.6983490]);
    XCTAssertTrue([allValues[3] isEqual:@1.667]);
    XCTAssertTrue([allValues[4] isEqual:@890.667]);
    XCTAssertTrue([allValues[5] isEqual:@7.1234]);
}

- (void)testCalculateMetrics {
 
    [self.accelerationMetrics addToArray:0.6];
    [self.accelerationMetrics addToArray:2.8089];
    [self.accelerationMetrics addToArray:-9.6983490];
    [self.accelerationMetrics addToArray:1.667];
    [self.accelerationMetrics addToArray:890.667];
    [self.accelerationMetrics addToArray:7.1234];
    
    [self.accelerationMetrics calculateMetrics];
    
    XCTAssertEqual(self.accelerationMetrics.count, 6);
    XCTAssertEqual(self.accelerationMetrics.min,-9.6983490);
    XCTAssertEqual(self.accelerationMetrics.max, 890.667);
    XCTAssertEqual(self.accelerationMetrics.median, 2.23795);
    XCTAssertEqual((float)self.accelerationMetrics.mean, 148.8613251666f);
    XCTAssertEqual((float)self.accelerationMetrics.standardDeviation, 331.78441035202f);
    XCTAssertEqual(self.accelerationMetrics.zeroCrossingsCount, 2);
}

@end
