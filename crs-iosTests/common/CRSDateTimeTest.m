//
//  CRSDateTimeTest.m
//  crs-iosTests
//
//  Created by Brian Osborn on 8/5/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSDateTimeTest.h"
#import "CRSTestUtils.h"
@import CoordinateReferenceSystems;

@implementation CRSDateTimeTest

/**
 * Test Year precision
 */
-(void) testYear{
    
    NSString *text = @"2014";
    CRSDateTime *dateTime = [CRSDateTime parse:text];
    [CRSTestUtils assertNotNil:dateTime];
    [CRSTestUtils assertEqualIntWithValue:2014 andValue2:dateTime.year];
    [CRSTestUtils assertFalse:[dateTime isOrdinal]];
    [CRSTestUtils assertFalse:[dateTime hasTime]];
    [CRSTestUtils assertEqualWithValue:text andValue2:[dateTime description]];
    
}

/**
 * Test Month precision
 */
-(void) testMonth{
    
    NSString *text = @"2014-01";
    CRSDateTime *dateTime = [CRSDateTime parse:text];
    [CRSTestUtils assertNotNil:dateTime];
    [CRSTestUtils assertEqualIntWithValue:2014 andValue2:dateTime.year];
    [CRSTestUtils assertEqualIntWithValue:1 andValue2:[dateTime.month intValue]];
    [CRSTestUtils assertFalse:[dateTime isOrdinal]];
    [CRSTestUtils assertFalse:[dateTime hasTime]];
    [CRSTestUtils assertEqualWithValue:text andValue2:[dateTime description]];
    
}

/**
 * Test Day precision
 */
-(void) testDay{
    
    NSString *text = @"2014-03-01";
    CRSDateTime *dateTime = [CRSDateTime parse:text];
    [CRSTestUtils assertNotNil:dateTime];
    [CRSTestUtils assertEqualIntWithValue:2014 andValue2:dateTime.year];
    [CRSTestUtils assertEqualIntWithValue:3 andValue2:[dateTime.month intValue]];
    [CRSTestUtils assertEqualIntWithValue:1 andValue2:[dateTime.day intValue]];
    [CRSTestUtils assertFalse:[dateTime isOrdinal]];
    [CRSTestUtils assertFalse:[dateTime hasTime]];
    [CRSTestUtils assertEqualWithValue:text andValue2:[dateTime description]];
    
}

/**
 * Test Ordinal Day precision
 */
-(void) testOrdinalDay{
    
    NSString *text = @"2014-060";
    CRSDateTime *dateTime = [CRSDateTime parse:text];
    [CRSTestUtils assertNotNil:dateTime];
    [CRSTestUtils assertEqualIntWithValue:2014 andValue2:dateTime.year];
    [CRSTestUtils assertEqualIntWithValue:60 andValue2:[dateTime.day intValue]];
    [CRSTestUtils assertTrue:[dateTime isOrdinal]];
    [CRSTestUtils assertFalse:[dateTime hasTime]];
    [CRSTestUtils assertEqualWithValue:text andValue2:[dateTime description]];
    
}

/**
 * Test Hour precision UTC
 */
-(void) testHourUTC{
    
    NSString *text = @"2014-05-06T23Z";
    CRSDateTime *dateTime = [CRSDateTime parse:text];
    [CRSTestUtils assertNotNil:dateTime];
    [CRSTestUtils assertEqualIntWithValue:2014 andValue2:dateTime.year];
    [CRSTestUtils assertEqualIntWithValue:5 andValue2:[dateTime.month intValue]];
    [CRSTestUtils assertEqualIntWithValue:6 andValue2:[dateTime.day intValue]];
    [CRSTestUtils assertFalse:[dateTime isOrdinal]];
    [CRSTestUtils assertTrue:[dateTime hasTime]];
    [CRSTestUtils assertEqualIntWithValue:23 andValue2:[dateTime.hour intValue]];
    [CRSTestUtils assertTrue:[dateTime isTimeZoneUTC]];
    [CRSTestUtils assertEqualWithValue:text andValue2:[dateTime description]];
    
}

/**
 * Test Ordinal Hour precision UTC
 */
