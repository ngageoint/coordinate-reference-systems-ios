//
//  CRSOperationTypes.m
//  crs-ios
//
//  Created by Brian Osborn on 7/16/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSOperationTypes.h>

NSString * const CRS_OPERATION_COORDINATE_NAME = @"COORDINATE";
NSString * const CRS_OPERATION_POINT_MOTION_NAME = @"POINT_MOTION";
NSString * const CRS_OPERATION_MAP_PROJECTION_NAME = @"MAP_PROJECTION";
NSString * const CRS_OPERATION_DERIVING_CONVERSION_NAME = @"DERIVING_CONVERSION";
NSString * const CRS_OPERATION_ABRIDGED_COORDINATE_TRANSFORMATION_NAME = @"ABRIDGED_COORDINATE_TRANSFORMATION";

@implementation CRSOperationTypes

+(NSString *) name: (CRSOperationType) type{
    NSString * name = nil;
    
    switch(type){
        case CRS_OPERATION_COORDINATE:
            name = CRS_OPERATION_COORDINATE_NAME;
            break;
        case CRS_OPERATION_POINT_MOTION:
            name = CRS_OPERATION_POINT_MOTION_NAME;
            break;
        case CRS_OPERATION_MAP_PROJECTION:
            name = CRS_OPERATION_MAP_PROJECTION_NAME;
            break;
        case CRS_OPERATION_DERIVING_CONVERSION:
            name = CRS_OPERATION_DERIVING_CONVERSION_NAME;
            break;
        case CRS_OPERATION_ABRIDGED_COORDINATE_TRANSFORMATION:
            name = CRS_OPERATION_ABRIDGED_COORDINATE_TRANSFORMATION_NAME;
            break;
    }
    
    return name;
}

+(CRSOperationType) type: (NSString *) name{
    CRSOperationType value = -1;
    
    if(name != nil){
        name = [name uppercaseString];
        NSDictionary *types = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInteger:CRS_OPERATION_COORDINATE], CRS_OPERATION_COORDINATE_NAME,
                               [NSNumber numberWithInteger:CRS_OPERATION_POINT_MOTION], CRS_OPERATION_POINT_MOTION_NAME,
                               [NSNumber numberWithInteger:CRS_OPERATION_MAP_PROJECTION], CRS_OPERATION_MAP_PROJECTION_NAME,
                               [NSNumber numberWithInteger:CRS_OPERATION_DERIVING_CONVERSION], CRS_OPERATION_DERIVING_CONVERSION_NAME,
                               [NSNumber numberWithInteger:CRS_OPERATION_ABRIDGED_COORDINATE_TRANSFORMATION], CRS_OPERATION_ABRIDGED_COORDINATE_TRANSFORMATION_NAME,
                               nil
                               ];
        NSNumber *enumValue = [types objectForKey:name];
        if(enumValue != nil){
            value = (CRSOperationType)[enumValue intValue];
        }
    }
    
    return value;
}

@end
