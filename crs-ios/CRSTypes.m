//
//  CRSTypes.m
//  crs-ios
//
//  Created by Brian Osborn on 7/12/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSTypes.h>

NSString * const CRS_TYPE_BOUND_NAME = @"BOUND";
NSString * const CRS_TYPE_COMPOUND_NAME = @"COMPOUND";
NSString * const CRS_TYPE_CONCATENATED_OPERATION_NAME = @"CONCATENATED_OPERATION";
NSString * const CRS_TYPE_COORDINATE_METADATA_NAME = @"COORDINATE_METADATA";
NSString * const CRS_TYPE_COORDINATE_OPERATION_NAME = @"COORDINATE_OPERATION";
NSString * const CRS_TYPE_DERIVED_NAME = @"DERIVED";
NSString * const CRS_TYPE_ENGINEERING_NAME = @"ENGINEERING";
NSString * const CRS_TYPE_GEODETIC_NAME = @"GEODETIC";
NSString * const CRS_TYPE_GEOGRAPHIC_NAME = @"GEOGRAPHIC";
NSString * const CRS_TYPE_PARAMETRIC_NAME = @"PARAMETRIC";
NSString * const CRS_TYPE_POINT_MOTION_OPERATION_NAME = @"POINT_MOTION_OPERATION";
NSString * const CRS_TYPE_PROJECTED_NAME = @"PROJECTED";
NSString * const CRS_TYPE_TEMPORAL_NAME = @"TEMPORAL";
NSString * const CRS_TYPE_VERTICAL_NAME = @"VERTICAL";

@implementation CRSTypes

+(NSString *) name: (CRSType) type{
    NSString * name = nil;
    
    switch(type){
        case CRS_TYPE_BOUND:
            name = CRS_TYPE_BOUND_NAME;
            break;
        case CRS_TYPE_COMPOUND:
            name = CRS_TYPE_COMPOUND_NAME;
            break;
        case CRS_TYPE_CONCATENATED_OPERATION:
            name = CRS_TYPE_CONCATENATED_OPERATION_NAME;
            break;
        case CRS_TYPE_COORDINATE_METADATA:
            name = CRS_TYPE_COORDINATE_METADATA_NAME;
            break;
        case CRS_TYPE_COORDINATE_OPERATION:
            name = CRS_TYPE_COORDINATE_OPERATION_NAME;
            break;
        case CRS_TYPE_DERIVED:
            name = CRS_TYPE_DERIVED_NAME;
            break;
        case CRS_TYPE_ENGINEERING:
            name = CRS_TYPE_ENGINEERING_NAME;
            break;
        case CRS_TYPE_GEODETIC:
            name = CRS_TYPE_GEODETIC_NAME;
            break;
        case CRS_TYPE_GEOGRAPHIC:
            name = CRS_TYPE_GEOGRAPHIC_NAME;
            break;
        case CRS_TYPE_PARAMETRIC:
            name = CRS_TYPE_PARAMETRIC_NAME;
            break;
        case CRS_TYPE_POINT_MOTION_OPERATION:
            name = CRS_TYPE_POINT_MOTION_OPERATION_NAME;
            break;
        case CRS_TYPE_PROJECTED:
            name = CRS_TYPE_PROJECTED_NAME;
            break;
        case CRS_TYPE_TEMPORAL:
            name = CRS_TYPE_TEMPORAL_NAME;
            break;
        case CRS_TYPE_VERTICAL:
            name = CRS_TYPE_VERTICAL_NAME;
            break;
    }
    
    return name;
}

+(NSArray<NSString *> *) names: (NSArray<NSNumber *> *) types{
    NSMutableArray<NSString *> *names = [NSMutableArray array];
    for(NSNumber *type in types){
        [names addObject:[self name:[type intValue]]];
    }
    return names;
}

+(CRSType) type: (NSString *) name{
    CRSType value = -1;
    
    if(name != nil){
        name = [name uppercaseString];
        NSDictionary *types = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInteger:CRS_TYPE_BOUND], CRS_TYPE_BOUND_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_COMPOUND], CRS_TYPE_COMPOUND_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_CONCATENATED_OPERATION], CRS_TYPE_CONCATENATED_OPERATION_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_COORDINATE_METADATA], CRS_TYPE_COORDINATE_METADATA_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_COORDINATE_OPERATION], CRS_TYPE_COORDINATE_OPERATION_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_DERIVED], CRS_TYPE_DERIVED_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_ENGINEERING], CRS_TYPE_ENGINEERING_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_GEODETIC], CRS_TYPE_GEODETIC_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_GEOGRAPHIC], CRS_TYPE_GEOGRAPHIC_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_PARAMETRIC], CRS_TYPE_PARAMETRIC_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_POINT_MOTION_OPERATION], CRS_TYPE_POINT_MOTION_OPERATION_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_PROJECTED], CRS_TYPE_PROJECTED_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_TEMPORAL], CRS_TYPE_TEMPORAL_NAME,
                               [NSNumber numberWithInteger:CRS_TYPE_VERTICAL], CRS_TYPE_VERTICAL_NAME,
                               nil
                               ];
        NSNumber *enumValue = [types objectForKey:name];
        if(enumValue != nil){
            value = (CRSType)[enumValue intValue];
        }
    }
    
    return value;
}

+(CRSCategoryType) categoryType: (CRSType) crsType{
    
    CRSCategoryType category = -1;
    
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
            [NSException raise:@"Unsupported CRS Type" format:@"Unsupported CRS Type: %@", [CRSTypes name:crsType]];
    }
    
    return category;
}

@end