-(void) testOrdinalHourUTC{
    
    NSString *text = @"2014-157T23Z";
    CRSDateTime *dateTime = [CRSDateTime parse:text];
    [CRSTestUtils assertNotNil:dateTime];
    [CRSTestUtils assertEqualIntWithValue:2014 andValue2:dateTime.year];
    [CRSTestUtils assertEqualIntWithValue:157 andValue2:[dateTime.day intValue]];
    [CRSTestUtils assertTrue:[dateTime isOrdinal]];
    [CRSTestUtils assertTrue:[dateTime hasTime]];
    [CRSTestUtils assertEqualIntWithValue:23 andValue2:[dateTime.hour intValue]];
    [CRSTestUtils assertTrue:[dateTime isTimeZoneUTC]];
    [CRSTestUtils assertEqualWithValue:text andValue2:[dateTime description]];
    
}

/**
 * Test Minute precision UTC
 */
-(void) testMinuteUTC{
    
    NSString *text = @"2014-07-12T16:00Z";
    CRSDateTime *dateTime = [CRSDateTime parse:text];
    [CRSTestUtils assertNotNil:dateTime];
    [CRSTestUtils assertEqualIntWithValue:2014 andValue2:dateTime.year];
    [CRSTestUtils assertEqualIntWithValue:7 andValue2:[dateTime.month intValue]];
    [CRSTestUtils assertEqualIntWithValue:12 andValue2:[dateTime.day intValue]];
    [CRSTestUtils assertFalse:[dateTime isOrdinal]];
    [CRSTestUtils assertTrue:[dateTime hasTime]];
    [CRSTestUtils assertEqualIntWithValue:16 andValue2:[dateTime.hour intValue]];
    [CRSTestUtils assertEqualIntWithValue:0 andValue2:[dateTime.minute intValue]];
    [CRSTestUtils assertTrue:[dateTime isTimeZoneUTC]];
    [CRSTestUtils assertEqualWithValue:text andValue2:[dateTime description]];
    
}

/**
 * Test Minute precision ahead of UTC
 */
-(void) testMinuteAheadUTC{
    
    NSString *text = @"2014-07-12T17:00+01";
    CRSDateTime *dateTime = [CRSDateTime parse:text];
    [CRSTestUtils assertNotNil:dateTime];
    [CRSTestUtils assertEqualIntWithValue:2014 andValue2:dateTime.year];
    [CRSTestUtils assertEqualIntWithValue:7 andValue2:[dateTime.month intValue]];
    [CRSTestUtils assertEqualIntWithValue:12 andValue2:[dateTime.day intValue]];
    [CRSTestUtils assertFalse:[dateTime isOrdinal]];
    [CRSTestUtils assertTrue:[dateTime hasTime]];
    [CRSTestUtils assertEqualIntWithValue:17 andValue2:[dateTime.hour intValue]];
    [CRSTestUtils assertEqualIntWithValue:0 andValue2:[dateTime.minute intValue]];
    [CRSTestUtils assertFalse:[dateTime isTimeZoneUTC]];
    [CRSTestUtils assertEqualIntWithValue:1 andValue2:[dateTime.timeZoneHour intValue]];
    [CRSTestUtils assertEqualWithValue:text andValue2:[dateTime description]];
    
}

/**
 * Test Second precision ahead of UTC
 */
-(void) testSecondBehindUTC{
    
    NSString *text = @"2014-09-18T08:17:56-08";
    CRSDateTime *dateTime = [CRSDateTime parse:text];
    [CRSTestUtils assertNotNil:dateTime];
    [CRSTestUtils assertEqualIntWithValue:2014 andValue2:dateTime.year];
    [CRSTestUtils assertEqualIntWithValue:9 andValue2:[dateTime.month intValue]];
    [CRSTestUtils assertEqualIntWithValue:18 andValue2:[dateTime.day intValue]];
    [CRSTestUtils assertFalse:[dateTime isOrdinal]];
    [CRSTestUtils assertTrue:[dateTime hasTime]];
    [CRSTestUtils assertEqualIntWithValue:8 andValue2:[dateTime.hour intValue]];
    [CRSTestUtils assertEqualIntWithValue:17 andValue2:[dateTime.minute intValue]];
    [CRSTestUtils assertEqualIntWithValue:56 andValue2:[dateTime.second intValue]];
    [CRSTestUtils assertFalse:[dateTime isTimeZoneUTC]];
    [CRSTestUtils assertEqualIntWithValue:-8 andValue2:[dateTime.timeZoneHour intValue]];
    [CRSTestUtils assertEqualWithValue:text andValue2:[dateTime description]];
    
}

/**
 * Test Fraction precision UTC
 */
