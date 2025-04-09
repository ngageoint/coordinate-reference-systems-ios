//
//  CRSKeyword.m
//  crs-ios
//
//  Created by Brian Osborn on 7/22/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSKeyword.h>

@interface CRSKeyword()

@property (nonatomic) CRSKeywordType type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray<NSString *> *keywords;

@end

@implementation CRSKeyword

/**
 * Keyword to type mapping
 */
static NSMutableDictionary<NSString *, NSMutableArray<CRSKeyword *> *> *keywordTypes = nil;

/**
 * Keyword type to keyword mapping
 */
static NSMutableDictionary<NSNumber *, CRSKeyword *> *typeKeywords = nil;

+(void) initialize{
    keywordTypes = [NSMutableDictionary dictionary];
    typeKeywords = [NSMutableDictionary dictionary];
    
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_ABRIDGEDTRANSFORMATION andName:@"ABRIDGEDTRANSFORMATION"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_ANCHOR andName:@"ANCHOR"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_ANGLEUNIT andName:@"ANGLEUNIT" andKeyword:@"UNIT"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_AREA andName:@"AREA"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_AXIS andName:@"AXIS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_BASEENGCRS andName:@"BASEENGCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_BASEGEODCRS andName:@"BASEGEODCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_BASEGEOGCRS andName:@"BASEGEOGCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_BASEPARAMCRS andName:@"BASEPARAMCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_BASEPROJCRS andName:@"BASEPROJCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_BASETIMECRS andName:@"BASETIMECRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_BASEVERTCRS andName:@"BASEVERTCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_BBOX andName:@"BBOX"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_BEARING andName:@"BEARING"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_BOUNDCRS andName:@"BOUNDCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_CALENDAR andName:@"CALENDAR"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_CITATION andName:@"CITATION"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_CONVERSION andName:@"CONVERSION"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_COMPOUNDCRS andName:@"COMPOUNDCRS" andKeyword:@"COMPD_CS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_CONCATENATEDOPERATION andName:@"CONCATENATEDOPERATION"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_COORDINATEMETADATA andName:@"COORDINATEMETADATA"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_COORDINATEOPERATION andName:@"COORDINATEOPERATION"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_CS andName:@"CS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_DATUM andName:@"DATUM" andKeywords:[NSArray arrayWithObjects:@"GEODETICDATUM", @"TRF", nil]]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_DERIVEDPROJCRS andName:@"DERIVEDPROJCRS" andKeyword:@"DERIVEDPROJECTEDCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_DERIVINGCONVERSION andName:@"DERIVINGCONVERSION"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_DYNAMIC andName:@"DYNAMIC"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_EDATUM andName:@"EDATUM" andKeywords:[NSArray arrayWithObjects:@"ENGINEERINGDATUM", @"LOCAL_DATUM", nil]]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_ELLIPSOID andName:@"ELLIPSOID" andKeyword:@"SPHEROID"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_ENGCRS andName:@"ENGCRS" andKeyword:@"ENGINEERINGCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_ENSEMBLE andName:@"ENSEMBLE"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_ENSEMBLEACCURACY andName:@"ENSEMBLEACCURACY"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_EPOCH andName:@"EPOCH" andKeyword:@"COORDEPOCH"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_EXTENSION andName:@"EXTENSION"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_FRAMEEPOCH andName:@"FRAMEEPOCH"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_GEOCCS andName:@"GEOCCS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_GEODCRS andName:@"GEODCRS" andKeyword:@"GEODETICCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_GEOGCS andName:@"GEOGCS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_GEOGCRS andName:@"GEOGCRS" andKeyword:@"GEOGRAPHICCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_GEOIDMODEL andName:@"GEOIDMODEL"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_ID andName:@"ID" andKeyword:@"AUTHORITY"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_INTERPOLATIONCRS andName:@"INTERPOLATIONCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_LENGTHUNIT andName:@"LENGTHUNIT" andKeyword:@"UNIT"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_LOCAL_CS andName:@"LOCAL_CS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_MEMBER andName:@"MEMBER"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_MERIDIAN andName:@"MERIDIAN"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_METHOD andName:@"METHOD" andKeyword:@"PROJECTION"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_MODEL andName:@"MODEL" andKeyword:@"VELOCITYGRID"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_OPERATIONACCURACY andName:@"OPERATIONACCURACY"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_ORDER andName:@"ORDER"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_PARAMETER andName:@"PARAMETER"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_PARAMETERFILE andName:@"PARAMETERFILE"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_PARAMETRICCRS andName:@"PARAMETRICCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_PARAMETRICUNIT andName:@"PARAMETRICUNIT"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_PDATUM andName:@"PDATUM" andKeyword:@"PARAMETRICDATUM"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_POINTMOTIONOPERATION andName:@"POINTMOTIONOPERATION"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_PRIMEM andName:@"PRIMEM" andKeyword:@"PRIMEMERIDIAN"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_PROJCRS andName:@"PROJCRS" andKeyword:@"PROJECTEDCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_PROJCS andName:@"PROJCS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_REMARK andName:@"REMARK"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_SCALEUNIT andName:@"SCALEUNIT" andKeyword:@"UNIT"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_SCOPE andName:@"SCOPE"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_SOURCECRS andName:@"SOURCECRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_STEP andName:@"STEP"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_TARGETCRS andName:@"TARGETCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_TDATUM andName:@"TDATUM" andKeyword:@"TIMEDATUM"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_TIMECRS andName:@"TIMECRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_TIMEEXTENT andName:@"TIMEEXTENT"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_TIMEORIGIN andName:@"TIMEORIGIN"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_TIMEUNIT andName:@"TIMEUNIT" andKeyword:@"TEMPORALQUANTITY"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_TOWGS84 andName:@"TOWGS84" andKeyword:@"ABRIDGEDTRANSFORMATION"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_TRIAXIAL andName:@"TRIAXIAL"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_USAGE andName:@"USAGE"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_URI andName:@"URI"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_VDATUM andName:@"VDATUM" andKeywords:[NSArray arrayWithObjects:@"VRF", @"VERTICALDATUM", @"VERT_DATUM", nil]]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_VERSION andName:@"VERSION"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_VERT_CS andName:@"VERT_CS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_VERTCRS andName:@"VERTCRS" andKeyword:@"VERTICALCRS"]];
    [self initializeKeyword:[CRSKeyword createWithType:CRS_KEYWORD_VERTICALEXTENT andName:@"VERTICALEXTENT"]];

}

