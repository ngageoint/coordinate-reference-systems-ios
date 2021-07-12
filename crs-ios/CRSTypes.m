//
//  CRSTypes.m
//  crs-ios
//
//  Created by Brian Osborn on 7/12/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSTypes.h"

@implementation CRSTypes

+(enum CRSCategoryType) categoryType: (enum CRSType) crsType{
    
    enum CRSCategoryType category;
    
    switch(crsType){
            
        case CRS_TYPE_BOUND:
        case CRS_TYPE_COMPOUND:
        case CRS_TYPE_DERIVED:
        case CRS_TYPE_ENGINEERING:
        case CRS_TYPE_GEODETIC:
        case CRS_TYPE_GEOGRAPHIC:
        case CRS_TYPE_PARAMETRIC:
        case CRS_TYPE_PROJECTED:
        case CRS_TYPE_TEMPORAL:
        case CRS_TYPE_VERTICAL:
            category = CRS_CATEGORY_CRS;
            break;
            
        case CRS_TYPE_CONCATENATED_OPERATION:
        case CRS_TYPE_COORDINATE_OPERATION:
        case CRS_TYPE_POINT_MOTION_OPERATION:
            category = CRS_CATEGORY_OPERATION;
            break;
            
        case CRS_TYPE_COORDINATE_METADATA:
            category = CRS_CATEGORY_METADATA;
            break;
            
        default:
            [NSException raise:@"Unsupported CRS Type" format:@"Unsupported CRS Type: %d", crsType];
    }
    
    return category;
}

@end
