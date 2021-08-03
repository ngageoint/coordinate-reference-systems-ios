//
//  CRSReader.m
//  crs-ios
//
//  Created by Brian Osborn on 7/22/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSReader.h"
#import "CRSTextUtils.h"
#import "CRSTextConstants.h"
#import "CRSTriaxialEllipsoid.h"

@interface CRSReader()

/**
 * Text Reader
 */
@property (nonatomic, strong) CRSTextReader *reader;

@end

@implementation CRSReader

+(CRSObject *) read: (NSString *) text{
    return [self read:text withStrict:NO];
}

+(CRSObject *) read: (NSString *) text withStrict: (BOOL) strict{
    CRSReader *reader = [CRSReader createWithText:text andStrict:strict];
    CRSObject *crs = [reader read];
    [reader readEnd];
    return crs;
}

+(CRSObject *) read: (NSString *) text withType: (enum CRSType) expected{
    return [self read:text withStrict:NO andType:expected];
}

+(CRSObject *) read: (NSString *) text withTypes: (NSArray<NSNumber *> *) expected{
    return [self read:text withStrict:NO andTypes:expected];
}

+(CRSObject *) read: (NSString *) text withStrict: (BOOL) strict andType: (enum CRSType) expected{
    return [self read:text withStrict:strict andTypes:[NSArray arrayWithObject:[NSNumber numberWithInt:expected]]];
}

+(CRSObject *) read: (NSString *) text withStrict: (BOOL) strict andTypes: (NSArray<NSNumber *> *) expected{
    CRSObject *crs = [self read:text withStrict:strict];
    if(![expected containsObject:[NSNumber numberWithInt:crs.type]]){
        [NSException raise:@"Unexpected CRS Type" format:@"Unexpected Coordinate Reference System Type: %@, Expected: %@", [CRSTypes name:crs.type], [CRSTypes names:expected]];
    }
    return crs;
}

+(CRSCoordinateReferenceSystem *) readCoordinateReferenceSystem: (NSString *) text{
    return [self readCoordinateReferenceSystem:text withStrict:NO];
}

+(CRSCoordinateReferenceSystem *) readCoordinateReferenceSystem: (NSString *) text withStrict: (BOOL) strict{
    return (CRSCoordinateReferenceSystem *) [self read:text withStrict:strict andTypes:[NSArray arrayWithObjects:
                                                                                        [NSNumber numberWithInt:CRS_TYPE_GEODETIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_GEOGRAPHIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_PROJECTED],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_VERTICAL],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_ENGINEERING],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_PARAMETRIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_TEMPORAL],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_DERIVED],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_COMPOUND],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_BOUND],
                                                                                        nil]];
}

+(CRSSimpleCoordinateReferenceSystem *) readSimpleCoordinateReferenceSystem: (NSString *) text{
    return [self readSimpleCoordinateReferenceSystem:text withStrict:NO];
}

+(CRSSimpleCoordinateReferenceSystem *) readSimpleCoordinateReferenceSystem: (NSString *) text withStrict: (BOOL) strict{
    return (CRSSimpleCoordinateReferenceSystem *) [self read:text withStrict:strict andTypes:[NSArray arrayWithObjects:
                                                                                        [NSNumber numberWithInt:CRS_TYPE_GEODETIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_GEOGRAPHIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_PROJECTED],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_VERTICAL],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_ENGINEERING],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_PARAMETRIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_TEMPORAL],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_DERIVED],
                                                                                        nil]];
}

+(CRSGeoCoordinateReferenceSystem *) readGeo: (NSString *) text{
    return (CRSGeoCoordinateReferenceSystem *) [self read:text withTypes:[NSArray arrayWithObjects:
                                                                                        [NSNumber numberWithInt:CRS_TYPE_GEODETIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_GEOGRAPHIC],
                                                                                        nil]];
}

+(CRSGeoCoordinateReferenceSystem *) readGeodetic: (NSString *) text{
    return (CRSGeoCoordinateReferenceSystem *) [self read:text withType:CRS_TYPE_GEODETIC];
}

+(CRSGeoCoordinateReferenceSystem *) readGeographic: (NSString *) text{
    return (CRSGeoCoordinateReferenceSystem *) [self read:text  withType:CRS_TYPE_GEOGRAPHIC];
}

+(CRSProjectedCoordinateReferenceSystem *) readProjected: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSProjectedCoordinateReferenceSystem *crs = [reader readProjected];
    [reader readEnd];
    return crs;
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedGeodetic: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSProjectedCoordinateReferenceSystem *crs = [reader readProjectedGeodetic];
    [reader readEnd];
    return crs;
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedGeographic: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSProjectedCoordinateReferenceSystem *crs = [reader readProjectedGeographic];
    [reader readEnd];
    return crs;
}

+(CRSVerticalCoordinateReferenceSystem *) readVertical: (NSString *) text{
    return (CRSVerticalCoordinateReferenceSystem *) [self read:text withType:CRS_TYPE_VERTICAL];
}

+(CRSEngineeringCoordinateReferenceSystem *) readEngineering: (NSString *) text{
    return (CRSEngineeringCoordinateReferenceSystem *) [self read:text withType:CRS_TYPE_ENGINEERING];
}

+(CRSParametricCoordinateReferenceSystem *) readParametric: (NSString *) text{
    return (CRSParametricCoordinateReferenceSystem *) [self read:text withType:CRS_TYPE_PARAMETRIC];
}

+(CRSTemporalCoordinateReferenceSystem *) readTemporal: (NSString *) text{
    return (CRSTemporalCoordinateReferenceSystem *) [self read:text withType:CRS_TYPE_TEMPORAL];
}

+(CRSDerivedCoordinateReferenceSystem *) readDerived: (NSString *) text{
    return (CRSDerivedCoordinateReferenceSystem *) [self read:text withType:CRS_TYPE_DERIVED];
}

+(CRSCompoundCoordinateReferenceSystem *) readCompound: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSCompoundCoordinateReferenceSystem *crs = [reader readCompound];
    [reader readEnd];
    return crs;
}

+(CRSCoordinateMetadata *) readCoordinateMetadata: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSCoordinateMetadata *metadata = [reader readCoordinateMetadata];
    [reader readEnd];
    return metadata;
}

+(CRSCoordinateOperation *) readCoordinateOperation: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSCoordinateOperation *operation = [reader readCoordinateOperation];
    [reader readEnd];
    return operation;
}

+(CRSPointMotionOperation *) readPointMotionOperation: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSPointMotionOperation *operation = [reader readPointMotionOperation];
    [reader readEnd];
    return operation;
}

+(CRSConcatenatedOperation *) readConcatenatedOperation: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSConcatenatedOperation *operation = [reader readConcatenatedOperation];
    [reader readEnd];
    return operation;
}

+(CRSBoundCoordinateReferenceSystem *) readBound: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSBoundCoordinateReferenceSystem *crs = [reader readBound];
    [reader readEnd];
    return crs;
}

+(CRSGeoCoordinateReferenceSystem *) readGeoCompat: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSGeoCoordinateReferenceSystem *crs = [reader readGeoCompat];
    [reader readEnd];
    return crs;
}

+(CRSGeoCoordinateReferenceSystem *) readGeodeticCompat: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSGeoCoordinateReferenceSystem *crs = [reader readGeodeticCompat];
    [reader readEnd];
    return crs;
}

+(CRSGeoCoordinateReferenceSystem *) readGeographicCompat: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSGeoCoordinateReferenceSystem *crs = [reader readGeographicCompat];
    [reader readEnd];
    return crs;
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedCompat: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSProjectedCoordinateReferenceSystem *crs = [reader readProjectedCompat];
    [reader readEnd];
    return crs;
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedGeodeticCompat: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSProjectedCoordinateReferenceSystem *crs = [reader readProjectedGeodeticCompat];
    [reader readEnd];
    return crs;
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedGeographicCompat: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSProjectedCoordinateReferenceSystem *crs = [reader readProjectedGeographicCompat];
    [reader readEnd];
    return crs;
}

+(CRSReader *) createWithText: (NSString *) text{
    return [[CRSReader alloc] initWithText:text];
}

+(CRSReader *) createWithReader: (CRSTextReader *) reader{
    return [[CRSReader alloc] initWithReader:reader];
}

+(CRSReader *) createWithText: (NSString *) text andStrict: (BOOL) strict{
    return [[CRSReader alloc] initWithText:text andStrict:strict];
}

+(CRSReader *) createWithReader: (CRSTextReader *) reader andStrict: (BOOL) strict{
    return [[CRSReader alloc] initWithReader:reader andStrict:strict];
}

-(instancetype) initWithText: (NSString *) text{
    return [self initWithReader:[CRSTextReader createWithText:text]];
}

-(instancetype) initWithReader: (CRSTextReader *) reader{
    return [self initWithReader:reader andStrict:NO];
}

-(instancetype) initWithText: (NSString *) text andStrict: (BOOL) strict{
    return [self initWithReader:[CRSTextReader createWithText:text] andStrict:strict];
}

-(instancetype) initWithReader: (CRSTextReader *) reader andStrict: (BOOL) strict{
    self = [super init];
    if(self != nil){
        _reader = reader;
        _strict = strict;
    }
    return self;
}

-(CRSTextReader *) textReader{
    return _reader;
}

-(void) reset{
    [_reader reset];
}

