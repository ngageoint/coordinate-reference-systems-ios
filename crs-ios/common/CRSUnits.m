//
//  CRSUnits.m
//  crs-ios
//
//  Created by Brian Osborn on 7/15/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSUnits.h>

NSString * const CRS_UNITS_MICROMETRE_NAME = @"micrometre";
NSString * const CRS_UNITS_MILLIMETRE_NAME = @"millimetre";
NSString * const CRS_UNITS_METRE_NAME = @"metre";
NSString * const CRS_UNITS_KILOMETRE_NAME = @"kilometre";
NSString * const CRS_UNITS_GERMAN_LEGAL_METRE_NAME = @"German legal metre";
NSString * const CRS_UNITS_US_SURVEY_FOOT_NAME = @"US survey foot";
NSString * const CRS_UNITS_FOOT_NAME = @"foot";
NSString * const CRS_UNITS_MICRORADIAN_NAME = @"microradian";
NSString * const CRS_UNITS_MILLIRADIAN_NAME = @"milliradian";
NSString * const CRS_UNITS_RADIAN_NAME = @"radian";
NSString * const CRS_UNITS_ARC_SECOND_NAME = @"arc-second";
NSString * const CRS_UNITS_ARC_MINUTE_NAME = @"arc-minute";
NSString * const CRS_UNITS_DEGREE_NAME = @"degree";
NSString * const CRS_UNITS_GRAD_NAME = @"grad";
NSString * const CRS_UNITS_UNITY_NAME = @"unity";
NSString * const CRS_UNITS_BIN_NAME = @"bin";
NSString * const CRS_UNITS_PARTS_PER_MILLION_NAME = @"parts per million";
NSString * const CRS_UNITS_PASCAL_NAME = @"pascal";
NSString * const CRS_UNITS_HECTOPASCAL_NAME = @"hectopascal";
NSString * const CRS_UNITS_MICROSECOND_NAME = @"microsecond";
NSString * const CRS_UNITS_MILLISECOND_NAME = @"millisecond";
NSString * const CRS_UNITS_SECOND_NAME = @"second";
NSString * const CRS_UNITS_MINUTE_NAME = @"minute";
NSString * const CRS_UNITS_HOUR_NAME = @"hour";
NSString * const CRS_UNITS_DAY_NAME = @"day";
NSString * const CRS_UNITS_YEAR_NAME = @"year";
NSString * const CRS_UNITS_CALENDAR_SECOND_NAME = @"calendar second";
NSString * const CRS_UNITS_CALENDAR_MONTH_NAME = @"calendar month";

@implementation CRSUnits

/**
 * Name to Units Type mapping
 */
static NSMutableDictionary<NSString *, NSNumber *> *nameTypes = nil;

+(void) initialize{
    nameTypes = [NSMutableDictionary dictionary];
    
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_MICROMETRE] forKey:[CRS_UNITS_MICROMETRE_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_MICROMETRE] forKey:[self metreToMeter:CRS_UNITS_MICROMETRE_NAME]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_MILLIMETRE] forKey:[CRS_UNITS_MILLIMETRE_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_MILLIMETRE] forKey:[self metreToMeter:CRS_UNITS_MILLIMETRE_NAME]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_METRE] forKey:[CRS_UNITS_METRE_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_METRE] forKey:[self metreToMeter:CRS_UNITS_METRE_NAME]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_KILOMETRE] forKey:[CRS_UNITS_KILOMETRE_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_KILOMETRE] forKey:[self metreToMeter:CRS_UNITS_KILOMETRE_NAME]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_GERMAN_LEGAL_METRE] forKey:[CRS_UNITS_GERMAN_LEGAL_METRE_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_GERMAN_LEGAL_METRE] forKey:[self metreToMeter:CRS_UNITS_GERMAN_LEGAL_METRE_NAME]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_US_SURVEY_FOOT] forKey:[CRS_UNITS_US_SURVEY_FOOT_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_FOOT] forKey:[CRS_UNITS_FOOT_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_MICRORADIAN] forKey:[CRS_UNITS_MICRORADIAN_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_MILLIRADIAN] forKey:[CRS_UNITS_MILLIRADIAN_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_RADIAN] forKey:[CRS_UNITS_RADIAN_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_ARC_SECOND] forKey:[CRS_UNITS_ARC_SECOND_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_ARC_MINUTE] forKey:[CRS_UNITS_ARC_MINUTE_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_DEGREE] forKey:[CRS_UNITS_DEGREE_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_GRAD] forKey:[CRS_UNITS_GRAD_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_UNITY] forKey:[CRS_UNITS_UNITY_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_BIN] forKey:[CRS_UNITS_BIN_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_PARTS_PER_MILLION] forKey:[CRS_UNITS_PARTS_PER_MILLION_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_PASCAL] forKey:[CRS_UNITS_PASCAL_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_HECTOPASCAL] forKey:[CRS_UNITS_HECTOPASCAL_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_MICROSECOND] forKey:[CRS_UNITS_MICROSECOND_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_MILLISECOND] forKey:[CRS_UNITS_MILLISECOND_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_SECOND] forKey:[CRS_UNITS_SECOND_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_MINUTE] forKey:[CRS_UNITS_MINUTE_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_HOUR] forKey:[CRS_UNITS_HOUR_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_DAY] forKey:[CRS_UNITS_DAY_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_YEAR] forKey:[CRS_UNITS_YEAR_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_CALENDAR_SECOND] forKey:[CRS_UNITS_CALENDAR_SECOND_NAME lowercaseString]];
    [nameTypes setObject:[NSNumber numberWithInt:CRS_UNITS_CALENDAR_MONTH] forKey:[CRS_UNITS_CALENDAR_MONTH_NAME lowercaseString]];
    
}

