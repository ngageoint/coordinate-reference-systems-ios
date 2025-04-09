//
//  CRSOperationMethods.m
//  crs-ios
//
//  Created by Brian Osborn on 7/16/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSOperationMethods.h>

@interface CRSOperationMethods()

@property (nonatomic) CRSOperationMethodType type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) CRSOperationType operationType;
@property (nonatomic, strong) NSMutableArray<NSString *> *aliases;
@property (nonatomic) int code;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *parameterCodes;

@end

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
 
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_ALBERS_EQUAL_AREA andCode:9822 andName:@"Albers Equal Area" andOperationType:CRS_OPERATION_MAP_PROJECTION andAliases:[NSArray arrayWithObjects:@"Albers", @"Albers Conic Equal Area", nil] andParameterCodes:@[@8821, @8822, @8823, @8824, @8826, @8827]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_AMERICAN_POLYCONIC andCode:9818 andName:@"American Polyconic" andOperationType:CRS_OPERATION_MAP_PROJECTION andAlias:@"Polyconic" andParameterCodes:@[@8801, @8802, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_CASSINI_SOLDNER andCode:9806 andName:@"Cassini-Soldner" andOperationType:CRS_OPERATION_MAP_PROJECTION andAliases:[NSArray arrayWithObjects:@"Cassini", @"Cassini Soldner", nil] andParameterCodes:@[@8801, @8802, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_COORDINATE_FRAME_ROTATION andCode:1032 andName:@"Coordinate Frame rotation (geocentric domain)" andOperationType:CRS_OPERATION_COORDINATE andAliases:[NSArray arrayWithObjects:@"Coordinate Frame rotation", @"Bursa-Wolf", nil] andParameterCodes:@[@8605, @8606, @8607, @8608, @8609, @8610, @8611]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_EQUIDISTANT_CYLINDRICAL andCode:9823 andName:@"Equidistant Cylindrical (Spherical)" andOperationType:CRS_OPERATION_MAP_PROJECTION andAliases:[NSArray arrayWithObjects:@"Equidistant Cylindrical", @"Equirectangular", nil] andParameterCodes:@[@8801, @8802, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_GEOCENTRIC_TRANSLATIONS andCode:1031 andName:@"Geocentric translations (geocentric domain)" andOperationType:CRS_OPERATION_COORDINATE andAlias:@"Geocentric translations" andParameterCodes:@[@8605, @8606, @8607]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_HOTINE_OBLIQUE_MERCATOR_A andCode:9812 andName:@"Hotine Oblique Mercator (variant A)" andOperationType:CRS_OPERATION_MAP_PROJECTION andAliases:[NSArray arrayWithObjects:@"Rectified skew orthomorphic", @"Hotine Oblique Mercator", nil] andParameterCodes:@[@8811, @8812, @8813, @8814, @8815, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_HOTINE_OBLIQUE_MERCATOR_B andCode:9815 andName:@"Hotine Oblique Mercator (variant B)" andOperationType:CRS_OPERATION_MAP_PROJECTION andAliases:[NSArray arrayWithObjects:@"Rectified skew orthomorphic", @"Oblique Mercator", @"Hotine Oblique Mercator Azimuth Center", nil] andParameterCodes:@[@8811, @8812, @8813, @8814, @8815, @8816, @8817]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_KROVAK andCode:9819 andName:@"Krovak" andOperationType:CRS_OPERATION_MAP_PROJECTION andParameterCodes:@[@8811, @8833, @1036, @8818, @8819, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_LAMBERT_AZIMUTHAL_EQUAL_AREA andCode:9820 andName:@"Lambert Azimuthal Equal Area" andOperationType:CRS_OPERATION_MAP_PROJECTION andAliases:[NSArray arrayWithObjects:@"Lambert Equal Area", @"LAEA", @"Lambert Azimuthal Equal Area (Spherical)", nil] andParameterCodes:@[@8801, @8802, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_LAMBERT_CONIC_CONFORMAL_1SP andCode:9801 andName:@"Lambert Conic Conformal (1SP)" andOperationType:CRS_OPERATION_MAP_PROJECTION andAliases:[NSArray arrayWithObjects:@"Lambert Conic Conformal", @"LCC", @"Lambert Conformal Conic 1SP", nil] andParameterCodes:@[@8801, @8802, @8805, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_LAMBERT_CONIC_CONFORMAL_2SP andCode:9802 andName:@"Lambert Conic Conformal (2SP)" andOperationType:CRS_OPERATION_MAP_PROJECTION andAliases:[NSArray arrayWithObjects:@"Lambert Conic Conformal", @"LCC", @"Lambert Conformal Conic 2SP", nil] andParameterCodes:@[@8821, @8822, @8823, @8824, @8826, @8827]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_LAMBERT_CYLINDRICAL_EQUAL_AREA andCode:9834 andName:@"Lambert Cylindrical Equal Area (Spherical)" andOperationType:CRS_OPERATION_MAP_PROJECTION andAliases:[NSArray arrayWithObjects:@"Lambert Cylindrical Equal Area", @"Cylindrical Equal Area", nil] andParameterCodes:@[@8823, @8802, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_LONGITUDE_ROTATION andCode:9601 andName:@"Longitude rotation" andOperationType:CRS_OPERATION_COORDINATE andParameterCodes:@[@8602]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_MERCATOR_A andCode:9804 andName:@"Mercator (variant A)" andOperationType:CRS_OPERATION_MAP_PROJECTION andAlias:@"Mercator" andParameterCodes:@[@8801, @8802, @8805, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_MERCATOR_B andCode:9805 andName:@"Mercator (variant B)" andOperationType:CRS_OPERATION_MAP_PROJECTION andAlias:@"Mercator" andParameterCodes:@[@8823, @8802, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_MOLODENSKY_BADEKAS andCode:1034 andName:@"Molodensky-Badekas (geocentric domain)" andOperationType:CRS_OPERATION_COORDINATE andAlias:@"Molodensky-Badekas" andParameterCodes:@[@8605, @8606, @8607, @8608, @8609, @8610, @8611, @8617, @8618, @8667]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_NADCON andCode:9613 andName:@"NADCON" andOperationType:CRS_OPERATION_COORDINATE andParameterCodes:@[@8657, @8658]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_NADCON5 andCode:1075 andName:@"NADCON5 (3D)" andOperationType:CRS_OPERATION_COORDINATE andAlias:@"NADCON5" andParameterCodes:@[@8657, @8658, @1058]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_NEW_ZEALAND_MAP_GRID andCode:9811 andName:@"New Zealand Map Grid" andOperationType:CRS_OPERATION_MAP_PROJECTION andParameterCodes:@[@8801, @8802, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_NTV2 andCode:9615 andName:@"NTv2" andOperationType:CRS_OPERATION_COORDINATE andParameterCodes:@[@8656]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_OBLIQUE_STEREOGRAPHIC andCode:9809 andName:@"Oblique stereographic" andOperationType:CRS_OPERATION_MAP_PROJECTION andAlias:@"Double stereographic" andParameterCodes:@[@8801, @8802, @8805, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_POLAR_STEREOGRAPHIC_A andCode:9810 andName:@"Polar Stereographic (variant A)" andOperationType:CRS_OPERATION_MAP_PROJECTION andAlias:@"Polar Stereographic" andParameterCodes:@[@8801, @8802, @8805, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_POLAR_STEREOGRAPHIC_B andCode:9829 andName:@"Polar Stereographic (variant B)" andOperationType:CRS_OPERATION_MAP_PROJECTION andParameterCodes:@[@8832, @8833, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_POLAR_STEREOGRAPHIC_C andCode:9830 andName:@"Polar Stereographic (variant C)" andOperationType:CRS_OPERATION_MAP_PROJECTION andParameterCodes:@[@8832, @8833, @8826, @8827]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_POPULAR_VISUALISATION_PSEUDO_MERCATOR andCode:1024 andName:@"Popular Visualisation Pseudo Mercator" andOperationType:CRS_OPERATION_MAP_PROJECTION andAlias:@"Mercator_1SP" andParameterCodes:@[@8801, @8802, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_POSITION_VECTOR_TRANSFORMATION andCode:1033 andName:@"Position Vector transformation (geocentric domain)" andOperationType:CRS_OPERATION_COORDINATE andAliases:[NSArray arrayWithObjects:@"Position Vector transformation", @"Position Vector 7-param. transformation", @"Bursa-Wolf", @"Helmert", nil] andParameterCodes:@[@8605, @8606, @8607, @8608, @8609, @8610, @8611]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_TRANSVERSE_MERCATOR andCode:9807 andName:@"Transverse Mercator" andOperationType:CRS_OPERATION_MAP_PROJECTION andAliases:[NSArray arrayWithObjects:@"Gauss-Boaga", @"Gauss-Krüger", @"TM", nil] andParameterCodes:@[@8801, @8802, @8805, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_TRANSVERSE_MERCATOR_SOUTH_ORIENTATED andCode:9808 andName:@"Transverse Mercator (South Orientated)" andOperationType:CRS_OPERATION_MAP_PROJECTION andAlias:@"Gauss-Conform" andParameterCodes:@[@8801, @8802, @8805, @8806, @8807]]];
    [self initializeMethod:[CRSOperationMethods createWithType:CRS_METHOD_VERTICAL_OFFSET andCode:9616 andName:@"Vertical Offset" andOperationType:CRS_OPERATION_COORDINATE andParameterCodes:@[@8603]]];

}

+(void) initializeMethod: (CRSOperationMethods *) method{
    
    [typeMethods setObject:method forKey:[NSNumber numberWithInteger:method.type]];
    
    for(NSString *alias in method.aliases){
        NSString *aliasLowerCase = [alias lowercaseString];
        NSMutableArray<CRSOperationMethods *> *methodArray = [aliasMethods objectForKey:aliasLowerCase];
        if(methodArray == nil){
            methodArray = [NSMutableArray array];
            [aliasMethods setObject:methodArray forKey:aliasLowerCase];
        }
        [methodArray addObject:method];
    }
    
    NSNumber *code = [NSNumber numberWithInt:method.code];
    if([codeMethods objectForKey:code] != nil){
        [NSException raise:@"Duplicate Method" format:@"Duplicate configured Operation Method code: %@", code];
    }
    [codeMethods setObject:method forKey:code];
    
}

+(CRSOperationMethods *) createWithType: (CRSOperationMethodType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andParameterCodes: (NSArray<NSNumber *> *) parameterCodes{
    return [[CRSOperationMethods alloc] initWithType:type andCode:code andName:name andOperationType:operationType andParameterCodes:parameterCodes];
}

+(CRSOperationMethods *) createWithType: (CRSOperationMethodType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andAlias: (NSString *) alias andParameterCodes: (NSArray<NSNumber *> *) parameterCodes{
    return [[CRSOperationMethods alloc] initWithType:type andCode:code andName:name andOperationType:operationType andAlias:alias andParameterCodes:parameterCodes];
}

+(CRSOperationMethods *) createWithType: (CRSOperationMethodType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andAliases: (NSArray<NSString *> *) aliases andParameterCodes: (NSArray<NSNumber *> *) parameterCodes{
    return [[CRSOperationMethods alloc] initWithType:type andCode:code andName:name andOperationType:operationType andAliases:aliases andParameterCodes:parameterCodes];
}

-(instancetype) initWithType: (CRSOperationMethodType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andParameterCodes: (NSArray<NSNumber *> *) parameterCodes{
    return [self initWithType:type andCode:code andName:name andOperationType:operationType andAliases:nil andParameterCodes:parameterCodes];
}

-(instancetype) initWithType: (CRSOperationMethodType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andAlias: (NSString *) alias andParameterCodes: (NSArray<NSNumber *> *) parameterCodes{
    return [self initWithType:type andCode:code andName:name andOperationType:operationType andAliases:[NSArray arrayWithObject:alias] andParameterCodes:parameterCodes];
}

-(instancetype) initWithType: (CRSOperationMethodType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andAliases: (NSArray<NSString *> *) aliases andParameterCodes: (NSArray<NSNumber *> *) parameterCodes{
    self = [super init];
    if(self != nil){
        _aliases = [NSMutableArray array];
        _parameterCodes = [NSMutableArray array];
        _type = type;
        _code = code;
        _name = name;
        _operationType = operationType;
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
    }
    NSString *underscore = [alias stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    if(![_aliases containsObject:underscore]){
        [_aliases addObject:underscore];
    }
    NSString *noParens = [[underscore stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""];
    if(![_aliases containsObject:noParens]){
        [_aliases addObject:noParens];
    }
}

-(CRSOperationMethodType) type{
    return _type;
}

-(NSString *) name{
    return _name;
}

-(CRSOperationType) operationType{
    return _operationType;
}

-(NSArray<NSString *> *) aliases{
    return _aliases;
}

-(int) code{
    return _code;
}

-(NSArray<NSNumber *> *) parameterCodes{
    return _parameterCodes;
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

-(BOOL) isEqualToOperationMethods: (CRSOperationMethods *) operationMethods{
    if (self == operationMethods){
        return YES;
    }
    if (operationMethods == nil){
        return NO;
    }
    if(_type != operationMethods.type){
        return NO;
    }
    return YES;
}

-(BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSOperationMethods class]]) {
        return NO;
    }
    
    return [self isEqualToOperationMethods:(CRSOperationMethods *)object];
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [[NSNumber numberWithInt:_type] hash];
    return result;
}

+(CRSOperationMethods *) method: (CRSOperationMethodType) type{
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
