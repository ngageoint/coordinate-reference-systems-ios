//
//  CRSProjectedCoordinateReferenceSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSProjectedCoordinateReferenceSystem.h>

@implementation CRSProjectedCoordinateReferenceSystem

+(CRSProjectedCoordinateReferenceSystem *) create{
    return [[CRSProjectedCoordinateReferenceSystem alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_PROJECTED];
    if(self != nil){
        _base = [CRSGeoCoordinateReferenceSystem create];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andBaseName: (NSString *) baseName andBaseType: (CRSType) baseType andReferenceFrame: (CRSGeoReferenceFrame *) referenceFrame andMapProjection: (CRSMapProjection *) mapProjection andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_PROJECTED andCoordinateSystem:coordinateSystem];
    if(self != nil){
        _base = [CRSGeoCoordinateReferenceSystem create];
        [self setBaseName:baseName];
        [self setBaseType:baseType];
        [self setReferenceFrame:referenceFrame];
        [self setMapProjection:mapProjection];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andBaseName: (NSString *) baseName andBaseType: (CRSType) baseType andDatumEnsemble: (CRSGeoDatumEnsemble *) datumEnsemble andMapProjection: (CRSMapProjection *) mapProjection andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_PROJECTED andCoordinateSystem:coordinateSystem];
    if(self != nil){
        _base = [CRSGeoCoordinateReferenceSystem create];
        [self setBaseName:baseName];
        [self setBaseType:baseType];
        [self setDatumEnsemble:datumEnsemble];
        [self setMapProjection:mapProjection];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andBaseName: (NSString *) baseName andBaseType: (CRSType) baseType andDynamic: (CRSDynamic *) dynamic andReferenceFrame: (CRSGeoReferenceFrame *) referenceFrame andMapProjection: (CRSMapProjection *) mapProjection andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_PROJECTED andCoordinateSystem:coordinateSystem];
    if(self != nil){
        _base = [CRSGeoCoordinateReferenceSystem create];
        [self setBaseName:baseName];
        [self setBaseType:baseType];
        [self setDynamic:dynamic];
        [self setReferenceFrame:referenceFrame];
        [self setMapProjection:mapProjection];
    }
    return self;
}

-(NSString *) baseName{
    return [self base].name;
}

-(void) setBaseName: (NSString *) baseName{
    [[self base] setName:baseName];
}

-(CRSType) baseType{
    return [self base].type;
}

-(void) setBaseType: (CRSType) baseType{
    [[self base] setType:baseType];
}

-(CRSGeoReferenceFrame *) referenceFrame{
    return [self base].referenceFrame;
}

-(BOOL) hasReferenceFrame{
    return [[self base] hasReferenceFrame];
}

-(void) setReferenceFrame: (CRSGeoReferenceFrame *) referenceFrame{
    [[self base] setReferenceFrame:referenceFrame];
}

-(CRSGeoDatumEnsemble *) datumEnsemble{
    return [self base].datumEnsemble;
}

-(BOOL) hasDatumEnsemble{
    return [[self base] hasDatumEnsemble];
}

-(void) setDatumEnsemble: (CRSGeoDatumEnsemble *) datumEnsemble{
    [[self base] setDatumEnsemble:datumEnsemble];
}

-(CRSDynamic *) dynamic{
    return [self base].dynamic;
}

-(BOOL) hasDynamic{
    return [[self base] hasDynamic];
}

-(void) setDynamic: (CRSDynamic *) dynamic{
    [[self base] setDynamic:dynamic];
}

-(NSObject<CRSGeoDatum> *) geoDatum{
    return [[self base] geoDatum];
}

-(NSMutableArray<CRSIdentifier *> *) baseIdentifiers{
    return [self base].identifiers;
}

-(BOOL) hasBaseIdentifiers{
    return [[self base] hasIdentifiers];
}

-(int) numBaseIdentifiers{
    return [[self base] numIdentifiers];
}

-(CRSIdentifier *) baseIdentifierAtIndex: (int) index{
    return [[self base] identifierAtIndex:index];
}

-(void) setBaseIdentifiers: (NSArray<CRSIdentifier *> *) baseIdentifiers{
    [[self base] setIdentifiers:[NSMutableArray arrayWithArray:baseIdentifiers]];
}

-(void) addBaseIdentifier: (CRSIdentifier *) baseIdentifier{
    [[self base] addIdentifier:baseIdentifier];
}

-(void) addBaseIdentifiers: (NSArray<CRSIdentifier *> *) baseIdentifiers{
    [[self base] addIdentifiers:baseIdentifiers];
}

-(CRSUnit *) unit{
    CRSUnit *unit = nil;
    CRSCoordinateSystem *cs = [self base].coordinateSystem;
    if(cs != nil){
        unit = cs.unit;
    }
    return unit;
}

-(BOOL) hasUnit{
    CRSCoordinateSystem *cs = [self base].coordinateSystem;
    return cs != nil && [cs hasUnit];
}

-(void) setUnit: (CRSUnit *) unit{
    CRSCoordinateSystem *cs = [self base].coordinateSystem;
    if(cs == nil){
        cs = [CRSCoordinateSystem create];
        
    }
    [cs setUnit:unit];
}

- (BOOL) isEqualToProjectedCoordinateReferenceSystem: (CRSProjectedCoordinateReferenceSystem *) projectedCoordinateReferenceSystem{
    if (self == projectedCoordinateReferenceSystem){
        return YES;
    }
    if (projectedCoordinateReferenceSystem == nil){
        return NO;
    }
    if (![super isEqual:projectedCoordinateReferenceSystem]){
        return NO;
    }
    if (_base == nil) {
        if (projectedCoordinateReferenceSystem.base != nil){
            return NO;
        }
    } else if (![_base isEqual:projectedCoordinateReferenceSystem.base]){
        return NO;
    }
    if (_mapProjection == nil) {
        if (projectedCoordinateReferenceSystem.mapProjection != nil){
            return NO;
        }
    } else if (![_mapProjection isEqual:projectedCoordinateReferenceSystem.mapProjection]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSProjectedCoordinateReferenceSystem class]]) {
        return NO;
    }
    
    return [self isEqualToProjectedCoordinateReferenceSystem:(CRSProjectedCoordinateReferenceSystem *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_base == nil) ? 0 : [_base hash]);
    result = prime * result + ((_mapProjection == nil) ? 0 : [_mapProjection hash]);
    return result;
}

@end
