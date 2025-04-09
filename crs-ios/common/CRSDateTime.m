//
//  CRSDateTime.m
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSDateTime.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>

@implementation CRSDateTime

/**
 * Hyphen
 */
static NSString *HYPHEN = @"-";

/**
 * Time Designator
 */
static NSString *TIME_DESIGNATOR = @"T";

/**
 * Colon
 */
static NSString *COLON = @":";

/**
 * Period
 */
static NSString *PERIOD = @".";

/**
 * UTC Time Zone Designator
 */
static NSString *UTC = @"Z";

/**
 * Plus Sign
 */
static NSString *PLUS_SIGN = @"+";

/**
 * Minus Sign
 */
static NSString *MINUS_SIGN = @"-";

+(CRSDateTime *) parse: (NSString *) text{

    CRSDateTime *dateTime = nil;
    
    if(text != nil && text.length >= 4){
        
        NSArray<NSString *> *dateTimeParts = [text componentsSeparatedByString:TIME_DESIGNATOR];
        
        NSString *date = nil;
        
        int numDateTimeParts = (int) dateTimeParts.count;
        if(numDateTimeParts == 1 || numDateTimeParts == 2){
            date = [dateTimeParts firstObject];
        }
        
        if(date != nil){
            
            NSArray<NSString *> *dateParts = [date componentsSeparatedByString:HYPHEN];
            int numDateParts = (int) dateParts.count;
            
            if(numDateParts >= 1 && numDateParts <= 3){
                dateTime = [CRSDateTime create];
                
                [dateTime setYear:[CRSTextUtils intFromString:[dateParts firstObject]]];
                
                if(numDateParts > 1){
                    NSNumber *datePartTwo = [NSNumber numberWithInt:[CRSTextUtils intFromString:[dateParts objectAtIndex:1]]];
                    if(numDateParts == 2){
                        if([dateParts objectAtIndex:1].length == 2){
                            [dateTime setMonth:datePartTwo];
                        }else{
                            [dateTime setDay:datePartTwo];
                        }
                    }else{
                        [dateTime setMonth:datePartTwo];
                        [dateTime setDay:[NSNumber numberWithInt:[CRSTextUtils intFromString:[dateParts objectAtIndex:2]]]];
                    }
                }
            }
            
        }
        
        if(dateTime != nil && numDateTimeParts == 2){
            NSString *timeWithZone = [dateTimeParts objectAtIndex:1];
            
            NSRange zoneRange = [timeWithZone rangeOfString:UTC];
            if(zoneRange.length == 0){
                zoneRange = [timeWithZone rangeOfString:PLUS_SIGN];
                if(zoneRange.length == 0){
                    zoneRange = [timeWithZone rangeOfString:MINUS_SIGN];
                }
            }
            if(zoneRange.length > 0){
                
                NSString *timeZone = [timeWithZone substringFromIndex:zoneRange.location];
                if(![timeZone isEqualToString:UTC]){
                    NSArray<NSString *> *timeZoneParts = [timeZone componentsSeparatedByString:COLON];
                    [dateTime setTimeZoneHour:[NSNumber numberWithInt:[CRSTextUtils intFromString:[timeZoneParts firstObject]]]];
                    if(timeZoneParts.count == 2){
                        [dateTime setTimeZoneMinute:[NSNumber numberWithInt:[CRSTextUtils intFromString:[timeZoneParts objectAtIndex:1]]]];
                    }
                }
                
                NSString *time = [timeWithZone substringToIndex:zoneRange.location];
                NSArray<NSString *> *timeParts = [time componentsSeparatedByString:COLON];
                int numTimeParts = (int) timeParts.count;

                if(numTimeParts >= 1 && numTimeParts <= 3){
                    [dateTime setHour:[NSNumber numberWithInt:[CRSTextUtils intFromString:[timeParts firstObject]]]];
                    if(numTimeParts > 1){
                        [dateTime setMinute:[NSNumber numberWithInt:[CRSTextUtils intFromString:[timeParts objectAtIndex:1]]]];
                        if(numTimeParts > 2){
                            NSString *seconds = [timeParts objectAtIndex:2];
                            NSRange decimalRange = [seconds rangeOfString:PERIOD];
                            if(decimalRange.length > 0){
                                NSString *fraction = [NSString stringWithFormat:@"0%@%@", PERIOD, [seconds substringFromIndex:decimalRange.location + 1]];
                                [dateTime setFraction:[[NSDecimalNumber alloc] initWithDouble:[CRSTextUtils doubleFromString:fraction]]];
                                seconds = [seconds substringToIndex:decimalRange.location];
                            }
                            [dateTime setSecond:[NSNumber numberWithInt:[CRSTextUtils intFromString:seconds]]];
                        }
                    }
                }
            }
            
            if (![dateTime hasHour]) {
                dateTime = nil;
            }
        }
        
    }
    
    if (dateTime == nil) {
        [NSException raise:@"Invalid Date Time" format:@"Invalid Date and Time value: %@", text];
    }

    return dateTime;
}

