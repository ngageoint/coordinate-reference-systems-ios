//
//  CRSCategoryTypes.m
//  crs-ios
//
//  Created by Brian Osborn on 7/12/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSCategoryTypes.h>

NSString * const CRS_CATEGORY_CRS_NAME = @"CRS";
NSString * const CRS_CATEGORY_OPERATION_NAME = @"OPERATION";
NSString * const CRS_CATEGORY_METADATA_NAME = @"METADATA";

@implementation CRSCategoryTypes

+(NSString *) name: (CRSCategoryType) type{
    NSString * name = nil;
    
    switch(type){
        case CRS_CATEGORY_CRS:
            name = CRS_CATEGORY_CRS_NAME;
            break;
        case CRS_CATEGORY_OPERATION:
            name = CRS_CATEGORY_OPERATION_NAME;
            break;
        case CRS_CATEGORY_METADATA:
            name = CRS_CATEGORY_METADATA_NAME;
            break;
    }
    
    return name;
}

+(CRSCategoryType) type: (NSString *) name{
    CRSCategoryType value = -1;
    
    if(name != nil){
        name = [name uppercaseString];
        NSDictionary *types = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInteger:CRS_CATEGORY_CRS], CRS_CATEGORY_CRS_NAME,
                               [NSNumber numberWithInteger:CRS_CATEGORY_OPERATION], CRS_CATEGORY_OPERATION_NAME,
                               [NSNumber numberWithInteger:CRS_CATEGORY_METADATA], CRS_CATEGORY_METADATA_NAME,
                               nil
                               ];
        NSNumber *enumValue = [types objectForKey:name];
        if(enumValue != nil){
            value = (CRSCategoryType)[enumValue intValue];
        }
    }
    
    return value;
}

@end
