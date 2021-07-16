//
//  CRSUnits.m
//  crs-ios
//
//  Created by Brian Osborn on 7/15/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSUnits.h"

NSString * const CRS_UNITS_MICROMETRE = @"metre";
NSString * const CRS_UNITS_MILLIMETRE = @"millimetre";
NSString * const CRS_UNITS_METRE = @"metre";
NSString * const CRS_UNITS_KILOMETRE = @"kilometre";
NSString * const CRS_UNITS_GERMAN_LEGAL_METRE = @"German legal metre";
NSString * const CRS_UNITS_US_SURVEY_FOOT = @"US survey foot";
NSString * const CRS_UNITS_MICRORADIAN = @"microradian";
NSString * const CRS_UNITS_MILLIRADIAN = @"milliradian";
NSString * const CRS_UNITS_RADIAN = @"radian";
NSString * const CRS_UNITS_ARC_SECOND = @"arc-second";
NSString * const CRS_UNITS_ARC_MINUTE = @"arc-minute";
NSString * const CRS_UNITS_DEGREE = @"degree";
NSString * const CRS_UNITS_GRAD = @"grad";
NSString * const CRS_UNITS_UNITY = @"unity";
NSString * const CRS_UNITS_BIN = @"bin";
NSString * const CRS_UNITS_PARTS_PER_MILLION = @"parts per million";
NSString * const CRS_UNITS_PASCAL = @"pascal";
NSString * const CRS_UNITS_HECTOPASCAL = @"hectopascal";
NSString * const CRS_UNITS_MICROSECOND = @"microsecond";
NSString * const CRS_UNITS_MILLISECOND = @"millisecond";
NSString * const CRS_UNITS_SECOND = @"second";
NSString * const CRS_UNITS_MINUTE = @"minute";
NSString * const CRS_UNITS_HOUR = @"hour";
NSString * const CRS_UNITS_DAY = @"day";
NSString * const CRS_UNITS_YEAR = @"year";
NSString * const CRS_UNITS_CALENDAR_SECOND = @"calendar second";
NSString * const CRS_UNITS_CALENDAR_MONTH = @"calendar month";

@implementation CRSUnits

+(CRSUnit *) micrometre{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_MICROMETRE andConversionFactor:0.000001];
}

+(CRSUnit *) millimetre{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_MILLIMETRE andConversionFactor:0.001];
}

+(CRSUnit *) metre{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_METRE andConversionFactor:1.0];
}

+(CRSUnit *) kilometre{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_KILOMETRE andConversionFactor:1000.0];
}

+(CRSUnit *) GermanLegalMetre{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_GERMAN_LEGAL_METRE andConversionFactor:1.0000135965];
}

+(CRSUnit *) USSurveyFoot{
    return [CRSUnit createWithType:CRS_UNIT_LENGTH andName:CRS_UNITS_US_SURVEY_FOOT andConversionFactor:0.304800609601219];
}

+(CRSUnit *) microradian{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_MICRORADIAN andConversionFactor:0.000001];
}

+(CRSUnit *) milliradian{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_MILLIRADIAN andConversionFactor:0.001];
}

+(CRSUnit *) radian{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_RADIAN andConversionFactor:1.0];
}

+(CRSUnit *) arcSecond{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_ARC_SECOND andConversionFactor:0.00000484813681109535993589914102357];
}

+(CRSUnit *) arcMinute{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_ARC_MINUTE andConversionFactor:0.0002908882086657216];
}

+(CRSUnit *) degree{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_DEGREE andConversionFactor:0.017453292519943295];
}

+(CRSUnit *) grad{
    return [CRSUnit createWithType:CRS_UNIT_ANGLE andName:CRS_UNITS_GRAD andConversionFactor:0.015707963267949];
}

+(CRSUnit *) unity{
    return [CRSUnit createWithType:CRS_UNIT_SCALE andName:CRS_UNITS_UNITY andConversionFactor:1.0];
}

+(CRSUnit *) bin{
    return [CRSUnit createWithType:CRS_UNIT_SCALE andName:CRS_UNITS_BIN andConversionFactor:1.0];
}

+(CRSUnit *) partsPerMillion{
    return [CRSUnit createWithType:CRS_UNIT_SCALE andName:CRS_UNITS_PARTS_PER_MILLION andConversionFactor:0.000001];
}

+(CRSUnit *) pascalUnit{
    return [CRSUnit createWithType:CRS_UNIT_PARAMETRIC andName:CRS_UNITS_PASCAL andConversionFactor:1.0];
}

+(CRSUnit *) hectopascal{
    return [CRSUnit createWithType:CRS_UNIT_PARAMETRIC andName:CRS_UNITS_HECTOPASCAL andConversionFactor:100.0];
}

+(CRSUnit *) microsecond{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_MICROSECOND andConversionFactor:0.000001];
}

+(CRSUnit *) millisecond{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_MILLISECOND andConversionFactor:0.001];
}

+(CRSUnit *) second{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_SECOND andConversionFactor:1.0];
}

+(CRSUnit *) minute{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_MINUTE andConversionFactor:60.0];
}

+(CRSUnit *) hour{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_HOUR andConversionFactor:3600.0];
}

+(CRSUnit *) day{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_DAY andConversionFactor:86400.0];
}

+(CRSUnit *) year{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_YEAR andConversionFactor:31557600.0];
}

+(CRSUnit *) calendarSecond{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_CALENDAR_SECOND];
}

+(CRSUnit *) calendarMonth{
    return [CRSUnit createWithType:CRS_UNIT_TIME andName:CRS_UNITS_CALENDAR_MONTH];
}

+(CRSUnit *) defaultUnit: (enum CRSUnitType) type{
    
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
        && unit1.type == unit2.type
        && [unit1 hasConversionFactor] && [unit2 hasConversionFactor];
}

+(double) convertValue: (double) value fromUnit: (CRSUnit *) from toUnit: (CRSUnit *) to{
    
    if(from.type != to.type){
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

@end
