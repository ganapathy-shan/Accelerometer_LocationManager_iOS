//
//  NSArray+MetricsTests.m
//  Accel_LocationManagerTests
//
//  Created by Shanmuganathan on 19/04/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+Metrics.h"

@interface NSArray_MetricsTests : XCTestCase

@end

@implementation NSArray_MetricsTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testArrayProperties {

    NSArray *array = @[@0.6, @2.8089, @-9.6983490, @1.667, @890.667, @7.1234];
    XCTAssertEqual(array.count, 6);

    XCTAssertEqual(array.min.floatValue,-9.6983490f);
    XCTAssertEqual(array.max.floatValue, 890.667f);
    XCTAssertEqual(array.median.floatValue, 2.23795f);
    XCTAssertEqual(array.mean.floatValue, 148.8613251666f);
    XCTAssertEqual(array.standardDeviation.floatValue, 331.78441035202f);
    XCTAssertEqual(array.zeroCrossingsCount.floatValue, 2);
}


@end
