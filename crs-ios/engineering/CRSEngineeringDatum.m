//
//  CRSEngineeringDatum.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSEngineeringDatum.h>

@implementation CRSEngineeringDatum

+(CRSEngineeringDatum *) create{
    return [[CRSEngineeringDatum alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_ENGINEERING];
    return self;
}

-(instancetype) initWithName: (NSString *) name{
    self = [super initWithName:name andType:CRS_TYPE_ENGINEERING];
    return self;
}

- (BOOL) isEqualToEngineeringDatum: (CRSEngineeringDatum *) engineeringDatum{
    if (self == engineeringDatum){
        return YES;
    }
    if (engineeringDatum == nil){
        return NO;
    }
    if (![super isEqual:engineeringDatum]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSEngineeringDatum class]]) {
        return NO;
    }
    
    return [self isEqualToEngineeringDatum:(CRSEngineeringDatum *)object];
}

- (NSUInteger) hash{
    return [super hash];
}

@end
