//
//  CRSGeoCoordinateReferenceSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSGeoCoordinateReferenceSystem.h>

@implementation CRSGeoCoordinateReferenceSystem

+(CRSGeoCoordinateReferenceSystem *) create{
    return [[CRSGeoCoordinateReferenceSystem alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithType: (CRSType) type{
    self = [super initWithType:type];
    return self;
}

-(instancetype) initWithName: (NSString *) name andType: (CRSType) type andReferenceFrame: (CRSGeoReferenceFrame *) referenceFrame andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:type andCoordinateSystem:coordinateSystem];
    if(self != nil){
        [self setReferenceFrame:referenceFrame];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andType: (CRSType) type andDatumEnsemble: (CRSGeoDatumEnsemble *) datumEnsemble andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:type andCoordinateSystem:coordinateSystem];
    if(self != nil){
        [self setDatumEnsemble:datumEnsemble];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andType: (CRSType) type andDynamic: (CRSDynamic *) dynamic andReferenceFrame: (CRSGeoReferenceFrame *) referenceFrame andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:type andCoordinateSystem:coordinateSystem];
    if(self != nil){
        [self setDynamic:dynamic];
        [self setReferenceFrame:referenceFrame];
    }
    return self;
}

-(BOOL) hasReferenceFrame{
    return [self referenceFrame] != nil;
}

-(BOOL) hasDatumEnsemble{
    return [self datumEnsemble] != nil;
}

-(BOOL) hasDynamic{
    return [self dynamic] != nil;
}

-(NSObject<CRSGeoDatum> *) geoDatum{
    NSObject<CRSGeoDatum> *datum = nil;
    if([self hasReferenceFrame]){
        datum = [self referenceFrame];
    }else if([self hasDatumEnsemble]){
        datum = [self datumEnsemble];
    }
    return datum;
}

- (BOOL) isEqualToGeoCoordinateReferenceSystem: (CRSGeoCoordinateReferenceSystem *) geoCoordinateReferenceSystem{
    if (self == geoCoordinateReferenceSystem){
        return YES;
    }
    if (geoCoordinateReferenceSystem == nil){
        return NO;
    }
    if (![super isEqual:geoCoordinateReferenceSystem]){
        return NO;
    }
    if (_referenceFrame == nil) {
        if (geoCoordinateReferenceSystem.referenceFrame != nil){
            return NO;
        }
    } else if (![_referenceFrame isEqual:geoCoordinateReferenceSystem.referenceFrame]){
        return NO;
    }
    if (_datumEnsemble == nil) {
        if (geoCoordinateReferenceSystem.datumEnsemble != nil){
            return NO;
        }
    } else if (![_datumEnsemble isEqual:geoCoordinateReferenceSystem.datumEnsemble]){
        return NO;
    }
    if (_dynamic == nil) {
        if (geoCoordinateReferenceSystem.dynamic != nil){
            return NO;
        }
    } else if (![_dynamic isEqual:geoCoordinateReferenceSystem.dynamic]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSGeoCoordinateReferenceSystem class]]) {
        return NO;
    }
    
    return [self isEqualToGeoCoordinateReferenceSystem:(CRSGeoCoordinateReferenceSystem *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_referenceFrame == nil) ? 0 : [_referenceFrame hash]);
    result = prime * result + ((_datumEnsemble == nil) ? 0 : [_datumEnsemble hash]);
    result = prime * result + ((_dynamic == nil) ? 0 : [_dynamic hash]);
    return result;
}

@end
