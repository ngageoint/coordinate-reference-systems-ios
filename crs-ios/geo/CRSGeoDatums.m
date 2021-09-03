//
//  CRSGeoDatums.m
//  crs-ios
//
//  Created by Brian Osborn on 9/2/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSGeoDatums.h"

@interface CRSGeoDatums()

@property (nonatomic) enum CRSGeoDatumType type;
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
    
    [self initializeDatum:[self createWithType:CRS_DATUM_WGS84 andCode:@"WGS84" andTranslationX:0 andTranslationY:0 andTranslationZ:0 andEllipsoid:nil andNames:[NSArray arrayWithObjects:@"WGS84", @"World Geodetic System 1984 ensemble", @"WGS 1984", @"WGS 84", nil]]];
    // TODO
    
}

+(void) initializeDatum: (CRSGeoDatums *) datum{
    
    [typeDatums setObject:datum forKey:[NSNumber numberWithInt:datum.type]];
    
    [nameDatums setObject:datum forKey:[datum.code lowercaseString]];
    for(NSString *name in datum.names){
        NSString *lowercaseName = [name lowercaseString];
        [nameDatums setObject:datum forKey:lowercaseName];
    }
}

+(CRSGeoDatums *) createWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andEllipsoid:ellipsoid andName:name];
}

+(CRSGeoDatums *) createWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andTranslationX:xTranslation andTranslationY:yTranslation andTranslationZ:zTranslation andEllipsoid:ellipsoid andName:name];
}

+(CRSGeoDatums *) createWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andRotationX: (double) xRotation andRotationY: (double) yRotation andRotationZ: (double) zRotation andScaleDifference: (double) scaleDifference andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andTranslationX:xTranslation andTranslationY:yTranslation andTranslationZ:zTranslation andRotationX:xRotation andRotationY:yRotation andRotationZ:zRotation andScaleDifference:scaleDifference andEllipsoid:ellipsoid andName:name];
}

+(CRSGeoDatums *) createWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andTransform: (NSArray<NSDecimalNumber *> *) transform andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andTransform:transform andEllipsoid:ellipsoid andName:name];
}

+(CRSGeoDatums *) createWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andEllipsoid:ellipsoid andNames:names];
}

+(CRSGeoDatums *) createWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andTranslationX:xTranslation andTranslationY:yTranslation andTranslationZ:zTranslation andEllipsoid:ellipsoid andNames:names];
}

+(CRSGeoDatums *) createWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andRotationX: (double) xRotation andRotationY: (double) yRotation andRotationZ: (double) zRotation andScaleDifference: (double) scaleDifference andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andTranslationX:xTranslation andTranslationY:yTranslation andTranslationZ:zTranslation andRotationX:xRotation andRotationY:yRotation andRotationZ:zRotation andScaleDifference:scaleDifference andEllipsoid:ellipsoid andNames:names];
}

+(CRSGeoDatums *) createWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andTransform: (NSArray<NSDecimalNumber *> *) transform andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [[CRSGeoDatums alloc] initWithType:type andCode:code andTransform:transform andEllipsoid:ellipsoid andNames:names];
}

+(CRSGeoDatums *) fromType: (enum CRSGeoDatumType) type{
    return [typeDatums objectForKey:[NSNumber numberWithInt:type]];
}

+(CRSGeoDatums *) fromName: (NSString *) name{
    return [nameDatums objectForKey:[name lowercaseString]];
}

-(instancetype) initWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [self initWithType:type andCode:code andEllipsoid:ellipsoid andNames:[NSArray arrayWithObject:name]];
}

-(instancetype) initWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [self initWithType:type andCode:code andTranslationX:xTranslation andTranslationY:yTranslation andTranslationZ:zTranslation andEllipsoid:ellipsoid andNames:[NSArray arrayWithObject:name]];
}

-(instancetype) initWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andRotationX: (double) xRotation andRotationY: (double) yRotation andRotationZ: (double) zRotation andScaleDifference: (double) scaleDifference andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [self initWithType:type andCode:code andTranslationX:xTranslation andTranslationY:yTranslation andTranslationZ:zTranslation andRotationX:xRotation andRotationY:yRotation andRotationZ:zRotation andScaleDifference:scaleDifference andEllipsoid:ellipsoid andNames:[NSArray arrayWithObject:name]];
}

-(instancetype) initWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andTransform: (NSArray<NSDecimalNumber *> *) transform andEllipsoid: (CRSEllipsoids *) ellipsoid andName: (NSString *) name{
    return [self initWithType:type andCode:code andTransform:transform andEllipsoid:ellipsoid andNames:[NSArray arrayWithObject:name]];
}

-(instancetype) initWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [self initWithType:type andCode:code andTransform:nil andEllipsoid:ellipsoid andNames:names];
}

-(instancetype) initWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
    return [self initWithType:type andCode:code
                 andTransform:[NSArray arrayWithObjects:
                               [[NSDecimalNumber alloc] initWithDouble:xTranslation],
                               [[NSDecimalNumber alloc] initWithDouble:yTranslation],
                               [[NSDecimalNumber alloc] initWithDouble:zTranslation],
                               nil]
                 andEllipsoid:ellipsoid andNames:names];
}

-(instancetype) initWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andTranslationX: (double) xTranslation andTranslationY: (double) yTranslation andTranslationZ: (double) zTranslation andRotationX: (double) xRotation andRotationY: (double) yRotation andRotationZ: (double) zRotation andScaleDifference: (double) scaleDifference andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
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

-(instancetype) initWithType: (enum CRSGeoDatumType) type andCode: (NSString *) code andTransform: (NSArray<NSDecimalNumber *> *) transform andEllipsoid: (CRSEllipsoids *) ellipsoid andNames: (NSArray<NSString *> *) names{
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

-(enum CRSGeoDatumType) type{
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
