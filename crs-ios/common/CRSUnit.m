//
//  CRSUnit.m
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSUnit.h>
#import <CoordinateReferenceSystems/CRSWriter.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>

@implementation CRSUnit

+(CRSUnit *) create{
    return [[CRSUnit alloc] init];
}

+(CRSUnit *) createWithType: (CRSUnitType) type andName: (NSString *) name{
    return [[CRSUnit alloc] initWithType:type andName:name];
}

+(CRSUnit *) createWithType: (CRSUnitType) type andName: (NSString *) name andConversionFactor: (double) conversionFactor{
    return [[CRSUnit alloc] initWithType:type andName:name andConversionFactor:conversionFactor];
}

+(CRSUnit *) createWithType: (CRSUnitType) type andName: (NSString *) name andConversionFactorText: (NSString *) conversionFactor{
    return [[CRSUnit alloc] initWithType:type andName:name andConversionFactorText:conversionFactor];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithType: (CRSUnitType) type andName: (NSString *) name{
    self = [super init];
    if(self != nil){
        [self setType:type];
        [self setName:name];
    }
    return self;
}

-(instancetype) initWithType: (CRSUnitType) type andName: (NSString *) name andConversionFactor: (double) conversionFactor{
    self = [super init];
    if(self != nil){
        [self setType:type];
        [self setName:name];
        [self setConversionFactor:[[NSDecimalNumber alloc] initWithDouble:conversionFactor]];
    }
    return self;
}

-(instancetype) initWithType: (CRSUnitType) type andName: (NSString *) name andConversionFactorText: (NSString *) conversionFactor{
    self = [super init];
    if(self != nil){
        [self setType:type];
        [self setName:name];
        [self setConversionFactorText:conversionFactor];
    }
    return self;
}

-(BOOL) hasConversionFactor{
    return [self conversionFactor] != nil;
}

-(void) setConversionFactor: (NSDecimalNumber *) conversionFactor{
    _conversionFactor = conversionFactor;
    _conversionFactorText = [CRSTextUtils textFromDecimalNumber:conversionFactor];
}

-(void) setConversionFactorText: (NSString *) conversionFactorText{
    _conversionFactorText = conversionFactorText;
    _conversionFactor = [CRSTextUtils decimalNumberFromString:conversionFactorText];
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

- (BOOL) isEqualNameToUnit: (CRSUnit *) unit{
    return [[_name lowercaseString] isEqualToString:[unit.name lowercaseString]];
}

- (BOOL) isEqualToUnit: (CRSUnit *) unit{
    if (self == unit){
        return YES;
    }
    if (unit == nil){
        return NO;
    }
    if(_type != unit.type){
        return NO;
    }
    if (_name == nil) {
        if (unit.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:unit.name]){
        return NO;
    }
    if (_conversionFactor == nil) {
        if (unit.conversionFactor != nil){
            return NO;
        }
    } else if (![_conversionFactor isEqual:unit.conversionFactor]){
        return NO;
    }
    if (_identifiers == nil) {
        if (unit.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:unit.identifiers]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSUnit class]]) {
        return NO;
    }
    
    return [self isEqualToUnit:(CRSUnit *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [[NSNumber numberWithInt:_type] hash];
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + ((_conversionFactor == nil) ? 0 : [_conversionFactor hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeUnit:self];
    return [writer description];
}

@end
