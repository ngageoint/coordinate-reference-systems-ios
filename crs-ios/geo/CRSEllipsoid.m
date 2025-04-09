//
//  CRSEllipsoid.m
//  crs-ios
//
//  Created by Brian Osborn on 7/21/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSEllipsoid.h>
#import <CoordinateReferenceSystems/CRSWriter.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>

@implementation CRSEllipsoid

+(CRSEllipsoid *) create{
    return [[CRSEllipsoid alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithName: (NSString *) name andSemiMajorAxis: (double) semiMajorAxis andInverseFlattening: (double) inverseFlattening{
    self = [super init];
    if(self != nil){
        [self setName:name];
        [self setSemiMajorAxis:semiMajorAxis];
        [self setInverseFlattening:inverseFlattening];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andSemiMajorAxisText: (NSString *) semiMajorAxis andInverseFlatteningText: (NSString *) inverseFlattening{
    self = [super init];
    if(self != nil){
        [self setName:name];
        [self setSemiMajorAxisText:semiMajorAxis];
        [self setInverseFlatteningText:inverseFlattening];
    }
    return self;
}

-(CRSEllipsoidType) type{
    return CRS_ELLIPSOID_OBLATE;
}

-(void) setSemiMajorAxis: (double) semiMajorAxis{
    _semiMajorAxis = semiMajorAxis;
    _semiMajorAxisText = [CRSTextUtils textFromDouble:semiMajorAxis];
}

-(void) setSemiMajorAxisText: (NSString *) semiMajorAxisText{
    _semiMajorAxisText = semiMajorAxisText;
    _semiMajorAxis = [CRSTextUtils doubleFromString:semiMajorAxisText];
}

-(void) setInverseFlattening: (double) inverseFlattening{
    _inverseFlattening = inverseFlattening;
    _inverseFlatteningText = [CRSTextUtils textFromDouble:inverseFlattening];
}

-(void) setInverseFlatteningText: (NSString *) inverseFlatteningText{
    _inverseFlatteningText = inverseFlatteningText;
    _inverseFlattening = [CRSTextUtils doubleFromString:inverseFlatteningText];
}

-(BOOL) hasUnit{
    return [self unit] != nil;
}

-(double) poleRadius{
    double poleRadius;
    if(_inverseFlattening != 0){
        double flattening = 1.0 / _inverseFlattening;
        double eccentricity2 = 2 * flattening - flattening * flattening;
        poleRadius = _semiMajorAxis * sqrt(1.0 - eccentricity2);
    }else{
        poleRadius = _semiMajorAxis;
    }
    return poleRadius;
}

-(NSString *) poleRadiusText{
    NSString *poleRadius;
    if(_inverseFlattening != 0){
        double flattening = 1.0 / _inverseFlattening;
        double eccentricity2 = 2 * flattening - flattening * flattening;
        double value = _semiMajorAxis * sqrt(1.0 - eccentricity2);
        poleRadius = [CRSTextUtils textFromDouble:value];
    }else{
        poleRadius = _semiMajorAxisText;
    }
    return poleRadius;
}

-(BOOL) hasIdentifiers{
    return _identifiers != nil && _identifiers.count > 0;
}

-(int) numIdentifiers{
    return _identifiers != nil ? (int) _identifiers.count : 0;
}

-(CRSIdentifier *) identifierAtIndex: (int) index{
    return [_identifiers objectAtIndex:index];
}

-(void) addIdentifier: (CRSIdentifier *) identifier{
    if(_identifiers == nil){
        _identifiers = [NSMutableArray array];
    }
    [_identifiers addObject:identifier];
}

-(void) addIdentifiers: (NSArray<CRSIdentifier *> *) identifiers{
    if(_identifiers == nil){
        _identifiers = [NSMutableArray array];
    }
    [_identifiers addObjectsFromArray:identifiers];
}

- (BOOL) isEqualToEllipsoid: (CRSEllipsoid *) ellipsoid{
    if (self == ellipsoid){
        return YES;
    }
    if (ellipsoid == nil){
        return NO;
    }
    if (_name == nil) {
        if (ellipsoid.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:ellipsoid.name]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_semiMajorAxis] isEqual:[NSNumber numberWithDouble:ellipsoid.semiMajorAxis]]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_inverseFlattening] isEqual:[NSNumber numberWithDouble:ellipsoid.inverseFlattening]]){
        return NO;
    }
    if (_unit == nil) {
        if (ellipsoid.unit != nil){
            return NO;
        }
    } else if (![_unit isEqual:ellipsoid.unit]){
        return NO;
    }
    if (_identifiers == nil) {
        if (ellipsoid.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:ellipsoid.identifiers]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSEllipsoid class]]) {
        return NO;
    }
    
    return [self isEqualToEllipsoid:(CRSEllipsoid *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + [[NSNumber numberWithDouble:_semiMajorAxis] hash];
    result = prime * result + [[NSNumber numberWithDouble:_inverseFlattening] hash];
    result = prime * result + ((_unit == nil) ? 0 : [_unit hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeEllipsoid:self];
    return [writer description];
}

@end
