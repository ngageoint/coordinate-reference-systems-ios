//
//  CRSTriaxialEllipsoid.m
//  crs-ios
//
//  Created by Brian Osborn on 7/22/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSTriaxialEllipsoid.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>

@implementation CRSTriaxialEllipsoid

+(CRSTriaxialEllipsoid *) create{
    return [[CRSTriaxialEllipsoid alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithName: (NSString *) name andSemiMajorAxis: (double) semiMajorAxis andSemiMedianAxis: (double) semiMedianAxis andSemiMinorAxis: (double) semiMinorAxis{
    self = [super init];
    if(self != nil){
        [self setName:name];
        [self setSemiMajorAxis:semiMajorAxis];
        [self setSemiMedianAxis:semiMedianAxis];
        [self setSemiMinorAxis:semiMinorAxis];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andSemiMajorAxisText: (NSString *) semiMajorAxis andSemiMedianAxisText: (NSString *) semiMedianAxis andSemiMinorAxisText: (NSString *) semiMinorAxis{
    self = [super init];
    if(self != nil){
        [self setName:name];
        [self setSemiMajorAxisText:semiMajorAxis];
        [self setSemiMedianAxisText:semiMedianAxis];
        [self setSemiMinorAxisText:semiMinorAxis];
    }
    return self;
}

-(CRSEllipsoidType) type{
    return CRS_ELLIPSOID_TRIAXIAL;
}

-(double) inverseFlattening{
    [NSException raise:@"Not Supported" format:@"Triaxial Ellipsoid does not support inverse flattening"];
    return -1;
}

-(void) setInverseFlattening: (double) inverseFlattening{
    [NSException raise:@"Not Supported" format:@"Triaxial Ellipsoid does not support inverse flattening"];
}

-(void) setSemiMedianAxis: (double) semiMedianAxis{
    _semiMedianAxis = semiMedianAxis;
    _semiMedianAxisText = [CRSTextUtils textFromDouble:semiMedianAxis];
}

-(void) setSemiMedianAxisText: (NSString *) semiMedianAxisText{
    _semiMedianAxisText = semiMedianAxisText;
    _semiMedianAxis = [CRSTextUtils doubleFromString:semiMedianAxisText];
}

-(void) setSemiMinorAxis: (double) semiMinorAxis{
    _semiMinorAxis = semiMinorAxis;
    _semiMinorAxisText = [CRSTextUtils textFromDouble:semiMinorAxis];
}

-(void) setSemiMinorAxisText: (NSString *) semiMinorAxisText{
    _semiMinorAxisText = semiMinorAxisText;
    _semiMinorAxis = [CRSTextUtils doubleFromString:semiMinorAxisText];
}

- (BOOL) isEqualToTriaxialEllipsoid: (CRSTriaxialEllipsoid *) triaxialEllipsoid{
    if (self == triaxialEllipsoid){
        return YES;
    }
    if (triaxialEllipsoid == nil){
        return NO;
    }
    if (![super isEqual:triaxialEllipsoid]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_semiMedianAxis] isEqual:[NSNumber numberWithDouble:triaxialEllipsoid.semiMedianAxis]]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_semiMinorAxis] isEqual:[NSNumber numberWithDouble:triaxialEllipsoid.semiMinorAxis]]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSTriaxialEllipsoid class]]) {
        return NO;
    }
    
    return [self isEqualToTriaxialEllipsoid:(CRSTriaxialEllipsoid *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + [[NSNumber numberWithDouble:_semiMedianAxis] hash];
    result = prime * result + [[NSNumber numberWithDouble:_semiMinorAxis] hash];
    return result;
}

@end
