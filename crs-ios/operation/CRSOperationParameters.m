//
//  CRSOperationParameters.m
//  crs-ios
//
//  Created by Brian Osborn on 7/16/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSOperationParameters.h>

@interface CRSOperationParameters()

@property (nonatomic) CRSOperationParameterType type;
@property (nonatomic) int code;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) CRSOperationType operationType;
@property (nonatomic, strong) NSMutableArray<NSString *> *aliases;
@property (nonatomic) CRSUnitType unitType;

@end

@implementation CRSOperationParameters

/**
 * Type to parameter mapping
 */
static NSMutableDictionary<NSNumber *, CRSOperationParameters *> *typeParameters = nil;

/**
 * Alias to parameter mapping
 */
static NSMutableDictionary<NSString *, NSMutableArray<CRSOperationParameters *> *> *aliasParameters = nil;

/**
 * Code to parameter mapping
 */
static NSMutableDictionary<NSNumber *, CRSOperationParameters *> *codeParameters = nil;

+(void) initialize{
    typeParameters = [NSMutableDictionary dictionary];
    aliasParameters = [NSMutableDictionary dictionary];
    codeParameters = [NSMutableDictionary dictionary];
    
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_ANGLE_FROM_RECTIFIED_TO_SKEW_GRID andCode:8814 andName:@"angle from rectified to skew grid" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE andAlias:@"rectified grid angle"]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_AZIMUTH_OF_INITIAL_LINE andCode:8813 andName:@"azimuth of initial line" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE andAlias:@"azimuth"]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_CO_LATITUDE_OF_CONE_AXIS andCode:1036 andName:@"co-latitude of cone axis" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_EASTING_AT_FALSE_ORIGIN andCode:8826 andName:@"easting at false origin" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_LENGTH andAlias:@"false easting"]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_EASTING_AT_PROJECTION_CENTRE andCode:8816 andName:@"easting at projection centre" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_LENGTH andAlias:@"false easting"]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_ELLIPSOIDAL_HEIGHT_DIFFERENCE_FILE andCode:1058 andName:@"Ellipsoidal height difference file" andOperationType:CRS_OPERATION_COORDINATE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_FALSE_EASTING andCode:8806 andName:@"false easting" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_LENGTH]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_FALSE_NORTHING andCode:8807 andName:@"false northing" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_LENGTH]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LATITUDE_AND_LONGITUDE_DIFFERENCE_FILE andCode:8656 andName:@"Latitude and longitude difference file" andOperationType:CRS_OPERATION_COORDINATE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LATITUDE_DIFFERENCE_FILE andCode:8657 andName:@"Latitude difference file" andOperationType:CRS_OPERATION_COORDINATE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LATITUDE_OF_1ST_STANDARD_PARALLEL andCode:8823 andName:@"latitude of 1st standard parallel" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE andAlias:@"standard parallel 1"]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LATITUDE_OF_2ND_STANDARD_PARALLEL andCode:8824 andName:@"latitude of 2nd standard parallel" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE andAlias:@"standard parallel 2"]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LATITUDE_OF_FALSE_ORIGIN andCode:8821 andName:@"latitude of false origin" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE andAlias:@"latitude of origin"]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LATITUDE_OF_NATURAL_ORIGIN andCode:8801 andName:@"latitude of natural origin" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE andAliases:[NSArray arrayWithObjects:@"latitude of origin", @"latitude of center", nil]]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LATITUDE_OF_PROJECTION_CENTRE andCode:8811 andName:@"latitude of projection centre" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LATITUDE_OF_PSEUDO_STANDARD_PARALLEL andCode:8818 andName:@"latitude of pseudo standard parallel" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LONGITUDE_DIFFERENCE_FILE andCode:8658 andName:@"Longitude difference file" andOperationType:CRS_OPERATION_COORDINATE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LONGITUDE_OF_FALSE_ORIGIN andCode:8822 andName:@"longitude of false origin" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE andAliases:[NSArray arrayWithObjects:@"longitude of origin", @"longitude of center", @"central meridian", nil]]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LONGITUDE_OF_NATURAL_ORIGIN andCode:8802 andName:@"longitude of natural origin" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE andAliases:[NSArray arrayWithObjects:@"longitude of origin", @"longitude of center", @"central meridian", nil]]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LONGITUDE_OF_ORIGIN andCode:8833 andName:@"longitude of origin" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_LONGITUDE_OF_PROJECTION_CENTRE andCode:8812 andName:@"longitude of projection centre" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_ANGLE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_NORTHING_AT_FALSE_ORIGIN andCode:8827 andName:@"northing at false origin" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_LENGTH andAlias:@"false northing"]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_NORTHING_AT_PROJECTION_CENTRE andCode:8817 andName:@"northing at projection centre" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_LENGTH andAlias:@"false northing"]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_ORDINATE_1_OF_EVALUATION_POINT andCode:8617 andName:@"Ordinate 1 of evaluation point" andOperationType:CRS_OPERATION_COORDINATE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_ORDINATE_2_OF_EVALUATION_POINT andCode:8618 andName:@"Ordinate 2 of evaluation point" andOperationType:CRS_OPERATION_COORDINATE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_ORDINATE_3_OF_EVALUATION_POINT andCode:8667 andName:@"Ordinate 3 of evaluation point" andOperationType:CRS_OPERATION_COORDINATE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_SCALE_DIFFERENCE andCode:8611 andName:@"Scale difference" andOperationType:CRS_OPERATION_COORDINATE andAliases:[NSArray arrayWithObjects:@"dS", @"ppm", nil]]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_SCALE_FACTOR_AT_NATURAL_ORIGIN andCode:8805 andName:@"scale factor at natural origin" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_SCALE andAlias:@"scale factor"]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_SCALE_FACTOR_ON_INITIAL_LINE andCode:8815 andName:@"scale factor on initial line" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_SCALE andAlias:@"scale factor"]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_SCALE_FACTOR_ON_PSEUDO_STANDARD_PARALLEL andCode:8819 andName:@"scale factor on pseudo standard parallel" andOperationType:CRS_OPERATION_MAP_PROJECTION andUnitType:CRS_UNIT_SCALE]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_VERTICAL_OFFSET andCode:8603 andName:@"Vertical Offset" andOperationType:CRS_OPERATION_COORDINATE andAlias:@"dH"]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_X_AXIS_ROTATION andCode:8608 andName:@"X-axis rotation" andOperationType:CRS_OPERATION_COORDINATE andAliases:[NSArray arrayWithObjects:@"rX", @"eX", nil]]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_X_AXIS_TRANSLATION andCode:8605 andName:@"X-axis translation" andOperationType:CRS_OPERATION_COORDINATE andAliases:[NSArray arrayWithObjects:@"dX", @"tX", nil]]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_Y_AXIS_ROTATION andCode:8609 andName:@"Y-axis rotation" andOperationType:CRS_OPERATION_COORDINATE andAliases:[NSArray arrayWithObjects:@"rY", @"eY", nil]]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_Y_AXIS_TRANSLATION andCode:8606 andName:@"Y-axis translation" andOperationType:CRS_OPERATION_COORDINATE andAliases:[NSArray arrayWithObjects:@"dY", @"tY", nil]]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_Z_AXIS_ROTATION andCode:8610 andName:@"Z-axis rotation" andOperationType:CRS_OPERATION_COORDINATE andAliases:[NSArray arrayWithObjects:@"rZ", @"eZ", nil]]];
    [self initializeParameter:[CRSOperationParameters createWithType:
                               CRS_PARAMETER_Z_AXIS_TRANSLATION andCode:8607 andName:@"Z-axis translation" andOperationType:CRS_OPERATION_COORDINATE andAliases:[NSArray arrayWithObjects:@"dZ", @"tZ", nil]]];

}

