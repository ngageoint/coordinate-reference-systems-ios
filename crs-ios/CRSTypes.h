//
//  CRSTypes.h
//  crs-ios
//
//  Created by Brian Osborn on 7/12/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRSCategoryTypes.h"

/**
 * Well-known text representation of coordinate reference systems category type
 */
enum CRSType{
    CRS_TYPE_BOUND,
    CRS_TYPE_COMPOUND,
    CRS_TYPE_CONCATENATED_OPERATION,
    CRS_TYPE_COORDINATE_METADATA,
    CRS_TYPE_COORDINATE_OPERATION,
    CRS_TYPE_DERIVED,
    CRS_TYPE_ENGINEERING,
    CRS_TYPE_GEODETIC,
    CRS_TYPE_GEOGRAPHIC,
    CRS_TYPE_PARAMETRIC,
    CRS_TYPE_POINT_MOTION_OPERATION,
    CRS_TYPE_PROJECTED,
    CRS_TYPE_TEMPORAL,
    CRS_TYPE_VERTICAL
};

@interface CRSTypes : NSObject

/**
 *  Get the category type
 *
 *  @param crsType CRS type
 *
 *  @return category type
 */
+(enum CRSCategoryType) categoryType: (enum CRSType) crsType;

@end