+(CRSUnit *) unitFromName: (NSString *) name{
    CRSUnit *unit = nil;
    CRSUnitsType type = [self typeFromName:name];
    if((int) type != -1){
        unit = [self unitFromType:type];
    }
    return unit;
}

+(CRSUnit *) unitFromType: (CRSUnitsType) type{
    
    CRSUnit *unit = nil;
    
    switch(type){
        case CRS_UNITS_MICROMETRE:
            unit = [self micrometre];
            break;
        case CRS_UNITS_MILLIMETRE:
            unit = [self millimetre];
            break;
        case CRS_UNITS_METRE:
            unit = [self metre];
            break;
        case CRS_UNITS_KILOMETRE:
            unit = [self kilometre];
            break;
        case CRS_UNITS_GERMAN_LEGAL_METRE:
            unit = [self GermanLegalMetre];
            break;
        case CRS_UNITS_US_SURVEY_FOOT:
            unit = [self USSurveyFoot];
            break;
        case CRS_UNITS_FOOT:
            unit = [self foot];
            break;
        case CRS_UNITS_MICRORADIAN:
            unit = [self microradian];
            break;
        case CRS_UNITS_MILLIRADIAN:
            unit = [self milliradian];
            break;
        case CRS_UNITS_RADIAN:
            unit = [self radian];
            break;
        case CRS_UNITS_ARC_SECOND:
            unit = [self arcSecond];
            break;
        case CRS_UNITS_ARC_MINUTE:
            unit = [self arcMinute];
            break;
        case CRS_UNITS_DEGREE:
            unit = [self degree];
            break;
        case CRS_UNITS_GRAD:
            unit = [self grad];
            break;
        case CRS_UNITS_UNITY:
            unit = [self unity];
            break;
        case CRS_UNITS_BIN:
            unit = [self bin];
            break;
        case CRS_UNITS_PARTS_PER_MILLION:
            unit = [self partsPerMillion];
            break;
        case CRS_UNITS_PASCAL:
            unit = [self pascalUnit];
            break;
        case CRS_UNITS_HECTOPASCAL:
            unit = [self hectopascal];
            break;
        case CRS_UNITS_MICROSECOND:
            unit = [self microsecond];
            break;
        case CRS_UNITS_MILLISECOND:
            unit = [self millisecond];
            break;
        case CRS_UNITS_SECOND:
            unit = [self second];
            break;
        case CRS_UNITS_MINUTE:
            unit = [self minute];
            break;
        case CRS_UNITS_HOUR:
            unit = [self hour];
            break;
        case CRS_UNITS_DAY:
            unit = [self day];
            break;
        case CRS_UNITS_YEAR:
            unit = [self year];
            break;
        case CRS_UNITS_CALENDAR_SECOND:
            unit = [self calendarSecond];
            break;
        case CRS_UNITS_CALENDAR_MONTH:
            unit = [self calendarMonth];
            break;
        default:
            [NSException raise:@"Unsupported Unit" format:@"Unsupported Common Unit Type: %u", type];
    }
    
    return unit;
}

+(CRSUnitsType) typeFromName: (NSString *) name{
    CRSUnitsType type = -1;
    NSNumber *typeNumber = [nameTypes objectForKey:[name lowercaseString]];
    if(typeNumber != nil){
        type = [typeNumber intValue];
    }
    return type;
}

+(CRSUnitsType) typeFromUnit: (CRSUnit *) unit{
    return [self typeFromName:unit.name];
}

+(CRSUnit *) micrometre{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_MICROMETRE_NAME andConversionFactor:0.000001];
}

+(CRSUnit *) millimetre{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_MILLIMETRE_NAME andConversionFactor:0.001];
}

+(CRSUnit *) metre{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_METRE_NAME andConversionFactor:1.0];
}

+(CRSUnit *) kilometre{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_KILOMETRE_NAME andConversionFactor:1000.0];
}

+(CRSUnit *) GermanLegalMetre{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_GERMAN_LEGAL_METRE_NAME andConversionFactor:1.0000135965];
}

+(CRSUnit *) USSurveyFoot{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_US_SURVEY_FOOT_NAME andConversionFactor:0.304800609601219];
}

+(CRSUnit *) foot{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_FOOT_NAME andConversionFactor:0.3048];
}