+(void) initializeKeyword: (CRSKeyword *) keyword{
    
    for(NSString *kw in keyword.keywords){
        NSString *kwUpperCase = [kw uppercaseString];
        NSMutableArray<CRSKeyword *> *typesArray = [keywordTypes objectForKey:kwUpperCase];
        if(typesArray == nil){
            typesArray = [NSMutableArray array];
            [keywordTypes setObject:typesArray forKey:kwUpperCase];
        }
        [typesArray addObject:keyword];
    }
    
    [typeKeywords setObject:keyword forKey:[NSNumber numberWithInt:keyword.type]];
    
}

+(CRSKeyword *) createWithType: (CRSKeywordType) type andName: (NSString *) name{
    return [[CRSKeyword alloc] initWithType:type andName:name];
}

+(CRSKeyword *) createWithType: (CRSKeywordType) type andName: (NSString *) name andKeyword: (NSString *) keyword{
    return [[CRSKeyword alloc] initWithType:type andName:name andKeyword:keyword];
}

+(CRSKeyword *) createWithType: (CRSKeywordType) type andName: (NSString *) name andKeywords: (NSArray<NSString *> *) keywords{
    return [[CRSKeyword alloc] initWithType:type andName:name andKeywords:keywords];
}

-(instancetype) initWithType: (CRSKeywordType) type andName: (NSString *) name{
    return [self initWithType:type andName:name andKeywords:nil];
}

-(instancetype) initWithType: (CRSKeywordType) type andName: (NSString *) name andKeyword: (NSString *) keyword{
    return [self initWithType:type andName:name andKeywords:[NSArray arrayWithObject:keyword]];
}

