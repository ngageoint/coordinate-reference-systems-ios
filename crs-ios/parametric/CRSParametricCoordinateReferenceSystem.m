//
//  CRSParametricCoordinateReferenceSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSParametricCoordinateReferenceSystem.h>

@implementation CRSParametricCoordinateReferenceSystem

+(CRSParametricCoordinateReferenceSystem *) create{
    return [[CRSParametricCoordinateReferenceSystem alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_PARAMETRIC];
    return self;
}

-(instancetype) initWithName: (NSString *) name andDatum: (CRSParametricDatum *) parametricDatum andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_PARAMETRIC andCoordinateSystem:coordinateSystem];
    if(self != nil){
        [self setDatum:parametricDatum];
    }
    return self;
}

- (BOOL) isEqualToParametricCoordinateReferenceSystem: (CRSParametricCoordinateReferenceSystem *) parametricCoordinateReferenceSystem{
    if (self == parametricCoordinateReferenceSystem){
        return YES;
    }
    if (parametricCoordinateReferenceSystem == nil){
        return NO;
    }
    if (![super isEqual:parametricCoordinateReferenceSystem]){
        return NO;
    }
    if (_datum == nil) {
        if (parametricCoordinateReferenceSystem.datum != nil){
            return NO;
        }
    } else if (![_datum isEqual:parametricCoordinateReferenceSystem.datum]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSParametricCoordinateReferenceSystem class]]) {
        return NO;
    }
    
    return [self isEqualToParametricCoordinateReferenceSystem:(CRSParametricCoordinateReferenceSystem *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_datum == nil) ? 0 : [_datum hash]);
    return result;
}

@end