-(void) testFractionUTC{
    
    NSString *text = @"2014-11-23T00:34:56.789Z";
    CRSDateTime *dateTime = [CRSDateTime parse:text];
    [CRSTestUtils assertNotNil:dateTime];
    [CRSTestUtils assertEqualIntWithValue:2014 andValue2:dateTime.year];
    [CRSTestUtils assertEqualIntWithValue:11 andValue2:[dateTime.month intValue]];
    [CRSTestUtils assertEqualIntWithValue:23 andValue2:[dateTime.day intValue]];
    [CRSTestUtils assertFalse:[dateTime isOrdinal]];
    [CRSTestUtils assertTrue:[dateTime hasTime]];
    [CRSTestUtils assertEqualIntWithValue:0 andValue2:[dateTime.hour intValue]];
    [CRSTestUtils assertEqualIntWithValue:34 andValue2:[dateTime.minute intValue]];
    [CRSTestUtils assertEqualIntWithValue:56 andValue2:[dateTime.second intValue]];
    [CRSTestUtils assertEqualDoubleWithValue:0.789 andValue2:[dateTime.fraction doubleValue]];
    [CRSTestUtils assertTrue:[dateTime isTimeZoneUTC]];
    [CRSTestUtils assertEqualWithValue:text andValue2:[dateTime description]];
    
}

/**
 * Test Fraction precision ahead of UTC
 */
-(void) testFractionAheadUTC{
    
    NSString *text = @"2014-11-23T00:34:56.789+06:35";
    CRSDateTime *dateTime = [CRSDateTime parse:text];
    [CRSTestUtils assertNotNil:dateTime];
    [CRSTestUtils assertEqualIntWithValue:2014 andValue2:dateTime.year];
    [CRSTestUtils assertEqualIntWithValue:11 andValue2:[dateTime.month intValue]];
    [CRSTestUtils assertEqualIntWithValue:23 andValue2:[dateTime.day intValue]];
    [CRSTestUtils assertFalse:[dateTime isOrdinal]];
    [CRSTestUtils assertTrue:[dateTime hasTime]];
    [CRSTestUtils assertEqualIntWithValue:0 andValue2:[dateTime.hour intValue]];
    [CRSTestUtils assertEqualIntWithValue:34 andValue2:[dateTime.minute intValue]];
    [CRSTestUtils assertEqualIntWithValue:56 andValue2:[dateTime.second intValue]];
    [CRSTestUtils assertEqualDoubleWithValue:0.789 andValue2:[dateTime.fraction doubleValue]];
    [CRSTestUtils assertFalse:[dateTime isTimeZoneUTC]];
    [CRSTestUtils assertEqualIntWithValue:6 andValue2:[dateTime.timeZoneHour intValue]];
    [CRSTestUtils assertEqualIntWithValue:35 andValue2:[dateTime.timeZoneMinute intValue]];
    [CRSTestUtils assertEqualWithValue:text andValue2:[dateTime description]];
    
}

/**
 * Test Fraction precision behind of UTC
 */
-(void) testFractionBehindUTC{
    
    NSString *text = @"2014-11-23T00:34:56.789-10:07";
    CRSDateTime *dateTime = [CRSDateTime parse:text];
    [CRSTestUtils assertNotNil:dateTime];
    [CRSTestUtils assertEqualIntWithValue:2014 andValue2:dateTime.year];
    [CRSTestUtils assertEqualIntWithValue:11 andValue2:[dateTime.month intValue]];
    [CRSTestUtils assertEqualIntWithValue:23 andValue2:[dateTime.day intValue]];
    [CRSTestUtils assertFalse:[dateTime isOrdinal]];
    [CRSTestUtils assertTrue:[dateTime hasTime]];
    [CRSTestUtils assertEqualIntWithValue:0 andValue2:[dateTime.hour intValue]];
    [CRSTestUtils assertEqualIntWithValue:34 andValue2:[dateTime.minute intValue]];
    [CRSTestUtils assertEqualIntWithValue:56 andValue2:[dateTime.second intValue]];
    [CRSTestUtils assertEqualDoubleWithValue:0.789 andValue2:[dateTime.fraction doubleValue]];
    [CRSTestUtils assertFalse:[dateTime isTimeZoneUTC]];
    [CRSTestUtils assertEqualIntWithValue:-10 andValue2:[dateTime.timeZoneHour intValue]];
    [CRSTestUtils assertEqualIntWithValue:7 andValue2:[dateTime.timeZoneMinute intValue]];
    [CRSTestUtils assertEqualWithValue:text andValue2:[dateTime description]];
    
}

@end
