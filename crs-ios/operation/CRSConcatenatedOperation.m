//
//  CRSConcatenatedOperation.m
//  crs-ios
//
//  Created by Brian Osborn on 7/19/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSConcatenatedOperation.h>

@implementation CRSConcatenatedOperation

+(CRSConcatenatedOperation *) create{
    return [[CRSConcatenatedOperation alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_CONCATENATED_OPERATION];
    if(self != nil){
        _operations = [NSMutableArray array];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andSource: (CRSCoordinateReferenceSystem *) source andTarget: (CRSCoordinateReferenceSystem *) target{
    self = [super initWithName:name andType:CRS_TYPE_CONCATENATED_OPERATION andSource:source];
    if(self != nil){
        _operations = [NSMutableArray array];
        [self setTarget:target];
    }
    return self;
}

-(int) numOperations{
    return _operations != nil ? (int) _operations.count : 0;
}

-(NSObject<CRSCommonOperation> *) operationAtIndex: (int) index{
    return [_operations objectAtIndex:index];
}

-(void) addOperation: (NSObject<CRSCommonOperation> *) operation{
    [_operations addObject:operation];
}

-(void) addOperations: (NSArray<NSObject<CRSCommonOperation> *> *) operations{
    [_operations addObjectsFromArray:operations];
}

- (BOOL) isEqualToConcatenatedOperation: (CRSConcatenatedOperation *) concatenatedOperation{
    if (self == concatenatedOperation){
        return YES;
    }
    if (concatenatedOperation == nil){
        return NO;
    }
    if (![super isEqual:concatenatedOperation]){
        return NO;
    }
    if (_target == nil) {
        if (concatenatedOperation.target != nil){
            return NO;
        }
    } else if (![_target isEqual:concatenatedOperation.target]){
        return NO;
    }
    if (_operations == nil) {
        if (concatenatedOperation.operations != nil){
            return NO;
        }
    } else if (![_operations isEqual:concatenatedOperation.operations]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSConcatenatedOperation class]]) {
        return NO;
    }
    
    return [self isEqualToConcatenatedOperation:(CRSConcatenatedOperation *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_target == nil) ? 0 : [_target hash]);
    result = prime * result + ((_operations == nil) ? 0 : [_operations hash]);
    return result;
}

@end
