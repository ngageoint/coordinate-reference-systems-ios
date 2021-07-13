//
//  CRSDateTime.m
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSDateTime.h"

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
    // TODO
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
    if(fraction != nil){
        double fractionValue = [fraction doubleValue];
        if(fractionValue < 0 || fractionValue >= 1.0){
            [NSException raise:@"Invalid Fraction" format:@"Invalid fraction value: %@", fraction];
        }
    }
    _fraction = fraction;
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

- (BOOL) equals: (CRSDateTime *) dateTime{
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
    
    return [self equals:(CRSDateTime *)object];
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
                    //fraction rangeOfString:<#(nonnull NSString *)#>
                    // TODO
                }
            }
        }
    }
    // TODO
    return text;
}

@end