-(instancetype) initWithType: (CRSKeywordType) type andName: (NSString *) name andKeywords: (NSArray<NSString *> *) keywords{
    self = [super init];
    if(self != nil){
        _keywords = [NSMutableArray array];
        _type = type;
        _name = name;
        [_keywords addObject:name];
        if(keywords != nil){
            [_keywords addObjectsFromArray:keywords];
        }
    }
    return self;
}

-(CRSKeywordType) type{
    return _type;
}

-(NSString *) name{
    return _name;
}

-(NSArray<NSString *> *) keywords{
    return _keywords;
}

-(BOOL) isEqualToKeyword: (CRSKeyword *) keyword{
    if (self == keyword){
        return YES;
    }
    if (keyword == nil){
        return NO;
    }
    if(_type != keyword.type){
        return NO;
    }
    return YES;
}

-(BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSKeyword class]]) {
        return NO;
    }
    
    return [self isEqualToKeyword:(CRSKeyword *)object];
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [[NSNumber numberWithInt:_type] hash];
    return result;
}

+(CRSKeyword *) keyword: (NSString *) keyword{
    CRSKeyword *kw = nil;
    NSArray<CRSKeyword *> *keywords = [self keywords:keyword];
    if(keywords != nil && keywords.count > 0){
        kw = [keywords firstObject];
    }
    return kw;
}

+(CRSKeywordType) type: (NSString *) keyword{
    CRSKeywordType type = -1;
    CRSKeyword *kw = [self keyword:keyword];
    if(kw != nil){
        type = kw.type;
    }
    return type;
}

+(CRSKeyword *) requiredKeyword: (NSString *) keyword{
    CRSKeyword *kw = [self keyword:keyword];
    if(kw == nil){
        [NSException raise:@"No Keyword" format:@"No Coordinate Reference System Keyword for value: %@", keyword];
    }
    return kw;
}

+(CRSKeywordType) requiredType: (NSString *) keyword{
    CRSKeywordType type = [self type:keyword];
    if((int)type == -1){
        [NSException raise:@"No Keyword" format:@"No Coordinate Reference System Keyword for value: %@", keyword];
    }
    return type;
}

+(NSArray<CRSKeyword *> *) keywords: (NSString *) keyword{
    NSArray<CRSKeyword *> *keywords = nil;
    if(keyword != nil){
        keywords = [keywordTypes objectForKey:[keyword uppercaseString]];
    }
    return keywords;
}

+(NSArray<NSNumber *> *) types: (NSString *) keyword{
    NSMutableArray<NSNumber *> *types = nil;
    NSArray<CRSKeyword *> *keywords = [self keywords:keyword];
    if(keywords != nil){
        types = [NSMutableArray array];
        for(CRSKeyword *kw in keywords){
            [types addObject:[NSNumber numberWithInt:kw.type]];
        }
    }
    return types;
}

+(NSArray<CRSKeyword *> *) requiredKeywords: (NSString *) keyword{
    NSArray<CRSKeyword *> *keywords = [self keywords:keyword];
    if(keywords == nil){
        [NSException raise:@"No Keywords" format:@"No Coordinate Reference System Keywords for value: %@", keyword];
    }
    return keywords;
}

+(NSArray<NSNumber *> *) requiredTypes: (NSString *) keyword{
    NSArray<NSNumber *> *types = [self types:keyword];
    if(types == nil){
        [NSException raise:@"No Keyword Types" format:@"No Coordinate Reference System Keyword Types for value: %@", keyword];
    }
    return types;
}

+(CRSKeyword *) keywordOfType: (CRSKeywordType) type{
    return [typeKeywords objectForKey:[NSNumber numberWithInt:type]];
}

+(NSString *) nameOfType: (CRSKeywordType) type{
    NSString *name = nil;
    CRSKeyword *keyword = [self keywordOfType:type];
    if(keyword != nil){
        name = keyword.name;
    }
    return name;
}

@end
