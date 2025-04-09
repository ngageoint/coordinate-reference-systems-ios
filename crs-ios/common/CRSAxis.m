//
//  CRSAxis.m
//  crs-ios
//
//  Created by Brian Osborn on 7/14/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSAxis.h>
#import <CoordinateReferenceSystems/CRSWriter.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>

@implementation CRSAxis

+(CRSAxis *) create{
    return [[CRSAxis alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithName: (NSString *) name andDirection: (CRSAxisDirectionType) direction{
    self = [super init];
    if(self != nil){
        [self setName:name];
        [self setDirection:direction];
    }
    return self;
}

-(BOOL) hasName{
    return [self name] != nil;
}

-(BOOL) hasAbbreviation{
    return [self abbreviation] != nil;
}

-(BOOL) hasMeridian{
    return [self meridian] != nil;
}

-(void) setMeridian: (NSDecimalNumber *) meridian{
    _meridian = meridian;
    _meridianText = [CRSTextUtils textFromDecimalNumber:meridian];
}

-(void) setMeridianText: (NSString *) meridianText{
    _meridianText = meridianText;
    _meridian = [CRSTextUtils decimalNumberFromString:meridianText];
}

-(BOOL) hasBearing{
    return [self bearing] != nil;
}

-(void) setBearing: (NSDecimalNumber *) bearing{
    _bearing = bearing;
    _bearingText = [CRSTextUtils textFromDecimalNumber:bearing];
}

-(void) setBearingText: (NSString *) bearingText{
    _bearingText = bearingText;
    _bearing = [CRSTextUtils decimalNumberFromString:bearingText];
}

-(BOOL) hasOrder{
    return [self order] != nil;
}

-(BOOL) hasUnit{
    return [self unit] != nil;
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

- (BOOL) isEqualToAxis: (CRSAxis *) axis{
    if (self == axis){
        return YES;
    }
    if (axis == nil){
        return NO;
    }
    if (_name == nil) {
        if (axis.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:axis.name]){
        return NO;
    }
    if (_abbreviation == nil) {
        if (axis.abbreviation != nil){
            return NO;
        }
    } else if (![_abbreviation isEqualToString:axis.abbreviation]){
        return NO;
    }
    if(_direction != axis.direction){
        return NO;
    }
    if (_meridian == nil) {
        if (axis.meridian != nil){
            return NO;
        }
    } else if (![_meridian isEqual:axis.meridian]){
        return NO;
    }
    if (_meridianUnit == nil) {
        if (axis.meridianUnit != nil){
            return NO;
        }
    } else if (![_meridianUnit isEqual:axis.meridianUnit]){
        return NO;
    }
    if (_bearing == nil) {
        if (axis.bearing != nil){
            return NO;
        }
    } else if (![_bearing isEqual:axis.bearing]){
        return NO;
    }
    if (_order == nil) {
        if (axis.order  != nil){
            return NO;
        }
    } else if (![_order isEqual:axis.order ]){
        return NO;
    }
    if (_unit == nil) {
        if (axis.unit != nil){
            return NO;
        }
    } else if (![_unit isEqual:axis.unit]){
        return NO;
    }
    if (_identifiers == nil) {
        if (axis.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:axis.identifiers]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSAxis class]]) {
        return NO;
    }
    
    return [self isEqualToAxis:(CRSAxis *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + ((_abbreviation == nil) ? 0 : [_abbreviation hash]);
    result = prime * result + [[NSNumber numberWithInt:_direction] hash];
    result = prime * result + ((_meridian == nil) ? 0 : [_meridian hash]);
    result = prime * result + ((_meridianUnit == nil) ? 0 : [_meridianUnit hash]);
    result = prime * result + ((_bearing == nil) ? 0 : [_bearing hash]);
    result = prime * result + ((_order == nil) ? 0 : [_order hash]);
    result = prime * result + ((_unit == nil) ? 0 : [_unit hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeAxis:self];
    return [writer description];
}

@end
