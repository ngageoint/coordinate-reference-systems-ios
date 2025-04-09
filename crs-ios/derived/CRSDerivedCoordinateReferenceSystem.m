//
//  CRSDerivedCoordinateReferenceSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSDerivedCoordinateReferenceSystem.h>

@implementation CRSDerivedCoordinateReferenceSystem

+(CRSDerivedCoordinateReferenceSystem *) create{
    return [[CRSDerivedCoordinateReferenceSystem alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_DERIVED];
    return self;
}

-(instancetype) initWithName: (NSString *) name andBase: (CRSCoordinateReferenceSystem *) base andConversion: (CRSDerivingConversion *) conversion andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:CRS_TYPE_DERIVED andCoordinateSystem:coordinateSystem];
    if(self != nil){
        [self setBase:base];
        [self setConversion:conversion];
    }
    return self;
}

-(NSString *) baseName{
    return [self base].name;
}

-(CRSType) baseType{
    return [self base].type;
}

-(NSMutableArray<CRSIdentifier *> *) baseIdentifiers{
    return [self base].identifiers;
}

-(BOOL) hasBaseIdentifiers{
    return [[self base] hasIdentifiers];
}

- (BOOL) isEqualToDerivedCoordinateReferenceSystem: (CRSDerivedCoordinateReferenceSystem *) derivedCoordinateReferenceSystem{
    if (self == derivedCoordinateReferenceSystem){
        return YES;
    }
    if (derivedCoordinateReferenceSystem == nil){
        return NO;
    }
    if (![super isEqual:derivedCoordinateReferenceSystem]){
        return NO;
    }
    if (_base == nil) {
        if (derivedCoordinateReferenceSystem.base != nil){
            return NO;
        }
    } else if (![_base isEqual:derivedCoordinateReferenceSystem.base]){
        return NO;
    }
    if (_conversion == nil) {
        if (derivedCoordinateReferenceSystem.conversion != nil){
            return NO;
        }
    } else if (![_conversion isEqual:derivedCoordinateReferenceSystem.conversion]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSDerivedCoordinateReferenceSystem class]]) {
        return NO;
    }
    
    return [self isEqualToDerivedCoordinateReferenceSystem:(CRSDerivedCoordinateReferenceSystem *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_base == nil) ? 0 : [_base hash]);
    result = prime * result + ((_conversion == nil) ? 0 : [_conversion hash]);
    return result;
}

@end