+(CRSUnit *) microradian{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_MICRORADIAN_NAME andConversionFactor:0.000001];
}

+(CRSUnit *) milliradian{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_MILLIRADIAN_NAME andConversionFactor:0.001];
}

+(CRSUnit *) radian{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_RADIAN_NAME andConversionFactor:1.0];
}

+(CRSUnit *) arcSecond{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_ARC_SECOND_NAME andConversionFactor:0.00000484813681109535993589914102357];
}

+(CRSUnit *) arcMinute{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_ARC_MINUTE_NAME andConversionFactor:0.0002908882086657216];
}

+(CRSUnit *) degree{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_DEGREE_NAME andConversionFactor:0.017453292519943295];
}

+(CRSUnit *) grad{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_GRAD_NAME andConversionFactor:0.015707963267949];
}

+(CRSUnit *) unity{
    return [CRSUnit createWithType:CRS_UNIT_SCALE andName:CRS_UNITS_UNITY_NAME andConversionFactor:1.0];
}

+(CRSUnit *) bin{
    return [CRSUnit createWithType:CRS_UNIT_SCALE andName:CRS_UNITS_BIN_NAME andConversionFactor:1.0];
}

+(CRSUnit *) partsPerMillion{
    return [CRSUnit createWithType:CRS_UNIT_SCALE andName:CRS_UNITS_PARTS_PER_MILLION_NAME andConversionFactor:0.000001];
}

+(CRSUnit *) pascalUnit{
    return [CRSUnit createWithType:CRS_UNIT_PARAMETRIC andName:CRS_UNITS_PASCAL_NAME andConversionFactor:1.0];
}

+(CRSUnit *) hectopascal{
    return [CRSUnit createWithType:CRS_UNIT_PARAMETRIC andName:CRS_UNITS_HECTOPASCAL_NAME andConversionFactor:100.0];
}

+(CRSUnit *) microsecond{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_MICROSECOND_NAME andConversionFactor:0.000001];
}

+(CRSUnit *) millisecond{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_MILLISECOND_NAME andConversionFactor:0.001];
}

+(CRSUnit *) second{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_SECOND_NAME andConversionFactor:1.0];
}

+(CRSUnit *) minute{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_MINUTE_NAME andConversionFactor:60.0];
}

+(CRSUnit *) hour{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_HOUR_NAME andConversionFactor:3600.0];
}

+(CRSUnit *) day{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_DAY_NAME andConversionFactor:86400.0];
}

+(CRSUnit *) year{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_YEAR_NAME andConversionFactor:31557600.0];
}

+(CRSUnit *) calendarSecond{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_CALENDAR_SECOND_NAME];
}

+(CRSUnit *) calendarMonth{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_CALENDAR_MONTH_NAME];
}

+(CRSUnitType) unitTypeFromName: (NSString *) name{
    CRSUnitType type = -1;
    CRSUnit *unit = [self unitFromName:name];
    if(unit != nil){
        type = unit.type;
    }
    return type;
}

+(CRSUnit *) defaultUnit: (CRSUnitType) type{
    
    CRSUnit *defaultUnit = nil;
    
    switch(type){
        case CRS_UNIT_LENGTH:
            defaultUnit = [self metre];
            break;
        case CRS_UNIT_ANGLE:
            defaultUnit = [self degree];
            break;
        case CRS_UNIT_SCALE:
            defaultUnit = [self unity];
            break;
        default:
            break;
    }
    
    return defaultUnit;
}

+(BOOL) canConvertBetweenUnit: (CRSUnit *) unit1 andUnit: (CRSUnit *) unit2{
    return unit1 != nil && unit2 != nil
        && (unit1.type == unit2.type || unit1.type == CRS_UNIT || unit2.type == CRS_UNIT)
        && [unit1 hasConversionFactor] && [unit2 hasConversionFactor];
}

+(double) convertValue: (double) value fromUnit: (CRSUnit *) from toUnit: (CRSUnit *) to{
    
    if(from.type != to.type && from.type != CRS_UNIT && to.type != CRS_UNIT){
        [NSException raise:@"Incompatible Conversion" format:@"Can't convert value '%f' from unit type %@ to unit type %@", value, [CRSUnitTypes name:from.type], [CRSUnitTypes name:to.type]];
    }
    
    if(![from hasConversionFactor]){
        [NSException raise:@"Incompatible Conversion" format:@"Can't convert value '%f' from unit type %@ without a conversion factor", value, [CRSUnitTypes name:from.type]];
    }
    
    if(![to hasConversionFactor]){
        [NSException raise:@"Incompatible Conversion" format:@"Can't convert value '%f' to unit type %@ without a conversion factor", value, [CRSUnitTypes name:to.type]];
    }
    
    return value * ([from.conversionFactor doubleValue] / [to.conversionFactor doubleValue]);
}

+(NSString *) metreToMeter: (NSString *) metre{
    return [[metre lowercaseString] stringByReplacingOccurrencesOfString:@"metre" withString:@"meter"];
}

@end