-(CRSObject *) read{

    CRSObject *crs = nil;
    
    CRSKeyword *keyword = [self peekKeyword];
    switch(keyword.type){
        case CRS_KEYWORD_GEODCRS:
        case CRS_KEYWORD_GEOGCRS:
            crs = [self readGeo];
            break;
        case CRS_KEYWORD_GEOCCS:
        case CRS_KEYWORD_GEOGCS:
            crs = [self readGeoCompat];
            break;
        case CRS_KEYWORD_PROJCRS:
            crs = [self readProjected];
            break;
        case CRS_KEYWORD_PROJCS:
            crs = [self readProjectedCompat];
            break;
        case CRS_KEYWORD_VERTCRS:
            crs = [self readVertical];
            break;
        case CRS_KEYWORD_VERT_CS:
            crs = [self readVerticalCompat];
            break;
        case CRS_KEYWORD_ENGCRS:
            crs = [self readEngineering];
            break;
        case CRS_KEYWORD_LOCAL_CS:
            crs = [self readEngineeringCompat];
            break;
        case CRS_KEYWORD_PARAMETRICCRS:
            crs = [self readParametric];
            break;
        case CRS_KEYWORD_TIMECRS:
            crs = [self readTemporal];
            break;
        case CRS_KEYWORD_DERIVEDPROJCRS:
            crs = [self readDerivedProjected];
            break;
        case CRS_KEYWORD_COMPOUNDCRS:
            crs = [self readCompound];
            break;
        case CRS_KEYWORD_COORDINATEMETADATA:
            crs = [self readCoordinateMetadata];
            break;
        case CRS_KEYWORD_COORDINATEOPERATION:
            crs = [self readCoordinateOperation];
            break;
        case CRS_KEYWORD_POINTMOTIONOPERATION:
            crs = [self readPointMotionOperation];
            break;
        case CRS_KEYWORD_CONCATENATEDOPERATION:
            crs = [self readConcatenatedOperation];
            break;
        case CRS_KEYWORD_BOUNDCRS:
            crs = [self readBound];
            break;
        default:
            [NSException raise:@"Unsupported Keyword" format:@"Unsupported WKT CRS keyword: %@", keyword.name];
    }

    return crs;
}

-(CRSCoordinateReferenceSystem *) readCoordinateReferenceSystem{
    CRSObject *crs = [self read];
    if(![crs isKindOfClass:[CRSCoordinateReferenceSystem class]]){
        [NSException raise:@"Unexpected CRS Type" format:@"Unexpected Coordinate Reference System Type: %@", [CRSTypes name:crs.type]];
    }
    return (CRSCoordinateReferenceSystem *) crs;
}

-(CRSSimpleCoordinateReferenceSystem *) readSimpleCoordinateReferenceSystem{
    CRSObject *crs = [self read];
    if(![crs isKindOfClass:[CRSSimpleCoordinateReferenceSystem class]]){
        [NSException raise:@"Unexpected CRS Type" format:@"Unexpected Simple Coordinate Reference System Type: %@", [CRSTypes name:crs.type]];
    }
    return (CRSSimpleCoordinateReferenceSystem *) crs;
}

-(CRSKeyword *) readKeyword{
    return [CRSKeyword requiredKeyword:[_reader readToken]];
}

-(enum CRSKeywordType) readKeywordType{
    return [CRSKeyword requiredType:[_reader readToken]];
}

-(NSArray<CRSKeyword *> *) readKeywords{
    return [CRSKeyword requiredKeywords:[_reader readToken]];
}

-(NSArray<NSNumber *> *) readKeywordTypes{
    return [CRSKeyword requiredTypes:[_reader readToken]];
}

-(CRSKeyword *) readKeywordWithType: (enum CRSKeywordType) keyword{
    return [self readKeywordWithType:keyword andRequired:YES];
}

-(CRSKeyword *) readKeywordWithTypes: (NSArray<NSNumber *> *) keywords{
    return [self readKeywordWithTypes:keywords andRequired:YES];
}

-(CRSKeyword *) readToKeyword: (enum CRSKeywordType) keyword{
    return [self readToKeywords:[NSArray arrayWithObject:[NSNumber numberWithInt:keyword]]];
}

-(CRSKeyword *) readToKeywords: (NSArray<NSNumber *> *) keywords{
    CRSKeyword *keyword = [self readKeywordWithTypes:keywords andRequired:NO];
    if(keyword != nil){
        [_reader pushToken:keyword.name];
    }
    return keyword;
}

-(CRSKeyword *) readKeywordWithType: (enum CRSKeywordType) keyword andRequired: (BOOL) required{
    return [self readKeywordWithTypes:[NSArray arrayWithObject:[NSNumber numberWithInt:keyword]] andRequired:required];
}

-(CRSKeyword *) readKeywordWithTypes: (NSArray<NSNumber *> *) keywords andRequired: (BOOL) required{

    CRSKeyword *keyword = nil;
    NSSet<NSNumber *> *keywordSet = [NSSet setWithArray:keywords];
    
    int delimiterCount = 0;
    
    NSString *previousToken = nil;
    NSString *token = [_reader readToken];
    
    NSMutableString *ignored = nil;
    while(token != nil){
        
        if(!required){
            if([CRSTextUtils isLeftDelimiter:token]){
                delimiterCount++;
            }else if([CRSTextUtils isRightDelimiter:token]){
                delimiterCount--;
                if(delimiterCount < 0){
                    [_reader pushToken:token];
                    break;
                }
            }
        }
        
        NSArray<CRSKeyword *> *tokenKeywords = [CRSKeyword keywords:token];
        if(tokenKeywords != nil){
            for(CRSKeyword *kw in tokenKeywords){
                if([keywordSet containsObject:[NSNumber numberWithInt:kw.type]]){
                    keyword = kw;
                    break;
                }
            }
            if(keyword != nil){
                break;
            }
        }
        
        if(previousToken != nil){
            if(ignored == nil){
                ignored = [NSMutableString string];
            }
            [ignored appendString:previousToken];
        }
        
        previousToken = token;
        token = [_reader readToken];
    }
    
    if(required && keyword == nil){
        [NSException raise:@"Not Found" format:@"Expected keyword not found: %@", [self keywordNames:keywords]];
    }

    if(previousToken != nil && (keyword == nil || ![previousToken isEqualToString:CRS_WKT_SEPARATOR])){
        if(ignored == nil){
            ignored = [NSMutableString string];
        }
        [ignored appendString:previousToken];
    }

    if(ignored != nil){
        NSMutableString *log = [NSMutableString string];
        if(_strict){
            [log appendString:@"Unexpected"];
        }else{
            [log appendString:@"Ignored"];
        }
        if(keyword != nil){
            [log appendString:@" before "];
            [log appendFormat:@"%@", keyword.keywords];
        }
        [log appendString:@": \""];
        [log appendString:ignored];
        [log appendString:@"\""];
        if(_strict){
            [NSException raise:@"Unexpected" format:@"%@", log];
        }else{
            NSLog(@"%@", log);
        }
    }

    return keyword;
}

-(CRSKeyword *) peekKeyword{
    return [CRSKeyword requiredKeyword:[_reader peekToken]];
}

-(enum CRSKeywordType) peekKeywordType{
    return [CRSKeyword requiredType:[_reader peekToken]];
}

-(NSArray<CRSKeyword *> *) peekKeywords{
    return [CRSKeyword requiredKeywords:[_reader peekToken]];
}

-(NSArray<NSNumber *> *) peekKeywordTypes{
    return [CRSKeyword requiredTypes:[_reader peekToken]];
}

-(CRSKeyword *) peekOptionalKeyword{
    return [CRSKeyword keyword:[_reader peekToken]];
}

-(enum CRSKeywordType) peekOptionalKeywordType{
    return [CRSKeyword type:[_reader peekToken]];
}

-(NSArray<CRSKeyword *> *) peekOptionalKeywords{
    return [CRSKeyword keywords:[_reader peekToken]];
}

-(NSArray<NSNumber *> *) peekOptionalKeywordTypes{
    return [CRSKeyword types:[_reader peekToken]];
}

-(CRSKeyword *) peekOptionalKeywordAtNum: (int) num{
    return [CRSKeyword keyword:[_reader peekTokenAtNum:num]];
}

-(enum CRSKeywordType) peekOptionalKeywordTypeAtNum: (int) num{
    return [CRSKeyword type:[_reader peekTokenAtNum:num]];
}

-(NSArray<CRSKeyword *> *) peekOptionalKeywordsAtNum: (int) num{
    return [CRSKeyword keywords:[_reader peekTokenAtNum:num]];
}

-(NSArray<NSNumber *> *) peekOptionalKeywordTypesAtNum: (int) num{
    return [CRSKeyword types:[_reader peekTokenAtNum:num]];
}

-(void) readLeftDelimiter{
    NSString *token = [_reader readExpectedToken];
    if(![CRSTextUtils isLeftDelimiter:token]){
        [NSException raise:@"Invalid Token" format:@"Invalid left delimiter token, expected '[' or '('. found: '%@'", token];
    }
}

-(BOOL) peekLeftDelimiter{
    BOOL leftDelimiter = NO;
    NSString *token = [_reader peekToken];
    if(token != nil){
        leftDelimiter = [CRSTextUtils isLeftDelimiter:token];
    }
    return leftDelimiter;
}

-(void) readRightDelimiter{
    [self readKeywordWithTypes:[NSArray array] andRequired:NO];
    NSString *token = [_reader readExpectedToken];
    if(![CRSTextUtils isRightDelimiter:token]){
        [NSException raise:@"Invalid Token" format:@"Invalid right delimiter token, expected ']' or ')'. found: '%@'", token];
    }
}

-(BOOL) peekRightDelimiter{
    BOOL rightDelimiter = NO;
    NSString *token = [_reader peekToken];
    if(token != nil){
        rightDelimiter = [CRSTextUtils isRightDelimiter:token];
    }
    return rightDelimiter;
}

-(void) readSeparator{
    NSString *token = [_reader peekToken];
    if([token isEqualToString:CRS_WKT_SEPARATOR]){
        [_reader readExpectedToken];
    }else if(_strict){
        [NSException raise:@"Invalid Token" format:@"Invalid separator token, expected ','. found: '%@'", token];
    }else{
        NSLog(@"Missing expected separator before token: '%@'", token);
    }
}

