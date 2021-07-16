//
//  CRSOperationMethods.m
//  crs-ios
//
//  Created by Brian Osborn on 7/16/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSOperationMethods.h"

@implementation CRSOperationMethods

/**
 * Type to method mapping
 */
static NSMutableDictionary<NSNumber *, CRSOperationMethods *> *typeMethods = nil;

/**
 * Alias to method mapping
 */
static NSMutableDictionary<NSString *, NSMutableArray<CRSOperationMethods *> *> *aliasMethods = nil;

/**
 * Code to method mapping
 */
static NSMutableDictionary<NSNumber *, CRSOperationMethods *> *codeMethods = nil;

+(void) initialize{
    typeMethods = [NSMutableDictionary dictionary];
    aliasMethods = [NSMutableDictionary dictionary];
    codeMethods = [NSMutableDictionary dictionary];
 
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_ALBERS_EQUAL_AREA andCode:9822 andName:@"Albers Equal Area" andOperationType:CRS_OPERATION_MAP_PROJECTION andAlias:@"Albers" andParameterCodes:@[@8821, @8822, @8823, @8824, @8826, @8827]]];
    // TODO
}

+(void) initializeMethod: (CRSOperationMethods *) method{
    
    [typeMethods setObject:method forKey:[NSNumber numberWithInteger:method.type]];
    
    for(NSString *alias in method.aliases){
        NSString *aliasLowerCase = [alias lowercaseString];
        NSMutableArray<CRSOperationMethods *> *methodArray = [aliasMethods objectForKey:aliasLowerCase];
        if(methodArray == nil){
            methodArray = [NSMutableArray array];
            [aliasMethods setValue:methodArray forKey:aliasLowerCase];
        }
        [methodArray addObject:method];
    }
    
    NSNumber *code = [NSNumber numberWithInt:method.code];
    if([codeMethods objectForKey:code] != nil){
        [NSException raise:@"Duplicate Method" format:@"Duplicate configured Operation Method code: %@", code];
    }
    [codeMethods setObject:method forKey:code];
    
}

+(CRSOperationMethods *) createWithType: (enum CRSOperationMethodType) type andCode: (int) code andName: (NSString *) name andOperationType: (enum CRSOperationType) operationType andParameterCodes: (NSArray<NSNumber *> *) parameterCodes{
    return [[CRSOperationMethods alloc] initWithType:type andCode:code andName:name andOperationType:operationType andParameterCodes:parameterCodes];
}

+(CRSOperationMethods *) createWithType: (enum CRSOperationMethodType) type andCode: (int) code andName: (NSString *) name andOperationType: (enum CRSOperationType) operationType andAlias: (NSString *) alias andParameterCodes: (NSArray<NSNumber *> *) parameterCodes{
    return [[CRSOperationMethods alloc] initWithType:type andCode:code andName:name andOperationType:operationType andAlias:alias andParameterCodes:parameterCodes];
}

+(CRSOperationMethods *) createWithType: (enum CRSOperationMethodType) type andCode: (int) code andName: (NSString *) name andOperationType: (enum CRSOperationType) operationType andAliases: (NSArray<NSString *> *) aliases andParameterCodes: (NSArray<NSNumber *> *) parameterCodes{
    return [[CRSOperationMethods alloc] initWithType:type andCode:code andName:name andOperationType:operationType andAliases:aliases andParameterCodes:parameterCodes];
}

-(instancetype) initWithType: (enum CRSOperationMethodType) type andCode: (int) code andName: (NSString *) name andOperationType: (enum CRSOperationType) operationType andParameterCodes: (NSArray<NSNumber *> *) parameterCodes{
    return [self initWithType:type andCode:code andName:name andOperationType:operationType andAliases:nil andParameterCodes:parameterCodes];
}

-(instancetype) initWithType: (enum CRSOperationMethodType) type andCode: (int) code andName: (NSString *) name andOperationType: (enum CRSOperationType) operationType andAlias: (NSString *) alias andParameterCodes: (NSArray<NSNumber *> *) parameterCodes{
    return [self initWithType:type andCode:code andName:name andOperationType:operationType andAliases:[NSArray arrayWithObject:alias] andParameterCodes:parameterCodes];
}

-(instancetype) initWithType: (enum CRSOperationMethodType) type andCode: (int) code andName: (NSString *) name andOperationType: (enum CRSOperationType) operationType andAliases: (NSArray<NSString *> *) aliases andParameterCodes: (NSArray<NSNumber *> *) parameterCodes{
    self = [super init];
    if(self != nil){
        _aliases = [NSMutableArray array];
        _parameterCodes = [NSMutableArray array];
        [self setType:type];
        [self setCode:code];
        [self setName:name];
        [self setOperationType:operationType];
        [self addAlias:name];
        if(aliases != nil){
            for(NSString *alias in aliases){
                [self addAlias:alias];
            }
        }
        if(parameterCodes != nil){
            for(NSNumber *parameterCode in parameterCodes){
                [_parameterCodes addObject:parameterCode];
            }
        }
    }
    return self;
}

-(void) addAlias: (NSString *) alias{
    if(![_aliases containsObject:alias]){
        [_aliases addObject:alias];
        NSString *underscore = [alias stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        [_aliases addObject:underscore];
        [_aliases addObject:[[underscore stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""]];
    }
}

-(int) numParameters{
    return (int)_parameterCodes.count;
}

-(int) parameterCodeAtIndex: (int) index{
    return [[_parameterCodes objectAtIndex:index] intValue];
}

-(CRSOperationParameters *) parameterAtIndex: (int) index{
    return [CRSOperationParameters parameterFromCode:[self parameterCodeAtIndex:index]];
}

-(NSArray<CRSOperationParameters *> *) parameters{
    NSMutableArray<CRSOperationParameters *> *parameters = [NSMutableArray array];
    for(int i = 0; i < [self numParameters]; i++){
        [parameters addObject:[self parameterAtIndex:i]];
    }
    return parameters;
}

+(CRSOperationMethods *) method: (enum CRSOperationMethodType) type{
    return [typeMethods objectForKey:[NSNumber numberWithInteger:type]];
}

+(CRSOperationMethods *) methodFromName: (NSString *) name{
    CRSOperationMethods *method = nil;
    NSArray<CRSOperationMethods *> *methods = [self methodsFromName:name];
    if(methods != nil && methods.count > 0){
        method = [methods firstObject];
    }
    return method;
}

+(NSArray<CRSOperationMethods *> *) methodsFromName: (NSString *) name{
    NSArray<CRSOperationMethods *> *methods = nil;
    if(name != nil){
        methods = [aliasMethods objectForKey:[name lowercaseString]];
    }
    return methods;
}

+(CRSOperationMethods *) methodFromCode: (int) code{
    return [codeMethods objectForKey:[NSNumber numberWithInt:code]];
}

@end