+(CRSDateTime *) tryParse: (NSString *) text{
    CRSDateTime *dateTime = nil;
    @try {
        dateTime = [self parse:text];
    } @catch (NSException *exception) {
        // eat
    }
    return dateTime;
}

+(CRSDateTime *) create{
    return [[CRSDateTime alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithYear: (int) year{
    self = [super init];
    if(self != nil){
        [self setYear:year];
    }
    return self;
}

-(BOOL) isOrdinal{
    return _day != nil && _month == nil;
}

-(BOOL) hasTime{
    return [self hasHour];
}

-(BOOL) hasMonth{
    return [self month] != nil;
}

-(BOOL) hasDay{
    return [self day] != nil;
}

-(BOOL) hasHour{
    return [self hour] != nil;
}

-(BOOL) hasMinute{
    return [self minute] != nil;
}

-(BOOL) hasSecond{
    return [self second] != nil;
}

-(BOOL) hasFraction{
    return [self fraction] != nil;
}

-(void) setFraction: (NSDecimalNumber *) fraction{
    [self validateFraction:fraction];
    _fraction = fraction;
    _fractionText = [CRSTextUtils textFromDecimalNumber:fraction];
}

-(void) setFractionText: (NSString *) fractionText{
    NSDecimalNumber *fraction = [CRSTextUtils decimalNumberFromString:fractionText];
    [self validateFraction:fraction];
    _fractionText = fractionText;
    _fraction = fraction;
}

-(void) validateFraction: (NSDecimalNumber *) fraction{
    if(fraction != nil){
        double fractionValue = [fraction doubleValue];
        if(fractionValue < 0 || fractionValue >= 1.0){
            [NSException raise:@"Invalid Fraction" format:@"Invalid fraction value: %@", fraction];
        }
    }
}

-(BOOL) hasTimeZoneHour{
    return [self timeZoneHour] != nil;
}

-(BOOL) hasTimeZoneMinute{
    return [self timeZoneMinute] != nil;
}

-(BOOL) isTimeZoneUTC{
    return ![self hasTimeZoneHour];
}

-(void) setTimeZoneUTC{
    [self setTimeZoneHour:nil];
    [self setTimeZoneMinute:nil];
}

- (BOOL) isEqualToDateTime: (CRSDateTime *) dateTime{
    if (self == dateTime){
        return YES;
    }
    if (dateTime == nil){
        return NO;
    }
    if(_year != dateTime.year){
        return NO;
    }
    if (_month == nil) {
        if (dateTime.month != nil){
            return NO;
        }
    } else if (![_month isEqual:dateTime.month]){
        return NO;
    }
    if (_day == nil) {
        if (dateTime.day != nil){
            return NO;
        }
    } else if (![_day isEqual:dateTime.day]){
        return NO;
    }
    if (_hour == nil) {
        if (dateTime.hour != nil){
            return NO;
        }
    } else if (![_hour isEqual:dateTime.hour]){
        return NO;
    }
    if (_minute == nil) {
        if (dateTime.minute != nil){
            return NO;
        }
    } else if (![_minute isEqual:dateTime.minute]){
        return NO;
    }
    if (_second == nil) {
        if (dateTime.second != nil){
            return NO;
        }
    } else if (![_second isEqual:dateTime.second]){
        return NO;
    }
    if (_fraction == nil) {
        if (dateTime.fraction != nil){
            return NO;
        }
    } else if (![_fraction isEqual:dateTime.fraction]){
        return NO;
    }
    if (_timeZoneHour == nil) {
        if (dateTime.timeZoneHour != nil){
            return NO;
        }
    } else if (![_timeZoneHour isEqual:dateTime.timeZoneHour]){
        return NO;
    }
    if (_timeZoneMinute == nil) {
        if (dateTime.timeZoneMinute != nil){
            return NO;
        }
    } else if (![_timeZoneMinute isEqual:dateTime.timeZoneMinute]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSDateTime class]]) {
        return NO;
    }
    
    return [self isEqualToDateTime:(CRSDateTime *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + _year;
    result = prime * result + ((_month == nil) ? 0 : [_month hash]);
    result = prime * result + ((_day == nil) ? 0 : [_day hash]);
    result = prime * result + ((_hour == nil) ? 0 : [_hour hash]);
    result = prime * result + ((_minute == nil) ? 0 : [_minute hash]);
    result = prime * result + ((_second == nil) ? 0 : [_second hash]);
    result = prime * result + ((_fraction == nil) ? 0 : [_fraction hash]);
    result = prime * result + ((_timeZoneHour == nil) ? 0 : [_timeZoneHour hash]);
    result = prime * result + ((_timeZoneMinute == nil) ? 0 : [_timeZoneMinute hash]);
    return result;
}

-(NSString *) description{
    NSMutableString *text = [NSMutableString string];
    [text appendFormat:@"%04d", [self year]];
    if([self hasMonth]){
        [text appendString:HYPHEN];
        [text appendFormat:@"%02d", [[self month] intValue]];
    }
    if([self hasDay]){
        [text appendString:HYPHEN];
        if([self isOrdinal]){
            [text appendFormat:@"%03d", [[self day] intValue]];
        }else{
            [text appendFormat:@"%02d", [[self day] intValue]];
        }
    }
    if([self hasHour]){
        [text appendString:TIME_DESIGNATOR];
        [text appendFormat:@"%02d", [[self hour] intValue]];
        if([self hasMinute]){
            [text appendString:COLON];
            [text appendFormat:@"%02d", [[self minute] intValue]];
            if([self hasSecond]){
                [text appendString:COLON];
                [text appendFormat:@"%02d", [[self second] intValue]];
                if([self hasFraction]){
                    NSString *fraction = [[self fraction] stringValue];
                    NSRange periodRange = [fraction rangeOfString:PERIOD];
                    if(periodRange.length != 0){
                        if(periodRange.location + 1 < fraction.length){
                            [text appendString:PERIOD];
                            [text appendString:[fraction substringFromIndex:periodRange.location + 1]];
                        }
                    }else{
                        [text appendString:PERIOD];
                        [text appendString:fraction];
                    }
                }
            }
        }
        if([self isTimeZoneUTC]){
            [text appendString:UTC];
        }else{
            int timeZoneHour = [[self timeZoneHour] intValue];
            if(timeZoneHour >= 0){
                [text appendString:PLUS_SIGN];
            }else{
                [text appendString:MINUS_SIGN];
                timeZoneHour *= -1;
            }
            [text appendFormat:@"%02d", timeZoneHour];
            if([self hasTimeZoneMinute]){
                [text appendString:COLON];
                [text appendFormat:@"%02d", [[self timeZoneMinute] intValue]];
            }
        }
    }
    return text;
}

@end