-(BOOL) peekSeparator{
    BOOL separator = NO;
    NSString *token = [_reader peekToken];
    if(token != nil){
        separator = [token isEqualToString:CRS_WKT_SEPARATOR];
    }
    return separator;
}

-(void) readEnd{
    
    NSString *token = [_reader readToken];
    if(token != nil){
        NSMutableString *ignored = [NSMutableString string];
        do{
            [ignored appendString:token];
            token = [_reader readToken];
        }while(token != nil);
        
        NSMutableString *log = [NSMutableString string];
        if(_strict){
            [log appendString:@"Unexpected"];
        }else{
            [log appendString:@"Ignored"];
        }
        [log appendString:@" end: \""];
        [log appendString:ignored];
        [log appendString:@"\""];
        if(_strict){
            [NSException raise:@"Unexpected End" format:@"%@", log];
        }else{
            NSLog(@"%@", log);
        }
    }
}

-(NSString *) readKeywordDelimitedToken: (enum CRSKeywordType) keyword{

    [self readKeywordWithType:keyword];
    
    [self readLeftDelimiter];
    
    NSString *token = [_reader readExpectedToken];
    
    [self readRightDelimiter];

    return token;
}

/**
 * Validate the keyword against the expected keywords
 *
 * @param keyword
 *            keyword
 * @param expected
 *            expected keyword
 * @return matching keyword
 */
-(enum CRSKeywordType) validateKeyword: (enum CRSKeywordType) keyword withExpectedType: (enum CRSKeywordType) expected{
    return [self validateKeywords:[NSArray arrayWithObject:[NSNumber numberWithInt:keyword]] withExpectedType:expected];
}

/**
 * Validate the keyword against the expected keywords
 *
 * @param keyword
 *            keyword
 * @param expected
 *            expected keywords
 * @return matching keyword
 */
-(enum CRSKeywordType) validateKeyword: (enum CRSKeywordType) keyword withExpectedTypes: (NSArray<NSNumber *> *) expected{
    return [self validateKeywords:[NSArray arrayWithObject:[NSNumber numberWithInt:keyword]] withExpectedTypes:expected];
}

/**
 * Validate the keyword against the expected keywords
 *
 * @param keywords
 *            keywords
 * @param expected
 *            expected keyword
 * @return matching keyword
 */
-(enum CRSKeywordType) validateKeywords: (NSArray<NSNumber *> *) keywords withExpectedType: (enum CRSKeywordType) expected{
    return [self validateKeywords:keywords withExpectedTypes:[NSArray arrayWithObject:[NSNumber numberWithInt:expected]]];
}

/**
 * Validate the keyword against the expected keywords
 *
 * @param keywords
 *            keywords
 * @param expected
 *            expected keywords
 * @return matching keyword
 */
-(enum CRSKeywordType) validateKeywords: (NSArray<NSNumber *> *) keywords withExpectedTypes: (NSArray<NSNumber *> *) expected{
    enum CRSKeywordType keyword = -1;
    NSSet<NSNumber *> *expectedSet = [NSSet setWithArray:expected];
    for(NSNumber *kw in keywords){
        if([expectedSet containsObject:kw]){
            keyword = [kw intValue];
            break;
        }
    }
    if((int)keyword == -1){
        [NSException raise:@"Unexpected Keyword" format:@"Unexpected keyword. found: %@, expected: %@", [self keywordNames:keywords], [self keywordNames:expected]];
    }
    return keyword;
}

/**
 * Array of all keyword names from the array of keywords
 *
 * @param keywords
 *            keywords
 * @return set of names
 */
-(NSArray<NSString *> *) keywordNames: (NSArray<NSNumber *> *) keywords{
    NSMutableArray<NSString *> *names = [NSMutableArray array];
    for(CRSKeyword *keyword in keywords){
        [names addObjectsFromArray:keyword.keywords];
    }
    return names;
}

/**
 * Check if the keyword is next following an immediate next separator
 *
 * @param keyword
 *            keyword
 * @return true if next
 */
-(BOOL) isKeywordNext: (enum CRSKeywordType) keyword{
    return [self isKeywordsNext:[NSArray arrayWithObject:[NSNumber numberWithInt:keyword]]];
}

/**
 * Check if the keyword is next following an immediate next separator
 *
 * @param keywords
 *            keywords
 * @return true if next
 */
-(BOOL) isKeywordsNext: (NSArray<NSNumber *> *) keywords{
    BOOL next = NO;
    BOOL separator = [self peekSeparator];
    if(separator || !_strict){
        int num = separator ? 2 : 1;
        NSArray<NSNumber *> *nextKeywords = [self peekOptionalKeywordTypesAtNum:num];
        if(nextKeywords != nil && nextKeywords.count > 0){
            for(NSNumber *keyword in keywords){
                next = [nextKeywords containsObject:keyword];
                if(next){
                    break;
                }
            }
        }
    }
    return next;
}

/**
 * Check if the keyword is next following an immediate next separator
 *
 * @param keyword
 *            keyword
 * @return true if next
 */
-(BOOL) isNonKeywordNext{
    BOOL next = NO;
    if([self peekSeparator]){
        NSArray<CRSKeyword *> *nextKeywords = [self peekOptionalKeywordsAtNum:2];
        next = nextKeywords == nil || nextKeywords.count == 0;
    }
    return next;
}

/**
 * Is a unit next following an immediate next separator
 *
 * @return true if next
 */
-(BOOL) isUnitNext{
    return [self isKeywordsNext:[NSArray arrayWithObjects:
                                 [NSNumber numberWithInt:CRS_KEYWORD_ANGLEUNIT],
                                 [NSNumber numberWithInt:CRS_KEYWORD_LENGTHUNIT],
                                 [NSNumber numberWithInt:CRS_KEYWORD_PARAMETRICUNIT],
                                 [NSNumber numberWithInt:CRS_KEYWORD_SCALEUNIT],
                                 [NSNumber numberWithInt:CRS_KEYWORD_TIMEUNIT],
                                 nil]];
}

/**
 * Is a spatial unit next following an immediate next separator
 *
 * @return true if next
 */
-(BOOL) isSpatialUnitNext{
    return [self isKeywordsNext:[NSArray arrayWithObjects:
                                 [NSNumber numberWithInt:CRS_KEYWORD_ANGLEUNIT],
                                 [NSNumber numberWithInt:CRS_KEYWORD_LENGTHUNIT],
                                 [NSNumber numberWithInt:CRS_KEYWORD_PARAMETRICUNIT],
                                 [NSNumber numberWithInt:CRS_KEYWORD_SCALEUNIT],
                                 nil]];
}

/**
 * Is a time unit next following an immediate next separator
 *
 * @return true if next
 */
-(BOOL) isTimeUnitNext{
    return [self isKeywordNext:CRS_KEYWORD_TIMEUNIT];
}

