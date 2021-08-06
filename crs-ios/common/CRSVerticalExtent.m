//
//  CRSVerticalExtent.m
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSVerticalExtent.h"
#import "CRSWriter.h"

@implementation CRSVerticalExtent

+(CRSVerticalExtent *) create{
    return [[CRSVerticalExtent alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithMinimumHeight: (double) minimumHeight andMaximumHeight: (double) maximumHeight{
    return [self initWithMinimumHeight:minimumHeight andMaximumHeight:maximumHeight andUnit:nil];
}

-(instancetype) initWithMinimumHeight: (double) minimumHeight andMaximumHeight: (double) maximumHeight andUnit: (CRSUnit *) unit{
    self = [super init];
    if(self != nil){
        [self setMinimumHeight:minimumHeight];
        [self setMaximumHeight:maximumHeight];
        [self setUnit:unit];
    }
    return self;
}

-(BOOL) hasUnit{
    return [self unit] != nil;
}

- (BOOL) isEqualToVerticalExtent: (CRSVerticalExtent *) verticalExtent{
    if (self == verticalExtent){
        return YES;
    }
    if (verticalExtent == nil){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_minimumHeight] isEqual:[NSNumber numberWithDouble:verticalExtent.minimumHeight]]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_maximumHeight] isEqual:[NSNumber numberWithDouble:verticalExtent.maximumHeight]]){
        return NO;
    }
    if (_unit == nil) {
        if (verticalExtent.unit != nil){
            return NO;
        }
    } else if (![_unit isEqual:verticalExtent.unit]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSVerticalExtent class]]) {
        return NO;
    }
    
    return [self isEqualToVerticalExtent:(CRSVerticalExtent *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [[NSNumber numberWithDouble:_minimumHeight] hash];
    result = prime * result + [[NSNumber numberWithDouble:_maximumHeight] hash];
    result = prime * result + ((_unit == nil) ? 0 : [_unit hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeVerticalExtent:self];
    return [writer description];
}

@end
