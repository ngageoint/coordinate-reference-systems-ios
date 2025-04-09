//
//  CRSGeoDatums.m
//  crs-ios
//
//  Created by Brian Osborn on 9/2/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSGeoDatums.h>

@interface CRSGeoDatums()

@property (nonatomic) CRSGeoDatumType type;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSArray<NSString *> *names;
@property (nonatomic, strong) NSArray<NSDecimalNumber *> *transform;
@property (nonatomic, strong) CRSEllipsoids *ellipsoid;

@end

@implementation CRSGeoDatums

/**
 * Type to Datum mapping
 */
static NSMutableDictionary<NSNumber *, CRSGeoDatums *> *typeDatums = nil;

/**
 * Names to Datum mapping
 */
static NSMutableDictionary<NSString *, CRSGeoDatums *> *nameDatums = nil;

+(void) initialize{
    typeDatums = [NSMutableDictionary dictionary];
    nameDatums = [NSMutableDictionary dictionary];
    
    [self initializeDatum:[self createWithType:CRS_DATUM_WGS84 andCode:@"WGS84" andTranslationX:0 andTranslationY:0 andTranslationZ:0 andEllipsoid:[CRSEllipsoids fromType:CRS_ELLIPSOIDS_WGS84] andNames:[NSArray arrayWithObjects:@"WGS84", @"World Geodetic System 1984 ensemble", @"WGS 1984", @"WGS 84", @"World Geodetic System 1984", nil]]];
    [self initializeDatum:[self createWithType:CRS_DATUM_GGRS87 andCode:@"GGRS87" andTranslationX:-199.87 andTranslationY:74.79 andTranslationZ:246.62 andEllipsoid:[CRSEllipsoids fromType:CRS_ELLIPSOIDS_GRS80] andName:@"Greek Geodetic Reference System 1987"]];
    [self initializeDatum:[self createWithType:CRS_DATUM_NAD83 andCode:@"NAD83" andTranslationX:0 andTranslationY:0 andTranslationZ:0 andEllipsoid:[CRSEllipsoids fromType:CRS_ELLIPSOIDS_GRS80] andName:@"North American Datum 1983"]];
    [self initializeDatum:[self createWithType:CRS_DATUM_ETRS89 andCode:@"ETRS89" andTranslationX:0 andTranslationY:0 andTranslationZ:0 andEllipsoid:[CRSEllipsoids fromType:CRS_ELLIPSOIDS_GRS80] andNames:[NSArray arrayWithObjects:@"European Terrestrial Reference System 1989", @"European Terrestrial Reference System 1989 ensemble", nil]]];
    [self initializeDatum:[self createWithType:CRS_DATUM_NAD27 andCode:@"NAD27" andEllipsoid:[CRSEllipsoids fromType:CRS_ELLIPSOIDS_CLARKE_1866] andName:@"North American Datum 1927"]];
    [self initializeDatum:[self createWithType:CRS_DATUM_POTSDAM andCode:@"potsdam" andTranslationX:598.1 andTranslationY:73.7 andTranslationZ:418.2 andRotationX:0.202 andRotationY:0.045 andRotationZ:-2.455 andScaleDifference:6.7 andEllipsoid:[CRSEllipsoids fromType:CRS_ELLIPSOIDS_BESSEL] andNames:[NSArray arrayWithObjects:@"Potsdam Rauenberg 1950 DHDN", @"Deutsches Hauptdreiecksnetz", nil]]];
    [self initializeDatum:[self createWithType:CRS_DATUM_CARTHAGE andCode:@"carthage" andTranslationX:-263.0 andTranslationY:6.0 andTranslationZ:431.0 andEllipsoid:[CRSEllipsoids fromType:CRS_ELLIPSOIDS_CLARKE_1880] andNames:[NSArray arrayWithObjects:@"Carthage 1934 Tunisia", @"Carthage", nil]]];
    [self initializeDatum:[self createWithType:CRS_DATUM_HERMANNSKOGEL andCode:@"hermannskogel" andTranslationX:577.326 andTranslationY:90.129 andTranslationZ:463.919 andRotationX:5.137 andRotationY:1.474 andRotationZ:5.297 andScaleDifference:2.4232 andEllipsoid:[CRSEllipsoids fromType:CRS_ELLIPSOIDS_BESSEL] andNames:[NSArray arrayWithObjects:@"Hermannskogel", @"Militar-Geographische Institut", @"Militar Geographische Institute", nil]]];
    [self initializeDatum:[self createWithType:CRS_DATUM_IRE65 andCode:@"ire65" andTranslationX:482.530 andTranslationY:-130.596 andTranslationZ:564.557 andRotationX:-1.042 andRotationY:-0.214 andRotationZ:-0.631 andScaleDifference:8.15 andEllipsoid:[CRSEllipsoids fromType:CRS_ELLIPSOIDS_MOD_AIRY] andNames:[NSArray arrayWithObjects:@"Ireland 1965", @"TM65", nil]]];
    [self initializeDatum:[self createWithType:CRS_DATUM_NZGD49 andCode:@"nzgd49" andTranslationX:59.47 andTranslationY:-5.04 andTranslationZ:187.44 andRotationX:0.47 andRotationY:-0.1 andRotationZ:1.024 andScaleDifference:-4.5993 andEllipsoid:[CRSEllipsoids fromType:CRS_ELLIPSOIDS_INTERNATIONAL] andName:@"New Zealand Geodetic Datum 1949"]];
    [self initializeDatum:[self createWithType:CRS_DATUM_OSGB36 andCode:@"OSGB36" andTranslationX:446.448 andTranslationY:-125.157 andTranslationZ:542.06 andRotationX:0.15 andRotationY:0.247 andRotationZ:0.842 andScaleDifference:-20.489 andEllipsoid:[CRSEllipsoids fromType:CRS_ELLIPSOIDS_AIRY] andNames:[NSArray arrayWithObjects:@"Airy 1830", @"OSGB 1936", @"Ordnance Survey of Great Britain 1936", nil]]];

}

