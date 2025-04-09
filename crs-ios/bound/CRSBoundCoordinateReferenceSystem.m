//
//  CRSBoundCoordinateReferenceSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/19/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSBoundCoordinateReferenceSystem.h>

@implementation CRSBoundCoordinateReferenceSystem

+(CRSBoundCoordinateReferenceSystem *) create{
    return [[CRSBoundCoordinateReferenceSystem alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_BOUND];
    return self;
}

-(instancetype) initWithSource: (CRSCoordinateReferenceSystem *) source andTarget: (CRSCoordinateReferenceSystem *) target andTransformation: (CRSAbridgedCoordinateTransformation *) transformation{
    self = [super initWithType:CRS_TYPE_BOUND];
    if(self != nil){
        [self setSource:source];
        [self setTarget:target];
        [self setTransformation:transformation];
    }
    return self;
}

-(NSString *) name{
    return nil;
}

-(void) setName: (NSString *) name{
    [NSException raise:@"Not Supported" format:@"Bound CRS does not support name"];
}

- (BOOL) isEqualToBoundCoordinateReferenceSystem: (CRSBoundCoordinateReferenceSystem *) boundCoordinateReferenceSystem{
    if (self == boundCoordinateReferenceSystem){
        return YES;
    }
    if (boundCoordinateReferenceSystem == nil){
        return NO;
    }
    if (![super isEqual:boundCoordinateReferenceSystem]){
        return NO;
    }
    if (_source == nil) {
        if (boundCoordinateReferenceSystem.source != nil){
            return NO;
        }
    } else if (![_source isEqual:boundCoordinateReferenceSystem.source]){
        return NO;
    }
    if (_target == nil) {
        if (boundCoordinateReferenceSystem.target != nil){
            return NO;
        }
    } else if (![_target isEqual:boundCoordinateReferenceSystem.target]){
        return NO;
    }
    if (_transformation == nil) {
        if (boundCoordinateReferenceSystem.transformation != nil){
            return NO;
        }
    } else if (![_transformation isEqual:boundCoordinateReferenceSystem.transformation]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSBoundCoordinateReferenceSystem class]]) {
        return NO;
    }
    
    return [self isEqualToBoundCoordinateReferenceSystem:(CRSBoundCoordinateReferenceSystem *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_source == nil) ? 0 : [_source hash]);
    result = prime * result + ((_target == nil) ? 0 : [_target hash]);
    result = prime * result + ((_transformation == nil) ? 0 : [_transformation hash]);
    return result;
}

@end
