//
//  CRSOperationMethod.m
//  crs-ios
//
//  Created by Brian Osborn on 7/19/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSOperationMethod.h>
#import <CoordinateReferenceSystems/CRSWriter.h>

@implementation CRSOperationMethod

+(CRSOperationMethod *) create{
    return [[CRSOperationMethod alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithName: (NSString *) name{
    self = [super init];
    if(self != nil){
        _name = name;
        [self updateMethod];
    }
    return self;
}

-(instancetype) initWithMethod: (CRSOperationMethods *) method{
    self = [super init];
    if(self != nil){
        _name = [method name];
        _method = method;
    }
    return self;
}

-(void) setName: (NSString *) name{
    _name = name;
    [self updateMethod];
}

-(BOOL) hasParameters{
    return _parameters != nil && _parameters.count > 0;
}

-(int) numParameters{
    return _parameters != nil ? (int) _parameters.count : 0;
}

-(CRSOperationParameter *) parameterAtIndex: (int) index{
    return [_parameters objectAtIndex:index];
}

-(void) addParameter: (CRSOperationParameter *) parameter{
    if(_parameters == nil){
        _parameters = [NSMutableArray array];
    }
    [_parameters addObject:parameter];
}

-(void) addParameters: (NSArray<CRSOperationParameter *> *) parameters{
    if(_parameters == nil){
        _parameters = [NSMutableArray array];
    }
    [_parameters addObjectsFromArray:parameters];
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

-(BOOL) hasMethod{
    return [self method] != nil;
}

-(void) updateMethod{
    [self setMethod:[CRSOperationMethods methodFromName:[self name]]];
}

- (BOOL) isEqualToOperationMethod: (CRSOperationMethod *) operationMethod{
    if (self == operationMethod){
        return YES;
    }
    if (operationMethod == nil){
        return NO;
    }
    if (_name == nil) {
        if (operationMethod.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:operationMethod.name]){
        return NO;
    }
    if (_parameters == nil) {
        if (operationMethod.parameters != nil){
            return NO;
        }
    } else if (![_parameters isEqual:operationMethod.parameters]){
        return NO;
    }
    if (_identifiers == nil) {
        if (operationMethod.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:operationMethod.identifiers]){
        return NO;
    }
    if (_method == nil) {
        if (operationMethod.method != nil){
            return NO;
        }
    } else if ([_method type] != [operationMethod.method type]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSOperationMethod class]]) {
        return NO;
    }
    
    return [self isEqualToOperationMethod:(CRSOperationMethod *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + ((_parameters == nil) ? 0 : [_parameters hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    result = prime * result + ((_method == nil) ? 0 : [[NSNumber numberWithInteger:[_method type]] hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeOperationMethod:self];
    return [writer description];
}

@end