+(void) initializeDatum: (CRSGeoDatums *) datum{
    
    [typeDatums setObject:datum forKey:[NSNumber numberWithInt:datum.type]];
    
    [nameDatums setObject:datum forKey:[datum.code lowercaseString]];
    for(NSString *name in datum.names){
        NSString *lowercaseName = [name lowercaseString];
        [nameDatums setObject:datum forKey:lowercaseName];
    }
}

+(CRSGeoDatums *) createWithType: (CRSGeoDatumType) type andCode: (NSString *) code andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andEllipsoid:ellipsoid andName:name];
}

+(CRSGeoDatums *) createWithType: (CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andTranslationX:xTranslation andTranslationY:yTranslation andTranslationZ:zTranslation andEllipsoid:ellipsoid andName:name];
}

+(CRSGeoDatums *) createWithType: (CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andRotationX: (double) xRotation andRotationY: (double) yRotation andRotationZ: (double) zRotation andScaleDifference: (double) scaleDifference andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andTranslationX:xTranslation andTranslationY:yTranslation andTranslationZ:zTranslation andRotationX:xRotation andRotationY:yRotation andRotationZ:zRotation andScaleDifference:scaleDifference andEllipsoid:ellipsoid andName:name];
}

+(CRSGeoDatums *) createWithType: (CRSGeoDatumType) type andCode: (NSString *) code andTransform: (NSArray<NSDecimalNumber *> *) transform andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andTransform:transform andEllipsoid:ellipsoid andName:name];
}

+(CRSGeoDatums *) createWithType: (CRSGeoDatumType) type andCode: (NSString *) code andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andEllipsoid:ellipsoid andNames:names];
}

+(CRSGeoDatums *) createWithType: (CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andTranslationX:xTranslation andTranslationY:yTranslation andTranslationZ:zTranslation andEllipsoid:ellipsoid andNames:names];
}

+(CRSGeoDatums *) createWithType: (CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andRotationX: (double) xRotation andRotationY: (double) yRotation andRotationZ: (double) zRotation andScaleDifference: (double) scaleDifference andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andTranslationX:xTranslation andTranslationY:yTranslation andTranslationZ:zTranslation andRotationX:xRotation andRotationY:yRotation andRotationZ:zRotation andScaleDifference:scaleDifference andEllipsoid:ellipsoid andNames:names];
}

+(CRSGeoDatums *) createWithType: (CRSGeoDatumType) type andCode: (NSString *) code andTransform: (NSArray<NSDecimalNumber *> *) transform andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andTransform:transform andEllipsoid:ellipsoid andNames:names];
}

+(CRSGeoDatums *) fromType: (CRSGeoDatumType) type{
    return [typeDatums objectForKey:[NSNumber numberWithInt:type]];
}

+(CRSGeoDatums *) fromName: (NSString *) name{
    return [nameDatums objectForKey:[name lowercaseString]];
}

-(instancetype) initWithType: (CRSGeoDatumType) type andCode: (NSString *) code andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [self initWithType:type andCode:code andEllipsoid:ellipsoid andNames:[NSArray arrayWithObject:name]];
}

-(instancetype) initWithType: (CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [self initWithType:type andCode:code andTranslationX:xTranslation andTranslationY:yTranslation andTranslationZ:zTranslation andEllipsoid:ellipsoid andNames:[NSArray arrayWithObject:name]];
}