-(CRSCoordinateReferenceSystem *) readGeo{

    CRSGeoCoordinateReferenceSystem *baseCrs = [CRSGeoCoordinateReferenceSystem create];
    CRSSimpleCoordinateReferenceSystem *crs = baseCrs;
    CRSDerivedCoordinateReferenceSystem *derivedCrs = nil;

    CRSKeyword *keyword = [self readKeywordWithTypes:[NSArray arrayWithObjects:
                                                      [NSNumber numberWithInt:CRS_KEYWORD_GEODCRS],
                                                      [NSNumber numberWithInt:CRS_KEYWORD_GEOGCRS],
                                                      nil]];
    [crs setType:[CRSTextUtils coordinateReferenceSystemType:keyword.type]];

    [self readLeftDelimiter];

    NSString *name = [_reader readExpectedToken];

    if([self isKeywordsNext:[NSArray arrayWithObjects:
                             [NSNumber numberWithInt:CRS_KEYWORD_BASEGEODCRS],
                             [NSNumber numberWithInt:CRS_KEYWORD_BASEGEOGCRS],
                             nil]]){

        switch(keyword.type) {
            case CRS_KEYWORD_GEODCRS:
                [self readKeywordWithType:CRS_KEYWORD_BASEGEODCRS];
                break;
            case CRS_KEYWORD_GEOGCRS:
                [self readKeywordWithType:CRS_KEYWORD_BASEGEOGCRS];
                break;
            default:
                [NSException raise:@"Unsupported Type" format:@"Unsupported Coordinate Reference System Type: %@", keyword.name];
        }

        derivedCrs = [CRSDerivedCoordinateReferenceSystem create];
        [derivedCrs setBase:baseCrs];
        crs = derivedCrs;

        [self readLeftDelimiter];
        [baseCrs setName:[_reader readExpectedToken]];
    }

    [crs setName:name];

    BOOL isDynamic = [self isKeywordNext:CRS_KEYWORD_DYNAMIC];
    if(isDynamic){
        [self readSeparator];
        [baseCrs setDynamic:[self readDynamic]];
    }

    if(isDynamic || [self isKeywordNext:CRS_KEYWORD_DATUM]) {
        [self readSeparator];
        CRSGeoReferenceFrame *referenceFrame = [self readGeoReferenceFrameWithCRS:crs];
        [referenceFrame setType:baseCrs.type];
        [baseCrs setReferenceFrame:referenceFrame];
    }else if([self isKeywordNext:CRS_KEYWORD_ENSEMBLE]) {
        [self readSeparator];
        [baseCrs setDatumEnsemble:[self readGeoDatumEnsemble]];
    } else {
        // Validation error
        [self readSeparator];
        [self readKeywordWithTypes:[NSArray arrayWithObjects:
                                    [NSNumber numberWithInt:CRS_KEYWORD_DATUM],
                                    [NSNumber numberWithInt:CRS_KEYWORD_ENSEMBLE],
                                    nil]];
    }

    if(derivedCrs != nil) {

        keyword = [self readToKeyword:CRS_KEYWORD_ID];
        if(keyword != nil && keyword.type == CRS_KEYWORD_ID) {
            [baseCrs setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
        }

        [self readRightDelimiter];

        [self readSeparator];
        [derivedCrs setConversion:[self readDerivingConversion]];

    }

    [self readSeparator];
    [crs setCoordinateSystem:[self readCoordinateSystem]];

    [self readScopeExtentIdentifierRemark:crs];

    [self readRightDelimiter];

    return crs;
}

-(CRSProjectedCoordinateReferenceSystem *) readProjected{
    return [self readProjectedWithType:-1];
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedGeodetic{
    return [self readProjectedWithType:CRS_TYPE_GEODETIC];
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedGeographic{
    return [self readProjectedWithType:CRS_TYPE_GEOGRAPHIC];
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedWithType: (enum CRSType) expectedBaseType{

    CRSProjectedCoordinateReferenceSystem *crs = [CRSProjectedCoordinateReferenceSystem create];

    [self readKeywordWithType:CRS_KEYWORD_PROJCRS];

    [self readLeftDelimiter];

    [crs setName:[_reader readExpectedToken]];

    [self readSeparator];

    CRSKeyword *type = [self readKeywordWithTypes:[NSArray arrayWithObjects:
                                                      [NSNumber numberWithInt:CRS_KEYWORD_BASEGEODCRS],
                                                      [NSNumber numberWithInt:CRS_KEYWORD_BASEGEOGCRS],
                                                      nil]];
    enum CRSType crsType = [CRSTextUtils coordinateReferenceSystemType:type.type];
    if(expectedBaseType >= 0 && crsType != expectedBaseType){
        [NSException raise:@"Unexpected Type" format:@"Unexpected Base Coordinate Reference System Type. expected: %@, found: %@", [CRSTypes name:expectedBaseType], [CRSTypes name:crsType]];
    }
    [crs setBaseType:crsType];

    [self readLeftDelimiter];

    [crs setBaseName:[_reader readExpectedToken]];

    BOOL isDynamic = [self isKeywordNext:CRS_KEYWORD_DYNAMIC];
    if(isDynamic){
        [self readSeparator];
        [crs setDynamic:[self readDynamic]];
    }

    if(isDynamic || [self isKeywordNext:CRS_KEYWORD_DATUM]){
        [self readSeparator];
        CRSGeoReferenceFrame *referenceFrame = [self readGeoReferenceFrameWithCRS:crs];
        [referenceFrame setType:crsType];
        [crs setReferenceFrame:referenceFrame];
    }else if ([self isKeywordNext:CRS_KEYWORD_ENSEMBLE]){
        [self readSeparator];
        [crs setDatumEnsemble:[self readGeoDatumEnsemble]];
    }else{
        // Validation error
        [self readSeparator];
        [self readKeywordWithTypes:[NSArray arrayWithObjects:
                                    [NSNumber numberWithInt:CRS_KEYWORD_DATUM],
                                    [NSNumber numberWithInt:CRS_KEYWORD_ENSEMBLE],
                                    nil]];
    }

    CRSKeyword *keyword = [self readToKeywords:[NSArray arrayWithObjects:
                                                [NSNumber numberWithInt:CRS_KEYWORD_ANGLEUNIT],
                                                [NSNumber numberWithInt:CRS_KEYWORD_ID],
                                                nil]];

    if(keyword != nil && keyword.type == CRS_KEYWORD_ANGLEUNIT){
        [crs setUnit:[self readAngleUnit]];
        keyword = [self readToKeyword:CRS_KEYWORD_ID];
    }

    if (keyword != nil && keyword.type == CRS_KEYWORD_ID) {
        [crs setBaseIdentifiers:[self readIdentifiers]];
    }

    [self readRightDelimiter];

    [self readSeparator];
    [crs setMapProjection:[self readMapProjection]];

    [self readSeparator];
    [crs setCoordinateSystem:[self readCoordinateSystem]];

    [self readScopeExtentIdentifierRemark:crs];

    [self readRightDelimiter];

    return crs;
}

-(CRSCoordinateReferenceSystem *) readVertical{

    CRSVerticalCoordinateReferenceSystem *baseCrs = [CRSVerticalCoordinateReferenceSystem create];
    CRSSimpleCoordinateReferenceSystem *crs = baseCrs;
    CRSDerivedCoordinateReferenceSystem *derivedCrs = nil;

    [self readKeywordWithType:CRS_KEYWORD_VERTCRS];

    [self readLeftDelimiter];

    NSString *name = [_reader readExpectedToken];

    if([self isKeywordNext:CRS_KEYWORD_BASEVERTCRS]){
        [self readKeywordWithType:CRS_KEYWORD_BASEVERTCRS];

        derivedCrs = [CRSDerivedCoordinateReferenceSystem create];
        [derivedCrs setBase:baseCrs];
        crs = derivedCrs;

        [self readLeftDelimiter];
        [baseCrs setName:[_reader readExpectedToken]];
    }

    [crs setName:name];

    BOOL isDynamic = [self isKeywordNext:CRS_KEYWORD_DYNAMIC];
    if(isDynamic){
        [self readSeparator];
        [baseCrs setDynamic:[self readDynamic]];
    }

    if(isDynamic || [self isKeywordNext:CRS_KEYWORD_VDATUM]){
        [self readSeparator];
        [baseCrs setReferenceFrame:[self readVerticalReferenceFrameWithCRS:crs]];
    }else if([self isKeywordNext:CRS_KEYWORD_ENSEMBLE]){
        [self readSeparator];
        [baseCrs setDatumEnsemble:[self readVerticalDatumEnsemble]];
    }else{
        // Validation error
        [self readSeparator];
        [self readKeywordWithTypes:[NSArray arrayWithObjects:
                                    [NSNumber numberWithInt:CRS_KEYWORD_VDATUM],
                                    [NSNumber numberWithInt:CRS_KEYWORD_ENSEMBLE],
                                    nil]];
    }

    if(derivedCrs != nil){

        CRSKeyword *keyword = [self readToKeyword:CRS_KEYWORD_ID];
        if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
            [baseCrs setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
        }

        [self readRightDelimiter];

        [self readSeparator];
        [derivedCrs setConversion:[self readDerivingConversion]];

    }

    [self readSeparator];
    [crs setCoordinateSystem:[self readCoordinateSystem]];

    if(derivedCrs == nil && [self isKeywordNext:CRS_KEYWORD_GEOIDMODEL]){
        [self readSeparator];
        [self readKeywordWithType:CRS_KEYWORD_GEOIDMODEL];
        [self readLeftDelimiter];
        [baseCrs setGeoidModelName:[_reader readExpectedToken]];
        CRSKeyword *keyword = [self readToKeyword:CRS_KEYWORD_ID];
        if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
            [baseCrs setGeoidModelIdentifier:[self readIdentifier]];
        }
        [self readRightDelimiter];
    }

    [self readScopeExtentIdentifierRemark:crs];

    [self readRightDelimiter];

    return crs;
}

-(CRSCoordinateReferenceSystem *) readEngineering{

    CRSEngineeringCoordinateReferenceSystem *baseCrs = [CRSEngineeringCoordinateReferenceSystem create];
    CRSSimpleCoordinateReferenceSystem *crs = baseCrs;
    CRSDerivedCoordinateReferenceSystem *derivedCrs = nil;

    [self readKeywordWithType:CRS_KEYWORD_ENGCRS];

    [self readLeftDelimiter];

    NSString *name = [_reader readExpectedToken];

    if([self isKeywordNext:CRS_KEYWORD_BASEENGCRS]){
        [self readKeywordWithType:CRS_KEYWORD_BASEENGCRS];

        derivedCrs = [CRSDerivedCoordinateReferenceSystem create];
        [derivedCrs setBase:baseCrs];
        crs = derivedCrs;

        [self readLeftDelimiter];
        [baseCrs setName:[_reader readExpectedToken]];
    }

    [crs setName:name];

    [self readSeparator];
    [baseCrs setDatum:[self readEngineeringDatumWithCRS:crs]];

    if(derivedCrs != nil){

        CRSKeyword *keyword = [self readToKeyword:CRS_KEYWORD_ID];
        if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
            [baseCrs setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
        }

        [self readRightDelimiter];

        [self readSeparator];
        [derivedCrs setConversion:[self readDerivingConversion]];

    }

    [self readSeparator];
    [crs setCoordinateSystem:[self readCoordinateSystem]];

    [self readScopeExtentIdentifierRemark:crs];

    [self readRightDelimiter];

    return crs;
}

-(CRSCoordinateReferenceSystem *) readParametric{

    CRSParametricCoordinateReferenceSystem *baseCrs = [CRSParametricCoordinateReferenceSystem create];
    CRSSimpleCoordinateReferenceSystem *crs = baseCrs;
    CRSDerivedCoordinateReferenceSystem *derivedCrs = nil;

    [self readKeywordWithType:CRS_KEYWORD_PARAMETRICCRS];

    [self readLeftDelimiter];

    NSString *name = [_reader readExpectedToken];

    if([self isKeywordNext:CRS_KEYWORD_BASEPARAMCRS]){
        [self readKeywordWithType:CRS_KEYWORD_BASEPARAMCRS];

        derivedCrs = [CRSDerivedCoordinateReferenceSystem create];
        [derivedCrs setBase:baseCrs];
        crs = derivedCrs;

        [self readLeftDelimiter];
        [baseCrs setName:[_reader readExpectedToken]];
    }

    [crs setName:name];

    [self readSeparator];
    [baseCrs setDatum:[self readParametricDatumWithCRS:crs]];

    if(derivedCrs != nil){

        CRSKeyword *keyword = [self readToKeyword:CRS_KEYWORD_ID];
        if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
            [baseCrs setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
        }

        [self readRightDelimiter];

        [self readSeparator];
        [derivedCrs setConversion:[self readDerivingConversion]];

    }

    [self readSeparator];
    [crs setCoordinateSystem:[self readCoordinateSystem]];

    [self readScopeExtentIdentifierRemark:crs];

    [self readRightDelimiter];

    return crs;
}

-(CRSCoordinateReferenceSystem *) readTemporal{

    CRSTemporalCoordinateReferenceSystem *baseCrs = [CRSTemporalCoordinateReferenceSystem create];
    CRSSimpleCoordinateReferenceSystem *crs = baseCrs;
    CRSDerivedCoordinateReferenceSystem *derivedCrs = nil;

    [self readKeywordWithType:CRS_KEYWORD_TIMECRS];

    [self readLeftDelimiter];

    NSString *name = [_reader readExpectedToken];

    if([self isKeywordNext:CRS_KEYWORD_BASETIMECRS]){
        [self readKeywordWithType:CRS_KEYWORD_BASETIMECRS];

        derivedCrs = [CRSDerivedCoordinateReferenceSystem create];
        [derivedCrs setBase:baseCrs];
        crs = derivedCrs;

        [self readLeftDelimiter];
        [baseCrs setName:[_reader readExpectedToken]];
    }

    [crs setName:name];
    
    [self readSeparator];
    [baseCrs setDatum:[self readTemporalDatum]];

    if(derivedCrs != nil){

        CRSKeyword *keyword = [self readToKeyword:CRS_KEYWORD_ID];
        if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
            [baseCrs setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
        }

        [self readRightDelimiter];

        [self readSeparator];
        [derivedCrs setConversion:[self readDerivingConversion]];

    }

    [self readSeparator];
    [crs setCoordinateSystem:[self readCoordinateSystem]];

    [self readScopeExtentIdentifierRemark:crs];

    [self readRightDelimiter];

    return crs;
}

-(CRSDerivedCoordinateReferenceSystem *) readDerivedProjected{

    CRSDerivedCoordinateReferenceSystem *crs = [CRSDerivedCoordinateReferenceSystem create];
    CRSProjectedCoordinateReferenceSystem *projectedCrs = [CRSProjectedCoordinateReferenceSystem create];
    [crs setBase:projectedCrs];

    [self readKeywordWithType:CRS_KEYWORD_DERIVEDPROJCRS];

    [self readLeftDelimiter];

    [crs setName:[_reader readExpectedToken]];

    [self readSeparator];
    [self readKeywordWithType:CRS_KEYWORD_BASEPROJCRS];

    [self readLeftDelimiter];

    [projectedCrs setName:[_reader readExpectedToken]];

    [self readSeparator];
    CRSKeyword *keyword = [self readKeywordWithTypes:[NSArray arrayWithObjects:
                                [NSNumber numberWithInt:CRS_KEYWORD_BASEGEODCRS],
                                [NSNumber numberWithInt:CRS_KEYWORD_BASEGEOGCRS],
                                nil]];
    [projectedCrs setBaseType:[CRSTextUtils coordinateReferenceSystemType:keyword.type]];

    [self readLeftDelimiter];
    [projectedCrs setBaseName:[_reader readExpectedToken]];

    BOOL isDynamic = [self isKeywordNext:CRS_KEYWORD_DYNAMIC];
    if(isDynamic){
        [self readSeparator];
        [projectedCrs setDynamic:[self readDynamic]];
    }

    if(isDynamic || [self isKeywordNext:CRS_KEYWORD_DATUM]){
        [self readSeparator];
        CRSGeoReferenceFrame *referenceFrame = [self readGeoReferenceFrameWithCRS:crs];
        [referenceFrame setType:[projectedCrs baseType]];
        [projectedCrs setReferenceFrame:referenceFrame];
    }else if([self isKeywordNext:CRS_KEYWORD_ENSEMBLE]){
        [self readSeparator];
        [projectedCrs setDatumEnsemble:[self readGeoDatumEnsemble]];
    }else{
        // Validation error
        [self readSeparator];
        [self readKeywordWithTypes:[NSArray arrayWithObjects:
                                    [NSNumber numberWithInt:CRS_KEYWORD_DATUM],
                                    [NSNumber numberWithInt:CRS_KEYWORD_ENSEMBLE],
                                    nil]];
    }

    keyword = [self readToKeyword:CRS_KEYWORD_ID];
    if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
        [projectedCrs setBaseIdentifiers:[self readIdentifiers]];
    }

    [self readRightDelimiter];

    [self readSeparator];
    [projectedCrs setMapProjection:[self readMapProjection]];

    keyword = [self readToKeyword:CRS_KEYWORD_ID];
    if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
        [projectedCrs setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
    }

    [self readRightDelimiter];

    [self readSeparator];
    [crs setConversion:[self readDerivingConversion]];

    [self readSeparator];
    [crs setCoordinateSystem:[self readCoordinateSystem]];

    [self readScopeExtentIdentifierRemark:crs];

    [self readRightDelimiter];

    return crs;
}

-(CRSCompoundCoordinateReferenceSystem *) readCompound{

    CRSCompoundCoordinateReferenceSystem *crs = [CRSCompoundCoordinateReferenceSystem create];

    [self readKeywordWithType:CRS_KEYWORD_COMPOUNDCRS];

    [self readLeftDelimiter];

    [crs setName:[_reader readExpectedToken]];

    while([self isKeywordsNext:[NSArray arrayWithObjects:
                                [NSNumber numberWithInt:CRS_KEYWORD_GEODCRS],
                                [NSNumber numberWithInt:CRS_KEYWORD_GEOGCRS],
                                [NSNumber numberWithInt:CRS_KEYWORD_GEOCCS],
                                [NSNumber numberWithInt:CRS_KEYWORD_GEOGCS],
                                [NSNumber numberWithInt:CRS_KEYWORD_PROJCRS],
                                [NSNumber numberWithInt:CRS_KEYWORD_PROJCS],
                                [NSNumber numberWithInt:CRS_KEYWORD_VERTCRS],
                                [NSNumber numberWithInt:CRS_KEYWORD_VERT_CS],
                                [NSNumber numberWithInt:CRS_KEYWORD_ENGCRS],
                                [NSNumber numberWithInt:CRS_KEYWORD_LOCAL_CS],
                                [NSNumber numberWithInt:CRS_KEYWORD_PARAMETRICCRS],
                                [NSNumber numberWithInt:CRS_KEYWORD_TIMECRS],
                                [NSNumber numberWithInt:CRS_KEYWORD_DERIVEDPROJCRS],
                                nil]]){

        [self readSeparator];
        [crs addCoordinateReferenceSystem:
                [self readSimpleCoordinateReferenceSystem]];
    }

    [self readScopeExtentIdentifierRemark:crs];

    [self readRightDelimiter];

    if([crs numCoordinateReferenceSystems] < 2){
        NSString *message = @"Compound Coordinate Reference System requires at least two Coordinate Reference Systems";
        if(_strict){
            [NSException raise:@"Compound CRS" format:@"%@", message];
        }else{
            NSLog(@"%@", message);
        }
    }

    return crs;
}

-(CRSCoordinateMetadata *) readCoordinateMetadata{

    CRSCoordinateMetadata *metadata = [CRSCoordinateMetadata create];

    [self readKeywordWithType:CRS_KEYWORD_COORDINATEMETADATA];

    [self readLeftDelimiter];

    [metadata setCoordinateReferenceSystem:[self readCoordinateReferenceSystem]];

    if([self isKeywordNext:CRS_KEYWORD_EPOCH]){

        [self readSeparator];
        [self readKeywordWithType:CRS_KEYWORD_EPOCH];
        [self readLeftDelimiter];
        [metadata setEpoch:[[NSDecimalNumber alloc] initWithDouble:[_reader readUnsignedNumber]]];
        [self readRightDelimiter];

    }

    [self readRightDelimiter];

    return metadata;
}

-(CRSCoordinateOperation *) readCoordinateOperation{

    CRSCoordinateOperation *operation = [CRSCoordinateOperation create];

    [self readKeywordWithType:CRS_KEYWORD_COORDINATEOPERATION];

    [self readLeftDelimiter];

    [operation setName:[_reader readExpectedToken]];

    if([self isKeywordNext:CRS_KEYWORD_VERSION]){
        [self readSeparator];
        [operation setVersion:[self readVersion]];
    }

    [self readSeparator];
    [operation setSource:[self readSource]];

    [self readSeparator];
    [operation setTarget:[self readTarget]];

    [self readSeparator];
    CRSOperationMethod *method = [self readMethod];
    [operation setMethod:method];

    if([self isKeywordsNext:[NSArray arrayWithObjects:
                             [NSNumber numberWithInt:CRS_KEYWORD_PARAMETER],
                             [NSNumber numberWithInt:CRS_KEYWORD_PARAMETERFILE],
                             nil]]){
        [self readSeparator];
        [method setParameters:[NSMutableArray arrayWithArray:[self readCoordinateOperationParameters]]];
    }

    if([self isKeywordNext:CRS_KEYWORD_INTERPOLATIONCRS]){
        [self readSeparator];
        [operation setInterpolation:[self readInterpolation]];
    }
    
    if([self isKeywordNext:CRS_KEYWORD_OPERATIONACCURACY]){
        [self readSeparator];
        [operation setAccuracy:[[NSDecimalNumber alloc] initWithDouble:[self readAccuracy]]];
    }

    [self readScopeExtentIdentifierRemark:operation];

    [self readRightDelimiter];

    return operation;
}

-(CRSPointMotionOperation *) readPointMotionOperation{

    CRSPointMotionOperation *operation = [CRSPointMotionOperation create];
    
    [self readKeywordWithType:CRS_KEYWORD_POINTMOTIONOPERATION];

    [self readLeftDelimiter];
    
    [operation setName:[_reader readExpectedToken]];

    if([self isKeywordNext:CRS_KEYWORD_VERSION]){
        [self readSeparator];
        [operation setVersion:[self readVersion]];
    }

    [self readSeparator];
    [operation setSource:[self readSource]];

    [self readSeparator];
    CRSOperationMethod *method = [self readMethod];
    [operation setMethod:method];

    if([self isKeywordsNext:[NSArray arrayWithObjects:
                             [NSNumber numberWithInt:CRS_KEYWORD_PARAMETER],
                             [NSNumber numberWithInt:CRS_KEYWORD_PARAMETERFILE],
                             nil]]){
        [self readSeparator];
        [method setParameters:[NSMutableArray arrayWithArray:[self readPointMotionOperationParameters]]];
    }
    
    if([self isKeywordNext:CRS_KEYWORD_OPERATIONACCURACY]){
        [self readSeparator];
        [operation setAccuracy:[[NSDecimalNumber alloc] initWithDouble:[self readAccuracy]]];
    }

    [self readScopeExtentIdentifierRemark:operation];

    [self readRightDelimiter];

    return operation;
}

-(CRSConcatenatedOperation *) readConcatenatedOperation{

    CRSConcatenatedOperation *operation = [CRSConcatenatedOperation create];
    
    [self readKeywordWithType:CRS_KEYWORD_CONCATENATEDOPERATION];

    [self readLeftDelimiter];

    [operation setName:[_reader readExpectedToken]];

    if([self isKeywordNext:CRS_KEYWORD_VERSION]){
        [self readSeparator];
        [operation setVersion:[self readVersion]];
    }

    [self readSeparator];
    [operation setSource:[self readSource]];

    [self readSeparator];
    [operation setTarget:[self readTarget]];

    do{

        [self readSeparator];
        [self readKeywordWithType:CRS_KEYWORD_STEP];

        [self readLeftDelimiter];

        CRSKeyword *keyword = [self readToKeywords:[NSArray arrayWithObjects:
                                                    [NSNumber numberWithInt:CRS_KEYWORD_COORDINATEOPERATION],
                                                    [NSNumber numberWithInt:CRS_KEYWORD_POINTMOTIONOPERATION],
                                                    [NSNumber numberWithInt:CRS_KEYWORD_CONVERSION],
                                                    [NSNumber numberWithInt:CRS_KEYWORD_DERIVINGCONVERSION],
                                                    nil]];

        NSObject<CRSCommonOperation> *concatenable = nil;

        switch(keyword.type){
            case CRS_KEYWORD_COORDINATEOPERATION:
                concatenable = [self readCoordinateOperation];
                break;
            case CRS_KEYWORD_POINTMOTIONOPERATION:
                concatenable = [self readPointMotionOperation];
                break;
            case CRS_KEYWORD_CONVERSION:
                concatenable = [self readMapProjection];
                break;
            case CRS_KEYWORD_DERIVINGCONVERSION:
                concatenable = [self readDerivingConversion];
                break;
            default:
                [NSException raise:@"Unsupported Operation" format:@"Unsupported concatenable operation type: %@", keyword.name];
        }

        [operation addOperation:concatenable];

        [self readRightDelimiter];

    }while([self isKeywordNext:CRS_KEYWORD_STEP]);

    if([self isKeywordNext:CRS_KEYWORD_OPERATIONACCURACY]){
        [self readSeparator];
        [operation setAccuracy:[[NSDecimalNumber alloc] initWithDouble:[self readAccuracy]]];
    }

    [self readScopeExtentIdentifierRemark:operation];

    [self readRightDelimiter];

    return operation;
}

-(CRSBoundCoordinateReferenceSystem *) readBound{

    CRSBoundCoordinateReferenceSystem *crs = [CRSBoundCoordinateReferenceSystem create];

    [self readKeywordWithType:CRS_KEYWORD_BOUNDCRS];

    [self readLeftDelimiter];

    [crs setSource:[self readSource]];

    [self readSeparator];
    [crs setTarget:[self readTarget]];

    [self readSeparator];
    [crs setTransformation:[self readAbridgedCoordinateTransformation]];

    [self readScopeExtentIdentifierRemark:crs];

    [self readRightDelimiter];

    return crs;
}

-(void) readScopeExtentIdentifierRemark: (NSObject<CRSScopeExtentIdentifierRemark> *) object{

    CRSKeyword *keyword = [self readToKeywords:[NSArray arrayWithObjects:
                                                [NSNumber numberWithInt:CRS_KEYWORD_USAGE],
                                                [NSNumber numberWithInt:CRS_KEYWORD_ID],
                                                [NSNumber numberWithInt:CRS_KEYWORD_REMARK],
                                                nil]];

    if(keyword != nil && keyword.type == CRS_KEYWORD_USAGE){
        [object setUsages:[self readUsages]];
        keyword = [self readToKeywords:[NSArray arrayWithObjects:
                                                    [NSNumber numberWithInt:CRS_KEYWORD_ID],
                                                    [NSNumber numberWithInt:CRS_KEYWORD_REMARK],
                                                    nil]];
    }

    if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
        [object setIdentifiers:[self readIdentifiers]];
        keyword = [self readToKeyword:CRS_KEYWORD_REMARK];
    }

    if(keyword != nil && keyword.type == CRS_KEYWORD_REMARK){
        [object setRemark:[self readRemark]];
    }

}

-(CRSGeoReferenceFrame *) readGeoReferenceFrame{
    return [self readGeoReferenceFrameWithCRS:nil];
}

-(CRSGeoReferenceFrame *) readGeoReferenceFrameWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    CRSReferenceFrame *referenceFrame = [self readReferenceFrameWithCRS:crs];
    if(![referenceFrame isKindOfClass:[CRSGeoReferenceFrame class]]){
        [NSException raise:@"Reference Frame" format:@"Reference frame was not an expected Geo Reference Frame"];
    }
    return (CRSGeoReferenceFrame *) referenceFrame;
}

