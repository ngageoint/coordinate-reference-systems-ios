//
//  CRSCoordinateSystemTypes.m
//  crs-ios
//
//  Created by Brian Osborn on 7/15/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSCoordinateSystemTypes.h>

NSString * const CRS_CS_AFFINE_NAME = @"affine";
NSString * const CRS_CS_CARTESIAN_NAME = @"Cartesian";
NSString * const CRS_CS_CYLINDRICAL_NAME = @"cylindrical";
NSString * const CRS_CS_ELLIPSOIDAL_NAME = @"ellipsoidal";
NSString * const CRS_CS_LINEAR_NAME = @"linear";
NSString * const CRS_CS_ORDINAL_NAME = @"ordinal";
NSString * const CRS_CS_PARAMETRIC_NAME = @"parametric";
NSString * const CRS_CS_POLAR_NAME = @"polar";
NSString * const CRS_CS_SPHERICAL_NAME = @"spherical";
NSString * const CRS_CS_TEMPORAL_COUNT_NAME = @"temporalCount";
NSString * const CRS_CS_TEMPORAL_DATE_TIME_NAME = @"temporalDateTime";
NSString * const CRS_CS_TEMPORAL_MEASURE_NAME = @"temporalMeasure";
NSString * const CRS_CS_VERTICAL_NAME = @"vertical";

@implementation CRSCoordinateSystemTypes

+(NSString *) name: (CRSCoordinateSystemType) type{
    NSString * name = nil;
    
    switch(type){
        case CRS_CS_AFFINE:
            name = CRS_CS_AFFINE_NAME;
            break;
        case CRS_CS_CARTESIAN:
            name = CRS_CS_CARTESIAN_NAME;
            break;
        case CRS_CS_CYLINDRICAL:
            name = CRS_CS_CYLINDRICAL_NAME;
            break;
        case CRS_CS_ELLIPSOIDAL:
            name = CRS_CS_ELLIPSOIDAL_NAME;
            break;
        case CRS_CS_LINEAR:
            name = CRS_CS_LINEAR_NAME;
            break;
        case CRS_CS_ORDINAL:
            name = CRS_CS_ORDINAL_NAME;
            break;
        case CRS_CS_PARAMETRIC:
            name = CRS_CS_PARAMETRIC_NAME;
            break;
        case CRS_CS_POLAR:
            name = CRS_CS_POLAR_NAME;
            break;
        case CRS_CS_SPHERICAL:
            name = CRS_CS_SPHERICAL_NAME;
            break;
        case CRS_CS_TEMPORAL_COUNT:
            name = CRS_CS_TEMPORAL_COUNT_NAME;
            break;
        case CRS_CS_TEMPORAL_DATE_TIME:
            name = CRS_CS_TEMPORAL_DATE_TIME_NAME;
            break;
        case CRS_CS_TEMPORAL_MEASURE:
            name = CRS_CS_TEMPORAL_MEASURE_NAME;
            break;
        case CRS_CS_VERTICAL:
            name = CRS_CS_VERTICAL_NAME;
            break;
    }
    
    return name;
}

+(CRSCoordinateSystemType) type: (NSString *) name{
    CRSCoordinateSystemType value = -1;
    
    if(name != nil){
        name = [name uppercaseString];
        NSDictionary *types = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInteger:CRS_CS_AFFINE], [CRS_CS_AFFINE_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_CS_CARTESIAN], [CRS_CS_CARTESIAN_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_CS_CYLINDRICAL], [CRS_CS_CYLINDRICAL_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_CS_ELLIPSOIDAL], [CRS_CS_ELLIPSOIDAL_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_CS_LINEAR], [CRS_CS_LINEAR_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_CS_ORDINAL], [CRS_CS_ORDINAL_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_CS_PARAMETRIC], [CRS_CS_PARAMETRIC_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_CS_POLAR], [CRS_CS_POLAR_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_CS_SPHERICAL], [CRS_CS_SPHERICAL_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_CS_TEMPORAL_COUNT], [CRS_CS_TEMPORAL_COUNT_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_CS_TEMPORAL_DATE_TIME], [CRS_CS_TEMPORAL_DATE_TIME_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_CS_TEMPORAL_MEASURE], [CRS_CS_TEMPORAL_MEASURE_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_CS_VERTICAL], [CRS_CS_VERTICAL_NAME uppercaseString],
                               nil
                               ];
        NSNumber *enumValue = [types objectForKey:name];
        if(enumValue != nil){
            value = (CRSCoordinateSystemType)[enumValue intValue];
        }
    }
    
    return value;
}

@end
