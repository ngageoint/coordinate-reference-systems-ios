//
//  CRSOperationParameter.m
//  crs-ios
//
//  Created by Brian Osborn on 7/16/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSOperationParameter.h>
#import <CoordinateReferenceSystems/CRSWriter.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>

@implementation CRSOperationParameter

+(CRSOperationParameter *) create{
    return [[CRSOperationParameter alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithName: (NSString *) name andValue: (double) value{
    return [self initWithName:name andValue:value andUnit:nil];
}

-(instancetype) initWithName: (NSString *) name andValueText: (NSString *) value{
    return [self initWithName:name andValueText:value andUnit:nil];
}

-(instancetype) initWithName: (NSString *) name andValue: (double) value andUnit: (CRSUnit *) unit{
    self = [super init];
    if(self != nil){
        _name = name;
        [self setValue:value];
        _unit = unit;
        [self updateParameter];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andValueText: (NSString *) value andUnit: (CRSUnit *) unit{
    self = [super init];
    if(self != nil){
        _name = name;
        [self setValueText:value];
        _unit = unit;
        [self updateParameter];
    }
    return self;
}

-(instancetype) initWithParameter: (CRSOperationParameters *) parameter andValue: (double) value{
    return [self initWithParameter:parameter andValue:value andUnit:nil];
}

-(instancetype) initWithParameter: (CRSOperationParameters *) parameter andValueText: (NSString *) value{
    return [self initWithParameter:parameter andValueText:value andUnit:nil];
}

-(instancetype) initWithParameter: (CRSOperationParameters *) parameter andValue: (double) value andUnit: (CRSUnit *) unit{
    self = [super init];
    if(self != nil){
        _name = [parameter name];
        [self setValue:value];
        _unit = unit;
        _parameter = parameter;
    }
    return self;
}

-(instancetype) initWithParameter: (CRSOperationParameters *) parameter andValueText: (NSString *) value andUnit: (CRSUnit *) unit{
    self = [super init];
    if(self != nil){
        _name = [parameter name];
        [self setValueText:value];
        _unit = unit;
        _parameter = parameter;
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andFileName: (NSString *) fileName{
    self = [super init];
    if(self != nil){
        _name = name;
        _fileName = fileName;
        [self updateParameter];
    }
    return self;
}

-(void) setName: (NSString *) name{
    _name = name;
    [self updateParameter];
}

-(void) setValue: (double) value{
    _value = value;
    _valueText = [CRSTextUtils textFromDouble:value];
}

-(void) setValueText: (NSString *) valueText{
    _valueText = valueText;
    _value = [CRSTextUtils doubleFromString:valueText];
}

-(BOOL) hasUnit{
    return [self unit] != nil;
}

-(BOOL) isFile{
    return [self fileName] != nil;
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

-(BOOL) hasParameter{
    return [self parameter] != nil;
}

-(void) updateParameter{
    [self setParameter:[CRSOperationParameters parameterFromName:[self name]]];
}

- (BOOL) isEqualToOperationParameter: (CRSOperationParameter *) operationParameter{
    if (self == operationParameter){
        return YES;
    }
    if (operationParameter == nil){
        return NO;
    }
    if (_name == nil) {
        if (operationParameter.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:operationParameter.name]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_value] isEqual:[NSNumber numberWithDouble:operationParameter.value]]){
        return NO;
    }
    if (_unit == nil) {
        if (operationParameter.unit != nil){
            return NO;
        }
    } else if (![_unit isEqual:operationParameter.unit]){
        return NO;
    }
    if (_fileName == nil) {
        if (operationParameter.fileName != nil){
            return NO;
        }
    } else if (![_fileName isEqualToString:operationParameter.fileName]){
        return NO;
    }
    if (_identifiers == nil) {
        if (operationParameter.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:operationParameter.identifiers]){
        return NO;
    }
    if (_parameter == nil) {
        if (operationParameter.parameter != nil){
            return NO;
        }
    } else if ([_parameter type] != [operationParameter.parameter type]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSOperationParameter class]]) {
        return NO;
    }
    
    return [self isEqualToOperationParameter:(CRSOperationParameter *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + [[NSNumber numberWithDouble:_value] hash];
    result = prime * result + ((_unit == nil) ? 0 : [_unit hash]);
    result = prime * result + ((_fileName == nil) ? 0 : [_fileName hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    result = prime * result + ((_parameter == nil) ? 0 : [[NSNumber numberWithInteger:[_parameter type]] hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeOperationParameter:self];
    return [writer description];
}

@end