-(CRSVerticalReferenceFrame *) readVerticalReferenceFrame{
    return [self readVerticalReferenceFrameWithCRS:nil];
}

-(CRSVerticalReferenceFrame *) readVerticalReferenceFrameWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    CRSReferenceFrame *referenceFrame = [self readReferenceFrameWithCRS:crs];
    if(![referenceFrame isKindOfClass:[CRSVerticalReferenceFrame class]]){
        [NSException raise:@"Reference Frame" format:@"Reference frame was not an expected Vertical Reference Frame"];
    }
    return (CRSVerticalReferenceFrame *) referenceFrame;
}

-(CRSEngineeringDatum *) readEngineeringDatum{
    return [self readEngineeringDatumWithCRS:nil];
}

-(CRSEngineeringDatum *) readEngineeringDatumWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    CRSReferenceFrame *referenceFrame = [self readReferenceFrameWithCRS:crs];
    if(![referenceFrame isKindOfClass:[CRSEngineeringDatum class]]){
        [NSException raise:@"Reference Frame" format:@"Reference frame was not an expected Engineering Datum"];
    }
    return (CRSEngineeringDatum *) referenceFrame;
}

-(CRSParametricDatum *) readParametricDatum{
    return [self readParametricDatumWithCRS:nil];
}

-(CRSParametricDatum *) readParametricDatumWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    CRSReferenceFrame *referenceFrame = [self readReferenceFrameWithCRS:crs];
    if(![referenceFrame isKindOfClass:[CRSParametricDatum class]]){
        [NSException raise:@"Reference Frame" format:@"Reference frame was not an expected Parametric Datum"];
    }
    return (CRSParametricDatum *) referenceFrame;
}

