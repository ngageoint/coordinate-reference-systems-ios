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
    return nil; // TODO
}

+(CRSUnit *) millimetre{
    return nil; // TODO
}

+(CRSUnit *) metre{
    return nil; // TODO
}

+(CRSUnit *) kilometre{
    return nil; // TODO
}

+(CRSUnit *) GermanLegalMetre{
    return nil; // TODO
}

+(CRSUnit *) USSurveyFoot{
    return nil; // TODO
}

+(CRSUnit *) microradian{
    return nil; // TODO
}

+(CRSUnit *) milliradian{
    return nil; // TODO
}

+(CRSUnit *) radian{
    return nil; // TODO
}

+(CRSUnit *) arcSecond{
    return nil; // TODO
}

+(CRSUnit *) arcMinute{
    return nil; // TODO
}

+(CRSUnit *) degree{
    return nil; // TODO
}

+(CRSUnit *) grad{
    return nil; // TODO
}

+(CRSUnit *) unity{
    return nil; // TODO
}

+(CRSUnit *) bin{
    return nil; // TODO
}

+(CRSUnit *) partsPerMillion{
    return nil; // TODO
}

+(CRSUnit *) pascalUnit{
    return nil; // TODO
}

+(CRSUnit *) hectopascal{
    return nil; // TODO
}

+(CRSUnit *) microsecond{
    return nil; // TODO
}

+(CRSUnit *) millisecond{
    return nil; // TODO
}

+(CRSUnit *) second{
    return nil; // TODO
}

+(CRSUnit *) minute{
    return nil; // TODO
}

+(CRSUnit *) hour{
    return nil; // TODO
}

+(CRSUnit *) day{
    return nil; // TODO
}

+(CRSUnit *) year{
    return nil; // TODO
}

+(CRSUnit *) calendarSecond{
    return nil; // TODO
}

+(CRSUnit *) calendarMonth{
    return nil; // TODO
}

+(CRSUnit *) defaultUnit: (enum CRSUnitType) type{
    return nil; // TODO
}

+(BOOL) canConvertBetweenUnit: (CRSUnit *) unit1 andUnit: (CRSUnit *) unit2{
    return NO; // TODO
}

+(double) convertValue: (double) value fromUnit: (CRSUnit *) from toUnit: (CRSUnit *) to{
    return 0; // TODO
}

@end
