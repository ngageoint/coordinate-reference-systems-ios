//
//  CRSUnits.h
//  crs-ios
//
//  Created by Brian Osborn on 7/15/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRSUnit.h"

// Common Unit Names
extern NSString * const CRS_UNITS_MICROMETRE;
extern NSString * const CRS_UNITS_MILLIMETRE;
extern NSString * const CRS_UNITS_METRE;
extern NSString * const CRS_UNITS_KILOMETRE;
extern NSString * const CRS_UNITS_GERMAN_LEGAL_METRE;
extern NSString * const CRS_UNITS_US_SURVEY_FOOT;
extern NSString * const CRS_UNITS_MICRORADIAN;
extern NSString * const CRS_UNITS_MILLIRADIAN;
extern NSString * const CRS_UNITS_RADIAN;
extern NSString * const CRS_UNITS_ARC_SECOND;
extern NSString * const CRS_UNITS_ARC_MINUTE;
extern NSString * const CRS_UNITS_DEGREE;
extern NSString * const CRS_UNITS_GRAD;
extern NSString * const CRS_UNITS_UNITY;
extern NSString * const CRS_UNITS_BIN;
extern NSString * const CRS_UNITS_PARTS_PER_MILLION;
extern NSString * const CRS_UNITS_PASCAL;
extern NSString * const CRS_UNITS_HECTOPASCAL;
extern NSString * const CRS_UNITS_MICROSECOND;
extern NSString * const CRS_UNITS_MILLISECOND;
extern NSString * const CRS_UNITS_SECOND;
extern NSString * const CRS_UNITS_MINUTE;
extern NSString * const CRS_UNITS_HOUR;
extern NSString * const CRS_UNITS_DAY;
extern NSString * const CRS_UNITS_YEAR;
extern NSString * const CRS_UNITS_CALENDAR_SECOND;
extern NSString * const CRS_UNITS_CALENDAR_MONTH;

/**
 * Common Units
 */
@interface CRSUnits : NSObject

/**
 * Get a micrometre unit
 *
 * @return micrometre unit
 */
+(CRSUnit *) micrometre;

/**
 * Get a millimetre unit
 *
 * @return millimetre unit
 */
+(CRSUnit *) millimetre;

/**
 * Get a metre unit
 *
 * @return metre unit
 */
+(CRSUnit *) metre;

/**
 * Get a kilometre unit
 *
 * @return kilometre unit
 */
+(CRSUnit *) kilometre;

/**
 * Get a German legal metre unit
 *
 * @return German legal metre unit
 */
+(CRSUnit *) GermanLegalMetre;

/**
 * Get a US survey foot unit
 *
 * @return US survey foot unit
 */
+(CRSUnit *) USSurveyFoot;

/**
 * Get a microradian unit
 *
 * @return microradian unit
 */
+(CRSUnit *) microradian;

/**
 * Get a milliradian unit
 *
 * @return milliradian unit
 */
+(CRSUnit *) milliradian;

/**
 * Get a radian unit
 *
 * @return radian unit
 */
+(CRSUnit *) radian;

/**
 * Get an arc-second unit
 *
 * @return arc-second unit
 */
+(CRSUnit *) arcSecond;

/**
 * Get an arc-minute unit
 *
 * @return arc-minute unit
 */
+(CRSUnit *) arcMinute;

/**
 * Get a degree unit
 *
 * @return degree unit
 */
+(CRSUnit *) degree;

/**
 * Get a grad unit
 *
 * @return grad unit
 */
+(CRSUnit *) grad;

/**
 * Get a unity unit
 *
 * @return unity unit
 */
+(CRSUnit *) unity;

/**
 * Get a bin unit
 *
 * @return bin unit
 */
+(CRSUnit *) bin;

/**
 * Get a parts per million unit
 *
 * @return parts per million unit
 */
+(CRSUnit *) partsPerMillion;

/**
 * Get a pascal unit
 *
 * @return pascal unit
 */
+(CRSUnit *) pascalUnit;

/**
 * Get a hectopascal unit
 *
 * @return hectopascal unit
 */
+(CRSUnit *) hectopascal;

/**
 * Get a microsecond unit
 *
 * @return microsecond unit
 */
+(CRSUnit *) microsecond;

/**
 * Get a millisecond unit
 *
 * @return millisecond unit
 */
+(CRSUnit *) millisecond;

/**
 * Get a second unit
 *
 * @return second unit
 */
+(CRSUnit *) second;

/**
 * Get a minute unit
 *
 * @return minute unit
 */
+(CRSUnit *) minute;

/**
 * Get a hour unit
 *
 * @return hour unit
 */
+(CRSUnit *) hour;

/**
 * Get a day unit
 *
 * @return day unit
 */
+(CRSUnit *) day;

/**
 * Get a year unit
 *
 * @return year unit
 */
+(CRSUnit *) year;

/**
 * Get a calendar second unit
 *
 * @return calendar second unit
 */
+(CRSUnit *) calendarSecond;

/**
 * Get a calendar month unit
 *
 * @return calendar month unit
 */
+(CRSUnit *) calendarMonth;

/**
 * Get the default unit for the unit type
 *
 * @param type
 *            unit type
 * @return default unit or null if no default
 */
+(CRSUnit *) defaultUnit: (enum CRSUnitType) type;

/**
 * Determine if values can be converted between the two units
 *
 * @param unit1
 *            first unit
 * @param unit2
 *            second unit
 * @return true if can convert
 */
+(BOOL) canConvertBetweenUnit: (CRSUnit *) unit1 andUnit: (CRSUnit *) unit2;

/**
 * Convert the value from a unit to a same typed unit, both with conversion
 * factors
 *
 * @param value
 *            value to convert
 * @param from
 *            unit to convert from
 * @param to
 *            unit to convert to
 * @return converted value
 */
+(double) convertValue: (double) value fromUnit: (CRSUnit *) from toUnit: (CRSUnit *) to;

@end
