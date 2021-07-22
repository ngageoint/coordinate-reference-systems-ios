//
//  CRSTextUtils.m
//  crs-ios
//
//  Created by Brian Osborn on 7/22/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSTextUtils.h"
#import "CRSTextConstants.h"
#import "CRSTextReader.h"

@implementation CRSTextUtils

+(BOOL) isLeftDelimiter: (NSString *) text{
    return [text isEqualToString:CRS_WKT_LEFT_DELIMITER] || [text isEqualToString:CRS_WKT_LEFT_DELIMITER_COMPAT];
}

+(BOOL) isRightDelimiter: (NSString *) text{
    return [text isEqualToString:CRS_WKT_RIGHT_DELIMITER] || [text isEqualToString:CRS_WKT_RIGHT_DELIMITER_COMPAT];
}

+(BOOL) isSpatial: (enum CRSCoordinateSystemType) type{
    BOOL value = NO;
    switch (type) {
    case CRS_CS_AFFINE:
    case CRS_CS_CARTESIAN:
    case CRS_CS_CYLINDRICAL:
    case CRS_CS_ELLIPSOIDAL:
    case CRS_CS_LINEAR:
    case CRS_CS_PARAMETRIC:
    case CRS_CS_POLAR:
    case CRS_CS_SPHERICAL:
    case CRS_CS_VERTICAL:
        value = YES;
        break;
    default:
            break;
    }
    return value;
}

+(BOOL) isTemporalCountMeasure: (enum CRSCoordinateSystemType) type{
    BOOL value = NO;
    switch (type) {
    case CRS_CS_TEMPORAL_COUNT:
    case CRS_CS_TEMPORAL_MEASURE:
        value = YES;
        break;
    default:
            break;
    }
    return value;
}

+(BOOL) isOrdinalDateTime: (enum CRSCoordinateSystemType) type{
    BOOL value = NO;
    switch (type) {
    case CRS_CS_ORDINAL:
    case CRS_CS_TEMPORAL_DATE_TIME:
        value = YES;
        break;
    default:
            break;
    }
    return value;
}

+(enum CRSUnitType) unitTypeOfKeyword: (CRSKeyword *) keyword{
    
    enum CRSUnitType unitType = [CRSUnitTypes type:keyword.name];
    if((int)unitType < 0){
        [NSException raise:@"No Unit Type" format:@"No unit type found. keyword: %@", keyword.name];
    }
    
    return unitType;
}

+(enum CRSUnitType) unitType: (enum CRSKeywordType) keyword{
    return [self unitTypeOfKeyword:[CRSKeyword keywordOfType:keyword]];
}

+(enum CRSType) coordinateReferenceSystemType: (enum CRSKeywordType) keyword{
    
    enum CRSType crsType = -1;

    switch (keyword) {

    case CRS_KEYWORD_GEODCRS:
    case CRS_KEYWORD_BASEGEODCRS:
    case CRS_KEYWORD_GEOCCS:
        crsType = CRS_TYPE_GEODETIC;
        break;

    case CRS_KEYWORD_GEOGCRS:
    case CRS_KEYWORD_BASEGEOGCRS:
    case CRS_KEYWORD_GEOGCS:
        crsType = CRS_TYPE_GEOGRAPHIC;
        break;

    default:
        [NSException raise:@"No CRS Type" format:@"No coordinate reference system type found. keyword: %d", keyword];
    }

    return crsType;
}

+(NSString *) pretty: (NSString *) wkt{
    return [self pretty:wkt withIndent:@"    "];
}

+(NSString *) prettyTabIndent: (NSString *) wkt{
    return [self pretty:wkt withIndent:@"\t"];
}

+(NSString *) prettyNoIndent: (NSString *) wkt{
    return [self pretty:wkt withIndent:@""];
}

+(NSString *) pretty: (NSString *) wkt withIndent: (NSString *) indent{
    return [self pretty:wkt withNewline:@"\n" andIndent:indent];
}

+(NSString *) pretty: (NSString *) wkt withNewline: (NSString *) newline andIndent: (NSString *) indent{
    
    NSMutableString *pretty = [NSMutableString string];
    
    int depth = 0;
    
    // TODO
    /*
    
    CRSTextReader *reader = [[CRSTextReader alloc] initWithText:wkt andIncludeQuotes:YES];
    
    NSString *previousToken [reader readToken];
    NSString *token [reader readToken];
    while(previousToken != nil){
        
        if(token != nil && ([token isEqualToString:@"["] || [token isEqualToString:@"("])){
            depth++;
            if(pretty.length > 0){
                [pretty appendString:newline];
            }
            for(int i = 1; i < depth; i++){
                [pretty appendString:indent];
            }
        }
        
        [pretty appendString:previousToken];
        
        if([previousToken isEqualToString:@"]"] || [previousToken isEqualToString:@")"]){
            depth--;
        }
        
        previousToken = token;
        token = [reader readToken];
    }

    [reader close];
     
     */

    return pretty;
}

@end
