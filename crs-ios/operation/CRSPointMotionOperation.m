//
//  CRSPointMotionOperation.m
//  crs-ios
//
//  Created by Brian Osborn on 7/19/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSPointMotionOperation.h>

@implementation CRSPointMotionOperation

+(CRSPointMotionOperation *) create{
    return [[CRSPointMotionOperation alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_POINT_MOTION_OPERATION];
    return self;
}

-(instancetype) initWithName: (NSString *) name andSource: (CRSCoordinateReferenceSystem *) source andMethod: (CRSOperationMethod *) method{
    self = [super initWithName:name andType:CRS_TYPE_POINT_MOTION_OPERATION andSource:source andMethod:method];
    return self;
}

-(CRSOperationType) operationType{
    return CRS_OPERATION_POINT_MOTION;
}

- (BOOL) isEqualToPointMotionOperation: (CRSPointMotionOperation *) pointMotionOperation{
    if (self == pointMotionOperation){
        return YES;
    }
    if (pointMotionOperation == nil){
        return NO;
    }
    if (![super isEqual:pointMotionOperation]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSPointMotionOperation class]]) {
        return NO;
    }
    
    return [self isEqualToPointMotionOperation:(CRSPointMotionOperation *)object];
}

- (NSUInteger) hash{
    return [super hash];
}

@end
