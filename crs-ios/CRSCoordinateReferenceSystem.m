//
//  CRSCoordinateReferenceSystem.m
//  crs-ios
//
//  Created by Brian Osborn on 7/14/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSCoordinateReferenceSystem.h>

@implementation CRSCoordinateReferenceSystem

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithType: (CRSType) type{
    self = [super initWithType:type];
    return self;
}

-(instancetype) initWithName: (NSString *) name andType: (CRSType) type{
    self = [super initWithName:name andType:type];
    return self;
}

- (BOOL) isEqualToCoordinateReferenceSystem: (CRSCoordinateReferenceSystem *) coordinateReferenceSystem{
    if (self == coordinateReferenceSystem){
        return YES;
    }
    if (coordinateReferenceSystem == nil){
        return NO;
    }
    if (![super isEqual:coordinateReferenceSystem]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSCoordinateReferenceSystem class]]) {
        return NO;
    }
    
    return [self isEqualToCoordinateReferenceSystem:(CRSCoordinateReferenceSystem *)object];
}

- (NSUInteger) hash{
    return [super hash];
}

@end
