//
//  CRSTemporalCoordinateReferenceSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSTemporalCoordinateReferenceSystem.h>

@implementation CRSTemporalCoordinateReferenceSystem

+(CRSTemporalCoordinateReferenceSystem *) create{
    return [[CRSTemporalCoordinateReferenceSystem alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_TEMPORAL];
    return self;
}

-(instancetype) initWithName: (NSString *) name andDatum: (CRSTemporalDatum *) temporalDatum andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_TEMPORAL andCoordinateSystem:coordinateSystem];
    if(self != nil){
        [self setDatum:temporalDatum];
    }
    return self;
}

- (BOOL) isEqualToTemporalCoordinateReferenceSystem: (CRSTemporalCoordinateReferenceSystem *) temporalCoordinateReferenceSystem{
    if (self == temporalCoordinateReferenceSystem){
        return YES;
    }
    if (temporalCoordinateReferenceSystem == nil){
        return NO;
    }
    if (![super isEqual:temporalCoordinateReferenceSystem]){
        return NO;
    }
    if (_datum == nil) {
        if (temporalCoordinateReferenceSystem.datum != nil){
            return NO;
        }
    } else if (![_datum isEqual:temporalCoordinateReferenceSystem.datum]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSTemporalCoordinateReferenceSystem class]]) {
        return NO;
    }
    
    return [self isEqualToTemporalCoordinateReferenceSystem:(CRSTemporalCoordinateReferenceSystem *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_datum == nil) ? 0 : [_datum hash]);
    return result;
}

@end