+(void) initializeParameter: (CRSOperationParameters *) parameter{
    
    [typeParameters setObject:parameter forKey:[NSNumber numberWithInteger:parameter.type]];
    
    for(NSString *alias in parameter.aliases){
        NSString *aliasLowerCase = [alias lowercaseString];
        NSMutableArray<CRSOperationParameters *> *parameterArray = [aliasParameters objectForKey:aliasLowerCase];
        if(parameterArray == nil){
            parameterArray = [NSMutableArray array];
            [aliasParameters setObject:parameterArray forKey:aliasLowerCase];
        }
        [parameterArray addObject:parameter];
    }
    
    NSNumber *code = [NSNumber numberWithInt:parameter.code];
    if([codeParameters objectForKey:code] != nil){
        [NSException raise:@"Duplicate Parameter" format:@"Duplicate configured Operation Parameter code: %@", code];
    }
    [codeParameters setObject:parameter forKey:code];
    
}

+(CRSOperationParameters *) createWithType: (CRSOperationParameterType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType{
    return [[CRSOperationParameters alloc] initWithType:type andCode:code andName:name andOperationType:operationType];
}

+(CRSOperationParameters *) createWithType: (CRSOperationParameterType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andAlias: (NSString *) alias{
    return [[CRSOperationParameters alloc] initWithType:type andCode:code andName:name andOperationType:operationType andAlias:alias];
}

+(CRSOperationParameters *) createWithType: (CRSOperationParameterType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andAliases: (NSArray<NSString *> *) aliases{
    return [[CRSOperationParameters alloc] initWithType:type andCode:code andName:name andOperationType:operationType andAliases:aliases];
}

+(CRSOperationParameters *) createWithType: (CRSOperationParameterType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andUnitType: (CRSUnitType) unitType{
    return [[CRSOperationParameters alloc] initWithType:type andCode:code andName:name andOperationType:operationType andUnitType:unitType];
}

+(CRSOperationParameters *) createWithType: (CRSOperationParameterType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andUnitType: (CRSUnitType) unitType andAlias: (NSString *) alias{
    return [[CRSOperationParameters alloc] initWithType:type andCode:code andName:name andOperationType:operationType andUnitType:unitType andAlias:alias];
}

+(CRSOperationParameters *) createWithType: (CRSOperationParameterType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andUnitType: (CRSUnitType) unitType andAliases: (NSArray<NSString *> *) aliases{
    return [[CRSOperationParameters alloc] initWithType:type andCode:code andName:name andOperationType:operationType andUnitType:unitType andAliases:aliases];
}

-(instancetype) initWithType: (CRSOperationParameterType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType{
    return [self initWithType:type andCode:code andName:name andOperationType:operationType andAliases:nil];
}

-(instancetype) initWithType: (CRSOperationParameterType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andAlias: (NSString *) alias{
    return [self initWithType:type andCode:code andName:name andOperationType:operationType andAliases:[NSArray arrayWithObject:alias]];
}

-(instancetype) initWithType: (CRSOperationParameterType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andAliases: (NSArray<NSString *> *) aliases{
    return [self initWithType:type andCode:code andName:name andOperationType:operationType andUnitType:CRS_UNIT_NONE andAliases:aliases];
}

-(instancetype) initWithType: (CRSOperationParameterType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andUnitType: (CRSUnitType) unitType{
    return [self initWithType:type andCode:code andName:name andOperationType:operationType andUnitType:unitType andAliases:nil];
}

-(instancetype) initWithType: (CRSOperationParameterType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andUnitType: (CRSUnitType) unitType andAlias: (NSString *) alias{
    return [self initWithType:type andCode:code andName:name andOperationType:operationType andUnitType:unitType andAliases:[NSArray arrayWithObject:alias]];
}

-(instancetype) initWithType: (CRSOperationParameterType) type andCode: (int) code andName: (NSString *) name andOperationType: (CRSOperationType) operationType andUnitType: (CRSUnitType) unitType andAliases: (NSArray<NSString *> *) aliases{
    self = [super init];
    if(self != nil){
        _aliases = [NSMutableArray array];
        _type = type;
        _code = code;
        _name = name;
        _operationType = operationType;
        _unitType = unitType;
        [self addAlias:name];
        if(aliases != nil){
            for(NSString *alias in aliases){
                [self addAlias:alias];
            }
        }
    }
    return self;
}

-(void) addAlias: (NSString *) alias{
    if(![_aliases containsObject:alias]){
        [_aliases addObject:alias];
        [_aliases addObject:[alias stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
    }
}

-(CRSOperationParameterType) type{
    return _type;
}

-(int) code{
    return _code;
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

-(CRSUnitType) unitType{
    return _unitType;
}

-(BOOL) isEqualToOperationParameters: (CRSOperationParameters *) operationParameters{
    if (self == operationParameters){
        return YES;
    }
    if (operationParameters == nil){
        return NO;
    }
    if(_type != operationParameters.type){
        return NO;
    }
    return YES;
}

-(BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSOperationParameters class]]) {
        return NO;
    }
    
    return [self isEqualToOperationParameters:(CRSOperationParameters *)object];
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [[NSNumber numberWithInt:_type] hash];
    return result;
}

+(CRSOperationParameters *) parameter: (CRSOperationParameterType) type{
    return [typeParameters objectForKey:[NSNumber numberWithInteger:type]];
}

+(CRSOperationParameters *) parameterFromName: (NSString *) name{
    CRSOperationParameters *parameter = nil;
    NSArray<CRSOperationParameters *> *parameters = [self parametersFromName:name];
    if(parameters != nil && parameters.count > 0){
        parameter = [parameters firstObject];
    }
    return parameter;
}

+(NSArray<CRSOperationParameters *> *) parametersFromName: (NSString *) name{
    NSArray<CRSOperationParameters *> *parameters = nil;
    if(name != nil){
        parameters = [aliasParameters objectForKey:[name lowercaseString]];
    }
    return parameters;
}

+(CRSOperationParameters *) parameterFromCode: (int) code{
    return [codeParameters objectForKey:[NSNumber numberWithInt:code]];
}

@end
