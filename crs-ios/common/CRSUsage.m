//
//  CRSUsage.m
//  crs-ios
//
//  Created by Brian Osborn on 7/14/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSUsage.h>
#import <CoordinateReferenceSystems/CRSWriter.h>

@implementation CRSUsage

+(CRSUsage *) create{
    return [[CRSUsage alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithScope: (NSString *) scope andExtent: (CRSExtent *) extent{
    self = [super init];
    if(self != nil){
        [self setScope:scope];
        [self setExtent:extent];
    }
    return self;
}

- (BOOL) isEqualToUsage: (CRSUsage *) usage{
    if (self == usage){
        return YES;
    }
    if (usage == nil){
        return NO;
    }
    if (_scope == nil) {
        if (usage.scope != nil){
            return NO;
        }
    } else if (![_scope isEqualToString:usage.scope]){
        return NO;
    }
    if (_extent == nil) {
        if (usage.extent != nil){
            return NO;
        }
    } else if (![_extent isEqual:usage.extent]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSUsage class]]) {
        return NO;
    }
    
    return [self isEqualToUsage:(CRSUsage *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_scope == nil) ? 0 : [_scope hash]);
    result = prime * result + ((_extent == nil) ? 0 : [_extent hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeUsage:self];
    return [writer description];
}

@end
