//
//  CRSCoordinateSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/15/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSCoordinateSystem.h>
#import <CoordinateReferenceSystems/CRSWriter.h>

@implementation CRSCoordinateSystem

+(CRSCoordinateSystem *) create{
    return [[CRSCoordinateSystem alloc] init];
}

-(instancetype) init{
    self = [super init];
    if(self != nil){
        _axes = [NSMutableArray array];
    }
    return self;
}

-(instancetype) initWithType: (CRSCoordinateSystemType) type andDimension: (int) dimension andAxis: (CRSAxis *) axis{
    self = [self init];
    if(self != nil){
        [self setType:type];
        [self setDimension:dimension];
        [self addAxis:axis];
    }
    return self;
}

-(instancetype) initWithType: (CRSCoordinateSystemType) type andDimension: (int) dimension andAxes: (NSArray<CRSAxis *> *) axes{
    self = [self init];
    if(self != nil){
        [self setType:type];
        [self setDimension:dimension];
        [self addAxes:axes];
    }
    return self;
}

-(BOOL) hasIdentifiers{
    return _identifiers != nil && _identifiers.count > 0;
}

-(int) numIdentifiers{
    return _identifiers != nil ? (int) _identifiers.count : 0;
}

-(CRSIdentifier *) identifierAtIndex: (int) index{
    return [_identifiers objectAtIndex:index];
}

-(void) addIdentifier: (CRSIdentifier *) identifier{
    if(_identifiers == nil){
        _identifiers = [NSMutableArray array];
    }
    [_identifiers addObject:identifier];
}

-(void) addIdentifiers: (NSArray<CRSIdentifier *> *) identifiers{
    if(_identifiers == nil){
        _identifiers = [NSMutableArray array];
    }
    [_identifiers addObjectsFromArray:identifiers];
}

-(int) numAxes{
    return (int) _axes.count;
}

-(CRSAxis *) axisAtIndex: (int) index{
    return [_axes objectAtIndex:index];
}

-(void) addAxis: (CRSAxis *) axis{
    [_axes addObject:axis];
}

-(void) addAxes: (NSArray<CRSAxis *> *) axes{
    [_axes addObjectsFromArray:axes];
}

-(BOOL) hasUnit{
    return [self unit] != nil;
}

-(CRSUnit *) axisUnit{
    CRSUnit *axisUnit = [self unit];
    if(axisUnit == nil){
        for(CRSAxis *axis in _axes){
            axisUnit = [axis unit];
            if(axisUnit != nil){
                break;
            }
        }
    }
    return axisUnit;
}

- (BOOL) isEqualToCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    if (self == coordinateSystem){
        return YES;
    }
    if (coordinateSystem == nil){
        return NO;
    }
    if(_type != coordinateSystem.type){
        return NO;
    }
    if(_dimension != coordinateSystem.dimension){
        return NO;
    }
    if (_identifiers == nil) {
        if (coordinateSystem.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:coordinateSystem.identifiers]){
        return NO;
    }
    if (_axes == nil) {
        if (coordinateSystem.axes != nil){
            return NO;
        }
    } else if (![_axes isEqual:coordinateSystem.axes]){
        return NO;
    }
    if (_unit == nil) {
        if (coordinateSystem.unit != nil){
            return NO;
        }
    } else if (![_unit isEqual:coordinateSystem.unit]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSCoordinateSystem class]]) {
        return NO;
    }
    
    return [self isEqualToCoordinateSystem:(CRSCoordinateSystem *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [[NSNumber numberWithInt:_type] hash];
    result = prime * result + [[NSNumber numberWithInt:_dimension] hash];
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    result = prime * result + ((_axes == nil) ? 0 : [_axes hash]);
    result = prime * result + ((_unit == nil) ? 0 : [_unit hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeCoordinateSystem:self];
    return [writer description];
}

@end
