//
//  CRSCompoundCoordinateReferenceSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/19/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSCompoundCoordinateReferenceSystem.h>

@implementation CRSCompoundCoordinateReferenceSystem

+(CRSCompoundCoordinateReferenceSystem *) create{
    return [[CRSCompoundCoordinateReferenceSystem alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_COMPOUND];
    if(self != nil){
        _coordinateReferenceSystems = [NSMutableArray array];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andType: (CRSType) type{
    self = [super initWithName:name andType:type];
    if(self != nil){
        _coordinateReferenceSystems = [NSMutableArray array];
    }
    return self;
}

-(int) numCoordinateReferenceSystems{
    return (int) _coordinateReferenceSystems.count;
}

-(CRSSimpleCoordinateReferenceSystem *) coordinateReferenceSystemAtIndex: (int) index{
    return [_coordinateReferenceSystems objectAtIndex:index];
}

-(void) setCoordinateReferenceSystems: (NSMutableArray<CRSSimpleCoordinateReferenceSystem *> *) coordinateReferenceSystems{
    [_coordinateReferenceSystems removeAllObjects];
    [self addCoordinateReferenceSystems:coordinateReferenceSystems];
}

-(void) addCoordinateReferenceSystem: (CRSSimpleCoordinateReferenceSystem *) crs{
    switch(crs.type){
        case CRS_TYPE_GEODETIC:
        case CRS_TYPE_GEOGRAPHIC:
        case CRS_TYPE_PROJECTED:
        case CRS_TYPE_VERTICAL:
        case CRS_TYPE_ENGINEERING:
        case CRS_TYPE_PARAMETRIC:
        case CRS_TYPE_TEMPORAL:
        case CRS_TYPE_DERIVED:
            [_coordinateReferenceSystems addObject:crs];
            break;
        default:
            [NSException raise:@"Unsupported Compound CRS" format:@"Unsupported Compound Coordinate Reference System Type: %@", [CRSTypes name:crs.type]];
    }
}

-(void) addCoordinateReferenceSystems: (NSArray<CRSSimpleCoordinateReferenceSystem *> *) crss{
    for(CRSSimpleCoordinateReferenceSystem *crs in crss){
        [self addCoordinateReferenceSystem:crs];
    }
}

- (BOOL) isEqualToCompoundCoordinateReferenceSystem: (CRSCompoundCoordinateReferenceSystem *) compoundCoordinateReferenceSystem{
    if (self == compoundCoordinateReferenceSystem){
        return YES;
    }
    if (compoundCoordinateReferenceSystem == nil){
        return NO;
    }
    if (![super isEqual:compoundCoordinateReferenceSystem]){
        return NO;
    }
    if (_coordinateReferenceSystems == nil) {
        if (compoundCoordinateReferenceSystem.coordinateReferenceSystems != nil){
            return NO;
        }
    } else if (![_coordinateReferenceSystems isEqual:compoundCoordinateReferenceSystem.coordinateReferenceSystems]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSCompoundCoordinateReferenceSystem class]]) {
        return NO;
    }
    
    return [self isEqualToCompoundCoordinateReferenceSystem:(CRSCompoundCoordinateReferenceSystem *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_coordinateReferenceSystems == nil) ? 0 : [_coordinateReferenceSystems hash]);
    return result;
}

@end
