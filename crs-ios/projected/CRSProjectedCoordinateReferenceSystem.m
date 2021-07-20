//
//  CRSProjectedCoordinateReferenceSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSProjectedCoordinateReferenceSystem.h"

@implementation CRSProjectedCoordinateReferenceSystem

+(CRSProjectedCoordinateReferenceSystem *) create{
    return [[CRSProjectedCoordinateReferenceSystem alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_PROJECTED];
    return self;
}

-(instancetype) initWithName: (NSString *) name andBaseName: (NSString *) baseName andBaseType: (enum CRSType) baseType andReferenceFrame: (CRSGeoReferenceFrame *) referenceFrame andMapProjection: (CRSMapProjection *) mapProjection andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_PROJECTED andCoordinateSystem:coordinateSystem];
    if(self != nil){
        [self setBaseName:baseName];
        [self setBaseType:baseType];
        [self setReferenceFrame:referenceFrame];
        [self setMapProjection:mapProjection];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andBaseName: (NSString *) baseName andBaseType: (enum CRSType) baseType andDatumEnsemble: (CRSGeoDatumEnsemble *) datumEnsemble andMapProjection: (CRSMapProjection *) mapProjection andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_PROJECTED andCoordinateSystem:coordinateSystem];
    if(self != nil){
        [self setBaseName:baseName];
        [self setBaseType:baseType];
        [self setDatumEnsemble:datumEnsemble];
        [self setMapProjection:mapProjection];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andBaseName: (NSString *) baseName andBaseType: (enum CRSType) baseType andDynamic: (CRSDynamic *) dynamic andReferenceFrame: (CRSGeoReferenceFrame *) referenceFrame andMapProjection: (CRSMapProjection *) mapProjection andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_PROJECTED andCoordinateSystem:coordinateSystem];
    if(self != nil){
        [self setBaseName:baseName];
        [self setBaseType:baseType];
        [self setDynamic:dynamic];
        [self setReferenceFrame:referenceFrame];
        [self setMapProjection:mapProjection];
    }
    return self;
}

// TODO

- (BOOL) equals: (CRSProjectedCoordinateReferenceSystem *) projectedCoordinateReferenceSystem{
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
    
    return [self equals:(CRSProjectedCoordinateReferenceSystem *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_base == nil) ? 0 : [_base hash]);
    result = prime * result + ((_mapProjection == nil) ? 0 : [_mapProjection hash]);
    return result;
}

@end
