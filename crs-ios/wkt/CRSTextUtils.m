//
//  CRSTextUtils.m
//  crs-ios
//
//  Created by Brian Osborn on 7/22/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSTextUtils.h>
#import <CoordinateReferenceSystems/CRSTextConstants.h>
#import <CoordinateReferenceSystems/CRSTextReader.h>

@implementation CRSTextUtils

+(BOOL) isLeftDelimiter: (NSString *) text{
    return [text isEqualToString:CRS_WKT_LEFT_DELIMITER] || [text isEqualToString:CRS_WKT_LEFT_DELIMITER_COMPAT];
}

+(BOOL) isRightDelimiter: (NSString *) text{
    return [text isEqualToString:CRS_WKT_RIGHT_DELIMITER] || [text isEqualToString:CRS_WKT_RIGHT_DELIMITER_COMPAT];
}

+(BOOL) isSpatial: (CRSCoordinateSystemType) type{
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

+(BOOL) isTemporalCountMeasure: (CRSCoordinateSystemType) type{
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

+(BOOL) isOrdinalDateTime: (CRSCoordinateSystemType) type{
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

+(CRSUnitType) unitTypeOfKeyword: (CRSKeyword *) keyword{
    
    CRSUnitType unitType = [CRSUnitTypes type:[keyword name]];
    if((int)unitType < 0){
        [NSException raise:@"No Unit Type" format:@"No unit type found. keyword: %@", [keyword name]];
    }
    
    return unitType;
}

+(CRSUnitType) unitType: (CRSKeywordType) keyword{
    return [self unitTypeOfKeyword:[CRSKeyword keywordOfType:keyword]];
}

+(CRSType) coordinateReferenceSystemType: (CRSKeywordType) keyword{
    
    CRSType crsType = -1;

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
        [NSException raise:@"No CRS Type" format:@"No coordinate reference system type found. keyword: %@", [CRSKeyword nameOfType:keyword]];
    }

    return crsType;
}

+(int) intFromString: (NSString *) string{
    int number;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    if(![scanner scanInt:&number] || ![scanner isAtEnd]){
        [NSException raise:@"Invalid Integer" format:@"Invalid int. found: '%@'", string];
    }
    return number;
}

+(double) doubleFromString: (NSString *) string{
    double number;
    if([string caseInsensitiveCompare:@"NaN"] == NSOrderedSame){
        number = NAN;
    }else if([string caseInsensitiveCompare:@"infinity"] == NSOrderedSame){
        number = INFINITY;
    }else if([string caseInsensitiveCompare:@"-infinity"] == NSOrderedSame){
        number = -INFINITY;
    }else{
        NSScanner *scanner = [NSScanner scannerWithString:string];
        if(![scanner scanDouble:&number] || ![scanner isAtEnd]){
            [NSException raise:@"Invalid Double" format:@"Invalid double. found: '%@'", string];
        }
    }
    return number;
}

+(NSDecimalNumber *) decimalNumberFromString: (NSString *) string{
    NSDecimalNumber *value = nil;
    if(string != nil){
        value = [[NSDecimalNumber alloc] initWithDouble:[self doubleFromString:string]];
    }
    return value;
}

+(NSString *) textFromDouble: (double) value{
    NSNumber *number = [NSNumber numberWithDouble:value];
    return [[number stringValue] uppercaseString];
}

+(NSString *) textFromDecimalNumber: (NSDecimalNumber *) decimalNumber{
    NSString *result = nil;
    if(decimalNumber != nil){
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMaximumFractionDigits:16];
        [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
        NSString *text = [numberFormatter stringFromNumber:decimalNumber];
        double value = [text doubleValue];
        NSNumber *number = [NSNumber numberWithDouble:value];
        result = [[number stringValue] uppercaseString];
    }
    return result;
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
    
    CRSTextReader *reader = [CRSTextReader createWithText:wkt andIncludeQuotes:YES];
    
    NSString *previousToken = [reader readToken];
    NSString *token = [reader readToken];
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

    return pretty;
}

@end
