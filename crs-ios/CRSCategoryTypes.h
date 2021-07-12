//
//  CRSCategoryTypes.h
//  crs-ios
//
//  Created by Brian Osborn on 7/12/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Well-known text representation of coordinate reference systems category type
 */
enum CRSCategoryType{
    CRS_CATEGORY_CRS,
    CRS_CATEGORY_OPERATION,
    CRS_CATEGORY_METADATA
};

@interface CRSCategoryTypes : NSObject

@end