-(instancetype) initWithType: (CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andRotationX: (double) xRotation andRotationY: (double) yRotation andRotationZ: (double) zRotation andScaleDifference: (double) scaleDifference andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [self initWithType:type andCode:code andTranslationX:xTranslation andTranslationY:yTranslation andTranslationZ:zTranslation andRotationX:xRotation andRotationY:yRotation andRotationZ:zRotation andScaleDifference:scaleDifference andEllipsoid:ellipsoid andNames:[NSArray arrayWithObject:name]];
}

-(instancetype) initWithType: (CRSGeoDatumType) type andCode: (NSString *) code andTransform: (NSArray<NSDecimalNumber *> *) transform andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [self initWithType:type andCode:code andTransform:transform andEllipsoid:ellipsoid andNames:[NSArray arrayWithObject:name]];
}

-(instancetype) initWithType: (CRSGeoDatumType) type andCode: (NSString *) code andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [self initWithType:type andCode:code andTransform:nil andEllipsoid:ellipsoid andNames:names];
}

-(instancetype) initWithType: (CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [self initWithType:type andCode:code
                 andTransform:[NSArray arrayWithObjects:
                               [[NSDecimalNumber alloc] initWithDouble:xTranslation],
                               [[NSDecimalNumber alloc] initWithDouble:yTranslation],
                               [[NSDecimalNumber alloc] initWithDouble:zTranslation],
                               nil]
                 andEllipsoid:ellipsoid andNames:names];
}

-(instancetype) initWithType: (CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andRotationX: (double) xRotation andRotationY: (double) yRotation andRotationZ: (double) zRotation andScaleDifference: (double) scaleDifference andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [self initWithType:type andCode:code
                 andTransform:[NSArray arrayWithObjects:
                               [[NSDecimalNumber alloc] initWithDouble:xTranslation],
                               [[NSDecimalNumber alloc] initWithDouble:yTranslation],
                               [[NSDecimalNumber alloc] initWithDouble:zTranslation],
                               [[NSDecimalNumber alloc] initWithDouble:xRotation],
                               [[NSDecimalNumber alloc] initWithDouble:yRotation],
                               [[NSDecimalNumber alloc] initWithDouble:zRotation],
                               [[NSDecimalNumber alloc] initWithDouble:scaleDifference],
                               nil]
                 andEllipsoid:ellipsoid andNames:names];
}

-(instancetype) initWithType: (CRSGeoDatumType) type andCode: (NSString *) code andTransform: (NSArray<NSDecimalNumber *> *) transform andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    self = [super init];
    if(self != nil){
        _type = type;
        _code = code;
        _transform = transform;
        _ellipsoid = ellipsoid;
        NSMutableArray *tempNames = [NSMutableArray array];
        for(NSString *name in names){
            if(![tempNames containsObject:name]){
                [tempNames addObject:name];
            }
            NSString *underscore = [name stringByReplacingOccurrencesOfString:@" " withString:@"_"];
            if(![tempNames containsObject:underscore]){
                [tempNames addObject:underscore];
            }
        }
        _names = tempNames;
    }
    return self;
}

-(CRSGeoDatumType) type{
    return _type;
}

-(NSString *) code{
    return _code;
}

-(NSString *) name{
    return [_names firstObject];
}

-(NSArray<NSString *> *) names{
    return _names;
}

-(NSArray<NSDecimalNumber *> *) transform{
    return _transform;
}

-(CRSEllipsoids *) ellipsoid{
    return _ellipsoid;
}

-(NSString *) description{
    return [self code];
}

-(BOOL) isEqual: (id) object{
    if(self == object){
        return YES;
    }
    
    if(![object isKindOfClass:[CRSGeoDatums class]]){
        return NO;
    }
    
    CRSGeoDatums *geoDatum = (CRSGeoDatums *) object;
    if(_type != geoDatum.type){
        return NO;
    }
    if(_code == nil){
        if (geoDatum.code != nil){
            return NO;
        }
    }else if(![_code isEqualToString:geoDatum.code]){
        return NO;
    }
    if(_names == nil){
        if(geoDatum.names != nil){
            return NO;
        }
    }else if(![_names isEqual:geoDatum.names]){
        return NO;
    }
    if(_transform == nil){
        if(geoDatum.transform != nil){
            return NO;
        }
    }else if(![_transform isEqual:geoDatum.transform]){
        return NO;
    }
    if(_ellipsoid == nil){
        if(geoDatum.ellipsoid != nil){
            return NO;
        }
    }else if(![_ellipsoid isEqual:geoDatum.ellipsoid]){
        return NO;
    }
    return YES;
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [[NSNumber numberWithInt:_type] hash];
    result = prime * result + [_code hash];
    result = prime * result + [_names hash];
    result = prime * result + ((_transform == nil) ? 0 : [_transform hash]);
    result = prime * result + [_ellipsoid hash];
    return result;
}

@end
