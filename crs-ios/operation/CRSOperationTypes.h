//
//  CRSOperationTypes.h
//  crs-ios
//
//  Created by Brian Osborn on 7/16/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Coordinate Operation type
 */
enum CRSOperationType{
    CRS_OPERATION_COORDINATE,
    CRS_OPERATION_POINT_MOTION,
    CRS_OPERATION_MAP_PROJECTION,
    CRS_OPERATION_DERIVING_CONVERSION,
    CRS_OPERATION_ABRIDGED_COORDINATE_TRANSFORMATION
};

@interface CRSOperationTypes : NSObject

@end
