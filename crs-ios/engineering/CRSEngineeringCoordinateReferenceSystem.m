//
//  CRSEngineeringCoordinateReferenceSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSEngineeringCoordinateReferenceSystem.h>

@implementation CRSEngineeringCoordinateReferenceSystem

+(CRSEngineeringCoordinateReferenceSystem *) create{
    return [[CRSEngineeringCoordinateReferenceSystem alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_ENGINEERING];
    return self;
}

-(instancetype) initWithName: (NSString *) name andDatum: (CRSEngineeringDatum *) engineeringDatum andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_ENGINEERING andCoordinateSystem:coordinateSystem];
    if(self != nil){
        [self setDatum:engineeringDatum];
    }
    return self;
}

- (BOOL) isEqualToEngineeringCoordinateReferenceSystem: (CRSEngineeringCoordinateReferenceSystem *) engineeringCoordinateReferenceSystem{
    if (self == engineeringCoordinateReferenceSystem){
        return YES;
    }
    if (engineeringCoordinateReferenceSystem == nil){
        return NO;
    }
    if (![super isEqual:engineeringCoordinateReferenceSystem]){
        return NO;
    }
    if (_datum == nil) {
        if (engineeringCoordinateReferenceSystem.datum != nil){
            return NO;
        }
    } else if (![_datum isEqual:engineeringCoordinateReferenceSystem.datum]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSEngineeringCoordinateReferenceSystem class]]) {
        return NO;
    }
    
    return [self isEqualToEngineeringCoordinateReferenceSystem:(CRSEngineeringCoordinateReferenceSystem *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_datum == nil) ? 0 : [_datum hash]);
    return result;
}

@end