-(CRSReferenceFrame *) readReferenceFrame{
    return [self readReferenceFrameWithCRS:nil];
}

-(CRSReferenceFrame *) readReferenceFrameWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{

    CRSReferenceFrame *referenceFrame = nil;
    CRSGeoReferenceFrame *geoReferenceFrame = nil;

    CRSKeyword *type = [self readKeywordWithTypes:[NSArray arrayWithObjects:
                                                   [NSNumber numberWithInt:CRS_KEYWORD_DATUM],
                                                   [NSNumber numberWithInt:CRS_KEYWORD_VDATUM],
                                                   [NSNumber numberWithInt:CRS_KEYWORD_EDATUM],
                                                   [NSNumber numberWithInt:CRS_KEYWORD_PDATUM],
                                                   nil]];
    switch(type.type){
        case CRS_KEYWORD_DATUM:
            geoReferenceFrame = [CRSGeoReferenceFrame create];
            referenceFrame = geoReferenceFrame;
            break;
        case CRS_KEYWORD_VDATUM:
            referenceFrame = [CRSVerticalReferenceFrame create];
            break;
        case CRS_KEYWORD_EDATUM:
            referenceFrame = [CRSEngineeringDatum create];
            break;
        case CRS_KEYWORD_PDATUM:
            referenceFrame = [CRSParametricDatum create];
            break;
        default:
            [NSException raise:@"Unexpected Type" format:@"Unexpected Reference Frame type: %@", type.name];
    }

    [self readLeftDelimiter];

    [referenceFrame setName:[_reader readExpectedToken]];

    if(geoReferenceFrame != nil){
        [self readSeparator];
        [geoReferenceFrame setEllipsoid:[self readEllipsoid]];
    }

    CRSKeyword *keyword = [self readToKeywords:[NSArray arrayWithObjects:
                                                [NSNumber numberWithInt:CRS_KEYWORD_TOWGS84],
                                                [NSNumber numberWithInt:CRS_KEYWORD_ANCHOR],
                                                [NSNumber numberWithInt:CRS_KEYWORD_ID],
                                                nil]];

    if(keyword != nil && keyword.type == CRS_KEYWORD_TOWGS84){
        NSArray<NSDecimalNumber *> *toWGS84 = [self readToWGS84Compat];
        if(crs != nil){
            [crs addExtra:toWGS84 withName:[CRSKeyword keywordOfType:CRS_KEYWORD_TOWGS84].name];
        }
        keyword = [self readToKeywords:[NSArray arrayWithObjects:
                                                    [NSNumber numberWithInt:CRS_KEYWORD_ANCHOR],
                                                    [NSNumber numberWithInt:CRS_KEYWORD_ID],
                                                    nil]];
    }

    if(keyword != nil && keyword.type == CRS_KEYWORD_ANCHOR){
        [referenceFrame setAnchor:[self readKeywordDelimitedToken:CRS_KEYWORD_ANCHOR]];
        keyword = [self readToKeywords:[NSArray arrayWithObjects:
                                                    [NSNumber numberWithInt:CRS_KEYWORD_ID],
                                                    [NSNumber numberWithInt:CRS_KEYWORD_TOWGS84],
                                                    nil]];
    }

    if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
        [referenceFrame setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
        keyword = [self readToKeyword:CRS_KEYWORD_TOWGS84];
    }

    if(keyword != nil && keyword.type == CRS_KEYWORD_TOWGS84){
        NSArray<NSDecimalNumber *> *toWGS84 = [self readToWGS84Compat];
        if(crs != nil){
            [crs addExtra:toWGS84 withName:[CRSKeyword keywordOfType:CRS_KEYWORD_TOWGS84].name];
        }
    }

    [self readRightDelimiter];

    if(geoReferenceFrame != nil && [self isKeywordNext:CRS_KEYWORD_PRIMEM]){
        [self readSeparator];
        [geoReferenceFrame setPrimeMeridian:[self readPrimeMeridian]];
    }

    return referenceFrame;
}

