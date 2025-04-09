//
//  CRSUnitTypes.m
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSUnitTypes.h>

NSString * const CRS_UNIT_ANGLE_NAME = @"ANGLEUNIT";
NSString * const CRS_UNIT_LENGTH_NAME = @"LENGTHUNIT";
NSString * const CRS_UNIT_PARAMETRIC_NAME = @"PARAMETRICUNIT";
NSString * const CRS_UNIT_SCALE_NAME = @"SCALEUNIT";
NSString * const CRS_UNIT_TIME_NAME = @"TIMEUNIT";
NSString * const CRS_UNIT_NAME = @"UNIT";

@implementation CRSUnitTypes

+(NSString *) name: (CRSUnitType) type{
    NSString * name = nil;
    
    switch(type){
        case CRS_UNIT_ANGLE:
            name = CRS_UNIT_ANGLE_NAME;
            break;
        case CRS_UNIT_LENGTH:
            name = CRS_UNIT_LENGTH_NAME;
            break;
        case CRS_UNIT_PARAMETRIC:
            name = CRS_UNIT_PARAMETRIC_NAME;
            break;
        case CRS_UNIT_SCALE:
            name = CRS_UNIT_SCALE_NAME;
            break;
        case CRS_UNIT_TIME:
            name = CRS_UNIT_TIME_NAME;
            break;
        case CRS_UNIT:
            name = CRS_UNIT_NAME;
            break;
        case CRS_UNIT_NONE:
            break;
    }
    
    return name;
}

+(CRSUnitType) type: (NSString *) name{
    CRSUnitType value = -1;
    
    if(name != nil){
        name = [name uppercaseString];
        NSDictionary *types = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInteger:CRS_UNIT_ANGLE], CRS_UNIT_ANGLE_NAME,
                               [NSNumber numberWithInteger:CRS_UNIT_LENGTH], CRS_UNIT_LENGTH_NAME,
                               [NSNumber numberWithInteger:CRS_UNIT_PARAMETRIC], CRS_UNIT_PARAMETRIC_NAME,
                               [NSNumber numberWithInteger:CRS_UNIT_SCALE], CRS_UNIT_SCALE_NAME,
                               [NSNumber numberWithInteger:CRS_UNIT_TIME], CRS_UNIT_TIME_NAME,
                               [NSNumber numberWithInteger:CRS_UNIT], CRS_UNIT_NAME,
                               nil
                               ];
        NSNumber *enumValue = [types objectForKey:name];
        if(enumValue != nil){
            value = (CRSUnitType)[enumValue intValue];
        }
    }
    
    return value;
}

@end
