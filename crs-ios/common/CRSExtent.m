//
//  CRSExtent.m
//  crs-ios
//
//  Created by Brian Osborn on 7/14/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSExtent.h>
#import <CoordinateReferenceSystems/CRSWriter.h>

@implementation CRSExtent

+(CRSExtent *) create{
    return [[CRSExtent alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(BOOL) hasAreaDescription{
    return [self areaDescription] != nil;
}

-(BOOL) hasGeographicBoundingBox{
    return [self geographicBoundingBox] != nil;
}

-(BOOL) hasVerticalExtent{
    return [self verticalExtent] != nil;
}

-(BOOL) hasTemporalExtent{
    return [self temporalExtent] != nil;
}

- (BOOL) isEqualToExtent: (CRSExtent *) extent{
    if (self == extent){
        return YES;
    }
    if (extent == nil){
        return NO;
    }
    if (_areaDescription == nil) {
        if (extent.areaDescription != nil){
            return NO;
        }
    } else if (![_areaDescription isEqualToString:extent.areaDescription]){
        return NO;
    }
    if (_geographicBoundingBox == nil) {
        if (extent.geographicBoundingBox != nil){
            return NO;
        }
    } else if (![_geographicBoundingBox isEqual:extent.geographicBoundingBox]){
        return NO;
    }
    if (_verticalExtent == nil) {
        if (extent.verticalExtent != nil){
            return NO;
        }
    } else if (![_verticalExtent isEqual:extent.verticalExtent]){
        return NO;
    }
    if (_temporalExtent == nil) {
        if (extent.temporalExtent != nil){
            return NO;
        }
    } else if (![_temporalExtent isEqual:extent.temporalExtent]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSExtent class]]) {
        return NO;
    }
    
    return [self isEqualToExtent:(CRSExtent *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_areaDescription == nil) ? 0 : [_areaDescription hash]);
    result = prime * result + ((_geographicBoundingBox == nil) ? 0 : [_geographicBoundingBox hash]);
    result = prime * result + ((_verticalExtent == nil) ? 0 : [_verticalExtent hash]);
    result = prime * result + ((_temporalExtent == nil) ? 0 : [_temporalExtent hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeExtent:self];
    return [writer description];
}

@end
