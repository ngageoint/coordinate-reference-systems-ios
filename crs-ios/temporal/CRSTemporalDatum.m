//
//  CRSTemporalDatum.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSTemporalDatum.h>
#import <CoordinateReferenceSystems/CRSWriter.h>

@implementation CRSTemporalDatum

+(CRSTemporalDatum *) create{
    return [[CRSTemporalDatum alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithName: (NSString *) name{
    self = [super init];
    if(self != nil){
        [self setName:name];
    }
    return self;
}

-(BOOL) hasCalendar{
    return [self calendar] != nil;
}

-(BOOL) hasOrigin{
    return [self origin] != nil;
}

-(void) setOrigin: (NSString *) origin{
    _origin = origin;
    CRSDateTime *dateTime = [CRSDateTime tryParse:origin];
    if(dateTime != nil){
        _originDateTime = dateTime;
    }
}

-(BOOL) hasOriginDateTime{
    return [self originDateTime] != nil;
}

-(void) setOriginDateTime: (CRSDateTime *) originDateTime{
    _originDateTime = originDateTime;
    _origin = [originDateTime description];
}

-(void) setOriginDateTimeWithOrigin: (NSString *) origin{
    _origin = origin;
    _originDateTime = [CRSDateTime parse:origin];
}

-(BOOL) hasIdentifiers{
    return _identifiers != nil && _identifiers.count > 0;
}

-(int) numIdentifiers{
    return _identifiers != nil ? (int) _identifiers.count : 0;
}

-(CRSIdentifier *) identifierAtIndex: (int) index{
    return [_identifiers objectAtIndex:index];
}

-(void) addIdentifier: (CRSIdentifier *) identifier{
    if(_identifiers == nil){
        _identifiers = [NSMutableArray array];
    }
    [_identifiers addObject:identifier];
}

-(void) addIdentifiers: (NSArray<CRSIdentifier *> *) identifiers{
    if(_identifiers == nil){
        _identifiers = [NSMutableArray array];
    }
    [_identifiers addObjectsFromArray:identifiers];
}

- (BOOL) isEqualToTemporalDatum: (CRSTemporalDatum *) temporalDatum{
    if (self == temporalDatum){
        return YES;
    }
    if (temporalDatum == nil){
        return NO;
    }
    if (_name == nil) {
        if (temporalDatum.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:temporalDatum.name]){
        return NO;
    }
    if (_calendar == nil) {
        if (temporalDatum.calendar != nil){
            return NO;
        }
    } else if (![_calendar isEqual:temporalDatum.calendar]){
        return NO;
    }
    if (_origin == nil) {
        if (temporalDatum.origin != nil){
            return NO;
        }
    } else if (![_origin isEqual:temporalDatum.origin]){
        return NO;
    }
    if (_originDateTime == nil) {
        if (temporalDatum.originDateTime != nil){
            return NO;
        }
    } else if (![_originDateTime isEqual:temporalDatum.originDateTime]){
        return NO;
    }
    if (_identifiers == nil) {
        if (temporalDatum.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:temporalDatum.identifiers]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSTemporalDatum class]]) {
        return NO;
    }
    
    return [self isEqualToTemporalDatum:(CRSTemporalDatum *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + ((_calendar == nil) ? 0 : [_calendar hash]);
    result = prime * result + ((_origin == nil) ? 0 : [_origin hash]);
    result = prime * result + ((_originDateTime == nil) ? 0 : [_originDateTime hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeTemporalDatum:self];
    return [writer description];
}

@end