-(CRSGeoDatumEnsemble *) readGeoDatumEnsemble{
    CRSDatumEnsemble *datumEnsemble = [self readDatumEnsemble];
    if(![datumEnsemble isKindOfClass:[CRSGeoDatumEnsemble class]]){
        [NSException raise:@"Datum Ensemble" format:@"Datum ensemble was not an expected Geo Datum Ensemble"];
    }
    return (CRSGeoDatumEnsemble *) datumEnsemble;
}

-(CRSVerticalDatumEnsemble *) readVerticalDatumEnsemble{
    CRSDatumEnsemble *datumEnsemble = [self readDatumEnsemble];
    if(![datumEnsemble isKindOfClass:[CRSVerticalDatumEnsemble class]]){
        [NSException raise:@"Datum Ensemble" format:@"Datum ensemble was not an expected Vertical Datum Ensemble"];
    }
    return (CRSVerticalDatumEnsemble *) datumEnsemble;
}

-(CRSDatumEnsemble *) readDatumEnsemble{

    [self readKeywordWithType:CRS_KEYWORD_ENSEMBLE];

    [self readLeftDelimiter];

    NSString *name = [_reader readExpectedToken];

    NSMutableArray<CRSDatumEnsembleMember *> *members = [NSMutableArray array];
    do{

        [self readSeparator];
        [members addObject:[self readDatumEnsembleMember]];

    }while([self isKeywordNext:CRS_KEYWORD_MEMBER]);

    CRSDatumEnsemble *datumEnsemble = nil;
    CRSGeoDatumEnsemble *geoDatumEnsemble = nil;

    if([self isKeywordNext:CRS_KEYWORD_ELLIPSOID]){
        geoDatumEnsemble = [CRSGeoDatumEnsemble create];
        datumEnsemble = geoDatumEnsemble;
    }else{
        datumEnsemble = [CRSVerticalDatumEnsemble create];
    }

    [datumEnsemble setName:name];
    [datumEnsemble setMembers:members];

    if(geoDatumEnsemble != nil){
        [self readSeparator];
        [geoDatumEnsemble setEllipsoid:[self readEllipsoid]];
    }

    [self readSeparator];
    [self readKeywordWithType:CRS_KEYWORD_ENSEMBLEACCURACY];

    [self readLeftDelimiter];

    [datumEnsemble setAccuracy:[_reader readNumber]];

    [self readRightDelimiter];

    CRSKeyword *keyword = [self readToKeyword:CRS_KEYWORD_ID];
    if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
        [datumEnsemble setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
    }

    [self readRightDelimiter];

    if(geoDatumEnsemble != nil && [self isKeywordNext:CRS_KEYWORD_PRIMEM]){
        [self readSeparator];
        [geoDatumEnsemble setPrimeMeridian:[self readPrimeMeridian]];
    }

    return datumEnsemble;
}

-(CRSDatumEnsembleMember *) readDatumEnsembleMember{

    CRSDatumEnsembleMember *member = [CRSDatumEnsembleMember create];

    [self readKeywordWithType:CRS_KEYWORD_MEMBER];

    [self readLeftDelimiter];

    [member setName:[_reader readExpectedToken]];

    CRSKeyword *keyword = [self readToKeyword:CRS_KEYWORD_ID];
    if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
        [member setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
    }

    [self readRightDelimiter];

    return member;
}

-(CRSDynamic *) readDynamic{

    CRSDynamic *dynamic = [CRSDynamic create];

    [self readKeywordWithType:CRS_KEYWORD_DYNAMIC];

    [self readLeftDelimiter];

    [self readKeywordWithType:CRS_KEYWORD_FRAMEEPOCH];

    [self readLeftDelimiter];

    [dynamic setReferenceEpoch:[_reader readUnsignedNumber]];

    [self readRightDelimiter];

    CRSKeyword *keyword = [self readToKeyword:CRS_KEYWORD_MODEL];
    if(keyword != nil && keyword.type == CRS_KEYWORD_MODEL){

        [self readKeywordWithType:CRS_KEYWORD_MODEL];

        [self readLeftDelimiter];

        [dynamic setDeformationModelName:[_reader readExpectedToken]];

        keyword = [self readToKeyword:CRS_KEYWORD_ID];
        if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
            [dynamic setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
        }

        [self readRightDelimiter];
    }

    [self readRightDelimiter];

    return dynamic;
}

-(CRSPrimeMeridian *) readPrimeMeridian{

    CRSPrimeMeridian *primeMeridian = [CRSPrimeMeridian create];
    
    [self readKeywordWithType:CRS_KEYWORD_PRIMEM];

    [self readLeftDelimiter];

    [primeMeridian setName:[_reader readExpectedToken]];

    [self readSeparator];
    [primeMeridian setLongitude:[_reader readNumber]];

    CRSKeyword *keyword = [self readToKeywords:[NSArray arrayWithObjects:
                                                [NSNumber numberWithInt:CRS_KEYWORD_ANGLEUNIT],
                                                [NSNumber numberWithInt:CRS_KEYWORD_ID],
                                                nil]];

    if(keyword != nil && keyword.type == CRS_KEYWORD_ANGLEUNIT){
        [primeMeridian setLongitudeUnit:[self readAngleUnit]];
        keyword = [self readToKeyword:CRS_KEYWORD_ID];
    }

    if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
        [primeMeridian setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
    }

    [self readRightDelimiter];

    return primeMeridian;
}

-(CRSEllipsoid *) readEllipsoid{

    CRSEllipsoid *ellipsoid = nil;
    CRSTriaxialEllipsoid *triaxial = nil;

    CRSKeyword *keyword = [self readKeywordWithTypes:[NSArray arrayWithObjects:
                                                      [NSNumber numberWithInt:CRS_KEYWORD_ELLIPSOID],
                                                      [NSNumber numberWithInt:CRS_KEYWORD_TRIAXIAL],
                                                      nil]];

    if(keyword != nil && keyword.type == CRS_KEYWORD_TRIAXIAL){
        triaxial = [CRSTriaxialEllipsoid create];
        ellipsoid = triaxial;
    }else{
        ellipsoid = [CRSEllipsoid create];
    }

    [self readLeftDelimiter];

    [ellipsoid setName:[_reader readExpectedToken]];

    [self readSeparator];
    [ellipsoid setSemiMajorAxis:[_reader readUnsignedNumber]];

    if(triaxial != nil){

        [self readSeparator];
        [triaxial setSemiMedianAxis:[_reader readUnsignedNumber]];

        [self readSeparator];
        [triaxial setSemiMinorAxis:[_reader readUnsignedNumber]];

    } else {

        [self readSeparator];
        [ellipsoid setInverseFlattening:[_reader readUnsignedNumber]];

    }

    keyword = [self readToKeywords:[NSArray arrayWithObjects:
                                                [NSNumber numberWithInt:CRS_KEYWORD_LENGTHUNIT],
                                                [NSNumber numberWithInt:CRS_KEYWORD_ID],
                                                nil]];

    if(keyword != nil && keyword.type == CRS_KEYWORD_LENGTHUNIT){
        [ellipsoid setUnit:[self readLengthUnit]];
        keyword = [self readToKeyword:CRS_KEYWORD_ID];
    }

    if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
        [ellipsoid setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
    }

    [self readRightDelimiter];

    return ellipsoid;
}

-(CRSUnit *) readUnit{
    return [self readUnitWithType:CRS_UNIT];
}

-(CRSUnit *) readAngleUnit{
    return [self readUnitWithType:CRS_UNIT_ANGLE];
}

-(CRSUnit *) readLengthUnit{
    return [self readUnitWithType:CRS_UNIT_LENGTH];
}

-(CRSUnit *) readParametricUnit{
    return [self readUnitWithType:CRS_UNIT_PARAMETRIC];
}

