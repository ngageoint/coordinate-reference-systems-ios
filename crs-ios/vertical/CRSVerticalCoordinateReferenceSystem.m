//
//  CRSVerticalCoordinateReferenceSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/21/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSVerticalCoordinateReferenceSystem.h>

@implementation CRSVerticalCoordinateReferenceSystem

+(CRSVerticalCoordinateReferenceSystem *) create{
    return [[CRSVerticalCoordinateReferenceSystem alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_VERTICAL];
    return self;
}

-(instancetype) initWithName: (NSString *) name andReferenceFrame: (CRSVerticalReferenceFrame *) referenceFrame andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_VERTICAL andCoordinateSystem:coordinateSystem];
    if(self != nil){
        [self setReferenceFrame:referenceFrame];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andDatumEnsemble: (CRSVerticalDatumEnsemble *) datumEnsemble andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_VERTICAL andCoordinateSystem:coordinateSystem];
    if(self != nil){
        [self setDatumEnsemble:datumEnsemble];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andDynamic: (CRSDynamic *) dynamic andReferenceFrame: (CRSVerticalReferenceFrame *) referenceFrame andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_VERTICAL andCoordinateSystem:coordinateSystem];
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

-(BOOL) hasGeoidModelName{
    return [self geoidModelName] != nil;
}

-(BOOL) hasGeoidModelIdentifier{
    return [self geoidModelIdentifier] != nil;
}

- (BOOL) isEqualToVerticalCoordinateReferenceSystem: (CRSVerticalCoordinateReferenceSystem *) verticalCoordinateReferenceSystem{
    if (self == verticalCoordinateReferenceSystem){
        return YES;
    }
    if (verticalCoordinateReferenceSystem == nil){
        return NO;
    }
    if (![super isEqual:verticalCoordinateReferenceSystem]){
        return NO;
    }
    if (_referenceFrame == nil) {
        if (verticalCoordinateReferenceSystem.referenceFrame != nil){
            return NO;
        }
    } else if (![_referenceFrame isEqual:verticalCoordinateReferenceSystem.referenceFrame]){
        return NO;
    }
    if (_datumEnsemble == nil) {
        if (verticalCoordinateReferenceSystem.datumEnsemble != nil){
            return NO;
        }
    } else if (![_datumEnsemble isEqual:verticalCoordinateReferenceSystem.datumEnsemble]){
        return NO;
    }
    if (_dynamic == nil) {
        if (verticalCoordinateReferenceSystem.dynamic != nil){
            return NO;
        }
    } else if (![_dynamic isEqual:verticalCoordinateReferenceSystem.dynamic]){
        return NO;
    }
    if (_geoidModelName == nil) {
        if (verticalCoordinateReferenceSystem.geoidModelName != nil){
            return NO;
        }
    } else if (![_geoidModelName isEqual:verticalCoordinateReferenceSystem.geoidModelName]){
        return NO;
    }
    if (_geoidModelIdentifier == nil) {
        if (verticalCoordinateReferenceSystem.geoidModelIdentifier != nil){
            return NO;
        }
    } else if (![_geoidModelIdentifier isEqual:verticalCoordinateReferenceSystem.geoidModelIdentifier]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSVerticalCoordinateReferenceSystem class]]) {
        return NO;
    }
    
    return [self isEqualToVerticalCoordinateReferenceSystem:(CRSVerticalCoordinateReferenceSystem *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_referenceFrame == nil) ? 0 : [_referenceFrame hash]);
    result = prime * result + ((_datumEnsemble == nil) ? 0 : [_datumEnsemble hash]);
    result = prime * result + ((_dynamic == nil) ? 0 : [_dynamic hash]);
    result = prime * result + ((_geoidModelName == nil) ? 0 : [_geoidModelName hash]);
    result = prime * result + ((_geoidModelIdentifier == nil) ? 0 : [_geoidModelIdentifier hash]);
    return result;
}

@end
