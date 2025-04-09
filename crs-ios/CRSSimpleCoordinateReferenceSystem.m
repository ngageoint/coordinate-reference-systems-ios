//
//  CRSSimpleCoordinateReferenceSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/19/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSSimpleCoordinateReferenceSystem.h>

@implementation CRSSimpleCoordinateReferenceSystem

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithType: (CRSType) type{
    self = [super initWithType:type];
    return self;
}

-(instancetype) initWithName: (NSString *) name andType: (CRSType) type{
    self = [super initWithName:name andType:type];
    return self;
}

-(instancetype) initWithName: (NSString *) name andType: (CRSType) type andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    self = [super initWithName:name andType:type];
    if(self != nil){
        [self setCoordinateSystem:coordinateSystem];
    }
    return self;
}

- (BOOL) isEqualToSimpleCoordinateReferenceSystem: (CRSSimpleCoordinateReferenceSystem *) simpleCoordinateReferenceSystem{
    if (self == simpleCoordinateReferenceSystem){
        return YES;
    }
    if (simpleCoordinateReferenceSystem == nil){
        return NO;
    }
    if (![super isEqual:simpleCoordinateReferenceSystem]){
        return NO;
    }
    if (_coordinateSystem == nil) {
        if (simpleCoordinateReferenceSystem.coordinateSystem != nil){
            return NO;
        }
    } else if (![_coordinateSystem isEqual:simpleCoordinateReferenceSystem.coordinateSystem]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSSimpleCoordinateReferenceSystem class]]) {
        return NO;
    }
    
    return [self isEqualToSimpleCoordinateReferenceSystem:(CRSSimpleCoordinateReferenceSystem *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_coordinateSystem == nil) ? 0 : [_coordinateSystem hash]);
    return result;
}

@end
