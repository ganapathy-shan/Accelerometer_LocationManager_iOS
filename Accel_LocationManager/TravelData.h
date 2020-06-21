//
//  TravelData.h
//  Accel_LocationManager
//
//  Created by Shanmuganathan on 19/04/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
@class TravelData

@brief The Travel Data Class

@discussion    This class stores location update along with distance travelled from last location.
*/

@interface TravelData : NSObject

/* Location Data*/
@property (nonatomic, strong) CLLocation  *location;
/* Distance travelled from last location. For initial location update, this property value will be zero*/
@property (nonatomic, assign) double travelledDistance;

@end

NS_ASSUME_NONNULL_END
