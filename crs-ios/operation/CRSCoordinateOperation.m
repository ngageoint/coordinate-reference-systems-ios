//
//  CRSCoordinateOperation.m
//  crs-ios
//
//  Created by Brian Osborn on 7/19/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSCoordinateOperation.h>

@implementation CRSCoordinateOperation

+(CRSCoordinateOperation *) create{
    return [[CRSCoordinateOperation alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_COORDINATE_OPERATION];
    return self;
}

-(instancetype) initWithName: (NSString *) name andSource: (CRSCoordinateReferenceSystem *) source andTarget: (CRSCoordinateReferenceSystem *) target andMethod: (CRSOperationMethod *) method{
    self = [super initWithName:name andType:CRS_TYPE_COORDINATE_OPERATION andSource:source andMethod:method];
    if(self != nil){
        [self setTarget:target];
    }
    return self;
}

-(CRSOperationType) operationType{
    return CRS_OPERATION_COORDINATE;
}

-(BOOL) hasInterpolation{
    return [self interpolation] != nil;
}

- (BOOL) isEqualToCoordinateOperation: (CRSCoordinateOperation *) coordinateOperation{
    if (self == coordinateOperation){
        return YES;
    }
    if (coordinateOperation == nil){
        return NO;
    }
    if (![super isEqual:coordinateOperation]){
        return NO;
    }
    if (_target == nil) {
        if (coordinateOperation.target != nil){
            return NO;
        }
    } else if (![_target isEqual:coordinateOperation.target]){
        return NO;
    }
    if (_interpolation == nil) {
        if (coordinateOperation.interpolation != nil){
            return NO;
        }
    } else if (![_interpolation isEqual:coordinateOperation.interpolation]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSCoordinateOperation class]]) {
        return NO;
    }
    
    return [self isEqualToCoordinateOperation:(CRSCoordinateOperation *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_target == nil) ? 0 : [_target hash]);
    result = prime * result + ((_interpolation == nil) ? 0 : [_interpolation hash]);
    return result;
}

@end