-(CRSUnit *) readScaleUnit{
    return [self readUnitWithType:CRS_UNIT_SCALE];
}

-(CRSUnit *) readTimeUnit{
    return [self readUnitWithType:CRS_UNIT_TIME];
}

-(CRSUnit *) readUnitWithType: (enum CRSUnitType) type{
    
    CRSUnit *unit = [CRSUnit create];
    
    NSArray<NSNumber *> *keywords = [self readKeywordTypes];
    if(type != CRS_UNIT){
        enum CRSKeywordType crsType = [CRSKeyword type:[CRSUnitTypes name:type]];
        [self validateKeywords:keywords withExpectedType:crsType];
    }else if(keywords.count == 1){
        type = [CRSTextUtils unitType:[[keywords firstObject] intValue]];
    }else if(keywords.count == 0){
        [NSException raise:@"Unexpected Keyword" format:@"Unexpected unit keyword. found: %@", [self keywordNames:keywords]];
    }
    [unit setType:type];

    [self readLeftDelimiter];

    [unit setName:[_reader readExpectedToken]];

    if(type != CRS_UNIT_TIME || [self isNonKeywordNext]){
        [self readSeparator];
        [unit setConversionFactor:[[NSDecimalNumber alloc] initWithDouble:[_reader readUnsignedNumber]]];
    }

    CRSKeyword *keyword = [self readToKeyword:CRS_KEYWORD_ID];
    if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
        [unit setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
    }
    
    [self readRightDelimiter];

    return unit;
}

-(NSArray<CRSIdentifier *> *) readIdentifiers{
    
    NSMutableArray<CRSIdentifier *> *identifiers = [NSMutableArray array];

    do{

        if(identifiers.count > 0){
            [self readSeparator];
        }

        [identifiers addObject:[self readIdentifier]];

    }while([self isKeywordNext:CRS_KEYWORD_ID]);

    return identifiers;
}

-(CRSIdentifier *) readIdentifier{

    CRSIdentifier *identifier = [CRSIdentifier create];

    [self readKeywordWithType:CRS_KEYWORD_ID];

    [self readLeftDelimiter];

    [identifier setName:[_reader readExpectedToken]];

    [self readSeparator];
    [identifier setUniqueIdentifier:[_reader readExpectedToken]];

    if([self isNonKeywordNext]){
        [self readSeparator];
        [identifier setVersion:[_reader readExpectedToken]];
    }

    CRSKeyword *keyword = [self readToKeywords:[NSArray arrayWithObjects:
                                                [NSNumber numberWithInt:CRS_KEYWORD_CITATION],
                                                [NSNumber numberWithInt:CRS_KEYWORD_URI],
                                                nil]];

    if(keyword != nil && keyword.type == CRS_KEYWORD_CITATION){
        [identifier setCitation:[self readKeywordDelimitedToken:CRS_KEYWORD_CITATION]];
        keyword = [self readToKeyword:CRS_KEYWORD_URI];
    }

    if(keyword != nil && keyword.type == CRS_KEYWORD_URI){
        [identifier setUri:[self readKeywordDelimitedToken:CRS_KEYWORD_URI]];
    }

    [self readRightDelimiter];

    return identifier;
}

-(CRSCoordinateSystem *) readCoordinateSystem{

    CRSCoordinateSystem *coordinateSystem = [CRSCoordinateSystem create];

    [self readKeywordWithType:CRS_KEYWORD_CS];

    [self readLeftDelimiter];

    NSString *csTypeName = [_reader readToken];
    enum CRSCoordinateSystemType csType = [CRSCoordinateSystemTypes type:csTypeName];
    if ((int)csType == -1) {
        [NSException raise:@"Unexpected Type" format:@"Unexpected coordinate system type. found: %@", csTypeName];
    }
    [coordinateSystem setType:csType];

    [self readSeparator];
    [coordinateSystem setDimension:[_reader readUnsignedInteger]];

    CRSKeyword *keyword = [self readToKeyword:CRS_KEYWORD_ID];
    if(keyword != nil && keyword.type == CRS_KEYWORD_ID){
        [coordinateSystem setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
    }

    [self readRightDelimiter];

    [self readSeparator];
    [coordinateSystem setAxes:[NSMutableArray arrayWithArray:[self readAxesWithType:csType]]];

    if([CRSTextUtils isSpatial:csType]){

        if([self isUnitNext]){

            [self readSeparator];
            [coordinateSystem setUnit:[self readUnit]];

        }

    }

    return coordinateSystem;
}

-(NSArray<CRSAxis *> *) readAxes{
    return [self readAxesWithType:-1];
}

-(NSArray<CRSAxis *> *) readAxesWithType: (enum CRSCoordinateSystemType) type{

    BOOL isTemporalCountMeasure = type != -1 && [CRSTextUtils isTemporalCountMeasure:type];

    NSMutableArray<CRSAxis *> *axes = [NSMutableArray array];

    do{

        if(axes.count > 0){
            [self readSeparator];
        }

        [axes addObject:[self readAxisWithType:type]];

        if(isTemporalCountMeasure){
            break;
        }

    }while([self isKeywordNext:CRS_KEYWORD_AXIS]);

    return axes;
}

-(CRSAxis *) readAxis{
    return [self readAxisWithType:-1];
}

-(CRSAxis *) readAxisWithType: (enum CRSCoordinateSystemType) type{
    return nil; // TODO
}

-(NSString *) readRemark{
    return nil; // TODO
}

-(NSArray<CRSUsage *> *) readUsages{
    return nil; // TODO
}

-(CRSUsage *) readUsage{
    return nil; // TODO
}

-(NSString *) readScope{
    return nil; // TODO
}

-(CRSExtent *) readExtent{
    return nil; // TODO
}

-(NSString *) readAreaDescription{
    return nil; // TODO
}

-(CRSGeographicBoundingBox *) readGeographicBoundingBox{
    return nil; // TODO
}

-(CRSVerticalExtent *) readVerticalExtent{
    return nil; // TODO
}

-(CRSTemporalExtent *) readTemporalExtent{
    return nil; // TODO
}

-(CRSMapProjection *) readMapProjection{
    return nil; // TODO
}

-(CRSOperationMethod *) readMethod{
    return nil; // TODO
}

-(NSArray<CRSOperationParameter *> *) readProjectedParameters{
    return nil; // TODO
}

-(NSArray<CRSOperationParameter *> *) readParametersWithType: (enum CRSType) type{
    return nil; // TODO
}

-(CRSOperationParameter *) readParameterWithType: (enum CRSType) type{
    return nil; // TODO
}

-(CRSTemporalDatum *) readTemporalDatum{
    return nil; // TODO
}

-(CRSDerivingConversion *) readDerivingConversion{
    return nil; // TODO
}

-(NSArray<CRSOperationParameter *> *) readDerivedParameters{
    return nil; // TODO
}

-(NSArray<CRSOperationParameter *> *) readParametersAndFilesWithType: (enum CRSType) type{
    return nil; // TODO
}

-(CRSOperationParameter *) readParameterFile{
    return nil; // TODO
}

-(NSArray<CRSOperationParameter *> *) readCoordinateOperationParameters{
    return nil; // TODO
}

-(NSString *) readVersion{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readSource{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readTarget{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readInterpolation{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readCoordinateReferenceSystemWithKeyword: (enum CRSKeywordType) keyword{
    return nil; // TODO
}

-(double) readAccuracy{
    return -1; // TODO
}

-(NSArray<CRSOperationParameter *> *) readPointMotionOperationParameters{
    return nil; // TODO
}

-(CRSAbridgedCoordinateTransformation *) readAbridgedCoordinateTransformation{
    return nil; // TODO
}

-(NSArray<CRSOperationParameter *> *) readBoundParameters{
    return nil; // TODO
}

-(CRSGeoCoordinateReferenceSystem *) readGeoCompat{
    return nil; // TODO
}

-(CRSGeoCoordinateReferenceSystem *) readGeodeticCompat{
    return nil; // TODO
}

-(CRSGeoCoordinateReferenceSystem *) readGeographicCompat{
    return nil; // TODO
}

-(CRSGeoCoordinateReferenceSystem *) readGeoCompatWithType: (enum CRSType) expectedType{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedCompat{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedGeodeticCompat{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedGeographicCompat{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedCompatWithType: (enum CRSType) expectedType{
    return nil; // TODO
}

+(void) addTransformParameters: (NSArray<NSDecimalNumber *> *) transform toMapProjection: (CRSMapProjection *) mapProjection{
    // TODO
}

-(CRSVerticalCoordinateReferenceSystem *) readVerticalCompat{
    return nil; // TODO
}

-(CRSEngineeringCoordinateReferenceSystem *) readEngineeringCompat{
    return nil; // TODO
}

-(CRSMapProjection *) readMapProjectionCompat{
    return nil; // TODO
}

-(CRSCoordinateSystem *) readCoordinateSystemCompatWithType: (enum CRSType) type andReferenceFrame: (CRSReferenceFrame *) datum{
    return nil; // TODO
}

-(CRSVerticalReferenceFrame *) readVerticalDatumCompat{
    return nil; // TODO
}

-(CRSVerticalReferenceFrame *) readVerticalDatumCompatWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSEngineeringDatum *) readEngineeringDatumCompat{
    return nil; // TODO
}

-(CRSEngineeringDatum *) readEngineeringDatumCompatWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSReferenceFrame *) readDatumCompat{
    return nil; // TODO
}

-(CRSReferenceFrame *) readDatumCompatWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(NSArray<NSDecimalNumber *> *) readToWGS84Compat{
    return nil; // TODO
}

-(NSDictionary<NSString *, NSObject *> *) readExtensionsCompat{
    return nil; // TODO
}

@end
