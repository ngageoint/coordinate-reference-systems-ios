//
//  CRSTemporalExtent.m
//  crs-ios
//
//  Created by Brian Osborn on 7/14/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSTemporalExtent.h>
#import <CoordinateReferenceSystems/CRSWriter.h>

@implementation CRSTemporalExtent

+(CRSTemporalExtent *) create{
    return [[CRSTemporalExtent alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithStart: (NSString *) start andEnd: (NSString *) end{
    self = [super init];
    if(self != nil){
        [self setStart:start];
        [self setEnd:end];
    }
    return self;
}

-(instancetype) initWithStartDateTime: (CRSDateTime *) start andEndDateTime: (CRSDateTime *) end{
    self = [super init];
    if(self != nil){
        [self setStartDateTime:start];
        [self setEndDateTime:end];
    }
    return self;
}

-(void) setStart: (NSString *) start{
    _start = start;
    CRSDateTime *dateTime = [CRSDateTime tryParse:start];
    if(dateTime != nil){
        _startDateTime = dateTime;
    }
}

-(BOOL) hasStartDateTime{
    return [self startDateTime] != nil;
}

-(void) setStartDateTime: (CRSDateTime *) startDateTime{
    _startDateTime = startDateTime;
    _start = [startDateTime description];
}

-(void) setStartDateTimeWithStart: (NSString *) start{
    _start = start;
    _startDateTime = [CRSDateTime parse:start];
}

-(void) setEnd: (NSString *) end{
    _end = end;
    CRSDateTime *dateTime = [CRSDateTime tryParse:end];
    if(dateTime != nil){
        _endDateTime = dateTime;
    }
}

-(BOOL) hasEndDateTime{
    return [self endDateTime] != nil;
}

-(void) setEndDateTime: (CRSDateTime *) endDateTime{
    _endDateTime = endDateTime;
    _end = [endDateTime description];
}

-(void) setEndDateTimeWithEnd: (NSString *) end{
    _end = end;
    _endDateTime = [CRSDateTime parse:end];
}

- (BOOL) isEqualToTemporalExtent: (CRSTemporalExtent *) temporalExtent{
    if (self == temporalExtent){
        return YES;
    }
    if (temporalExtent == nil){
        return NO;
    }
    if (_start == nil) {
        if (temporalExtent.start != nil){
            return NO;
        }
    } else if (![_start isEqualToString:temporalExtent.start]){
        return NO;
    }
    if (_startDateTime == nil) {
        if (temporalExtent.startDateTime != nil){
            return NO;
        }
    } else if (![_startDateTime isEqual:temporalExtent.startDateTime]){
        return NO;
    }
    if (_end == nil) {
        if (temporalExtent.end != nil){
            return NO;
        }
    } else if (![_end isEqualToString:temporalExtent.end]){
        return NO;
    }
    if (_endDateTime == nil) {
        if (temporalExtent.endDateTime != nil){
            return NO;
        }
    } else if (![_endDateTime isEqual:temporalExtent.endDateTime]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSTemporalExtent class]]) {
        return NO;
    }
    
    return [self isEqualToTemporalExtent:(CRSTemporalExtent *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_start == nil) ? 0 : [_start hash]);
    result = prime * result + ((_startDateTime == nil) ? 0 : [_startDateTime hash]);
    result = prime * result + ((_end == nil) ? 0 : [_end hash]);
    result = prime * result + ((_endDateTime == nil) ? 0 : [_endDateTime hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeTemporalExtent:self];
    return [writer description];
}

@end
