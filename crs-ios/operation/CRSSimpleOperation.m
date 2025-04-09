//
//  CRSSimpleOperation.m
//  crs-ios
//
//  Created by Brian Osborn on 7/19/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSSimpleOperation.h>

@implementation CRSSimpleOperation

-(instancetype) initWithType: (CRSType) type{
    self = [super initWithType:type];
    return self;
}

-(instancetype) initWithName: (NSString *) name andType: (CRSType) type andSource: (CRSCoordinateReferenceSystem *) source andMethod: (CRSOperationMethod *) method{
    self = [super initWithName:name andType:type andSource:source];
    if(self != nil){
        [self setMethod:method];
    }
    return self;
}

-(CRSOperationType) operationType{
    [self doesNotRecognizeSelector:_cmd];
    return -1;
}

- (BOOL) isEqualToSimpleOperation: (CRSSimpleOperation *) simpleOperation{
    if (self == simpleOperation){
        return YES;
    }
    if (simpleOperation == nil){
        return NO;
    }
    if (![super isEqual:simpleOperation]){
        return NO;
    }
    if (_method == nil) {
        if (simpleOperation.method != nil){
            return NO;
        }
    } else if (![_method isEqual:simpleOperation.method]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSSimpleOperation class]]) {
        return NO;
    }
    
    return [self isEqualToSimpleOperation:(CRSSimpleOperation *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_method == nil) ? 0 : [_method hash]);
    return result;
}

@end
