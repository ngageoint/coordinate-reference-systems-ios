//
//  CRSEllipsoidTypes.m
//  crs-ios
//
//  Created by Brian Osborn on 7/21/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSEllipsoidTypes.h"

NSString * const CRS_ELLIPSOID_OBLATE_NAME = @"OBLATE";
NSString * const CRS_ELLIPSOID_TRIAXIAL_NAME = @"TRIAXIAL";

@implementation CRSEllipsoidTypes

+(NSString *) name: (enum CRSEllipsoidType) type{
    NSString * name = nil;
    
    switch(type){
        case CRS_ELLIPSOID_OBLATE:
            name = CRS_ELLIPSOID_OBLATE_NAME;
            break;
        case CRS_ELLIPSOID_TRIAXIAL:
            name = CRS_ELLIPSOID_TRIAXIAL_NAME;
            break;
    }
    
    return name;
}

+(enum CRSEllipsoidType) type: (NSString *) name{
    enum CRSEllipsoidType value = -1;
    
    if(name != nil){
        name = [name uppercaseString];
        NSDictionary *types = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInteger:CRS_ELLIPSOID_OBLATE], CRS_ELLIPSOID_OBLATE_NAME,
                               [NSNumber numberWithInteger:CRS_ELLIPSOID_TRIAXIAL], CRS_ELLIPSOID_TRIAXIAL_NAME,
                               nil
                               ];
        NSNumber *enumValue = [types objectForKey:name];
        if(enumValue != nil){
            value = (enum CRSEllipsoidType)[enumValue intValue];
        }
    }
    
    return value;
}

@end
