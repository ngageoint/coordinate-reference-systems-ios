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
    if(keyword == -1){
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
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjected{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedGeodetic{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedGeographic{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedWithType: (enum CRSType) expectedBaseType{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readVertical{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readEngineering{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readParametric{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readTemporal{
    return nil; // TODO
}

-(CRSDerivedCoordinateReferenceSystem *) readDerivedProjected{
    return nil; // TODO
}

-(CRSCompoundCoordinateReferenceSystem *) readCompound{
    return nil; // TODO
}

-(CRSCoordinateMetadata *) readCoordinateMetadata{
    return nil; // TODO
}

-(CRSCoordinateOperation *) readCoordinateOperation{
    return nil; // TODO
}

-(CRSPointMotionOperation *) readPointMotionOperation{
    return nil; // TODO
}

-(CRSConcatenatedOperation *) readConcatenatedOperation{
    return nil; // TODO
}

-(CRSBoundCoordinateReferenceSystem *) readBound{
    return nil; // TODO
}

-(void) readScopeExtentIdentifierRemark: (NSObject<CRSScopeExtentIdentifierRemark> *) object{
    // TODO
}

-(CRSGeoReferenceFrame *) readGeoReferenceFrame{
    return nil; // TODO
}

-(CRSGeoReferenceFrame *) readGeoReferenceFrameWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSVerticalReferenceFrame *) readVerticalReferenceFrame{
    return nil; // TODO
}

-(CRSVerticalReferenceFrame *) readVerticalReferenceFrameWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSEngineeringDatum *) readEngineeringDatum{
    return nil; // TODO
}

-(CRSEngineeringDatum *) readEngineeringDatumWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSParametricDatum *) readParametricDatum{
    return nil; // TODO
}

-(CRSParametricDatum *) readParametricDatumWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSReferenceFrame *) readReferenceFrame{
    return nil; // TODO
}

-(CRSReferenceFrame *) readReferenceFrameWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSGeoDatumEnsemble *) readGeoDatumEnsemble{
    return nil; // TODO
}

-(CRSVerticalDatumEnsemble *) readVerticalDatumEnsemble{
    return nil; // TODO
}

-(CRSDatumEnsemble *) readDatumEnsemble{
    return nil; // TODO
}

-(CRSDatumEnsembleMember *) readDatumEnsembleMember{
    return nil; // TODO
}

-(CRSDynamic *) readDynamic{
    return nil; // TODO
}

-(CRSPrimeMeridian *) readPrimeMeridian{
    return nil; // TODO
}

-(CRSEllipsoid *) readEllipsoid{
    return nil; // TODO
}

-(CRSUnit *) readUnit{
    return nil; // TODO
}

-(CRSUnit *) readAngleUnit{
    return nil; // TODO
}

-(CRSUnit *) readLengthUnit{
    return nil; // TODO
}

-(CRSUnit *) readParametricUnit{
    return nil; // TODO
}

-(CRSUnit *) readScaleUnit{
    return nil; // TODO
}

-(CRSUnit *) readTimeUnit{
    return nil; // TODO
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
    if(keyword.type == CRS_KEYWORD_ID){
        [unit setIdentifiers:[NSMutableArray arrayWithArray:[self readIdentifiers]]];
    }
    
    [self readRightDelimiter];

    return unit;
}

-(NSArray<CRSIdentifier *> *) readIdentifiers{
    return nil; // TODO
}

-(CRSIdentifier *) readIdentifier{
    return nil; // TODO
}

-(CRSCoordinateSystem *) readCoordinateSystem{
    return nil; // TODO
}

-(NSArray<CRSAxis *> *) readAxes{
    return nil; // TODO
}

-(NSArray<CRSAxis *> *) readAxesWithType: (enum CRSCoordinateSystemType) type{
    return nil; // TODO
}

-(CRSAxis *) readAxis{
    return nil; // TODO
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
