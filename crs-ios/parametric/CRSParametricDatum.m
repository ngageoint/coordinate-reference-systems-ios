//
//  CRSParametricDatum.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSParametricDatum.h>

@implementation CRSParametricDatum

+(CRSParametricDatum *) create{
    return [[CRSParametricDatum alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_PARAMETRIC];
    return self;
}

-(instancetype) initWithName: (NSString *) name{
    self = [super initWithName:name andType:CRS_TYPE_PARAMETRIC];
    return self;
}

- (BOOL) isEqualToParametricDatum: (CRSParametricDatum *) parametricDatum{
    if (self == parametricDatum){
        return YES;
    }
    if (parametricDatum == nil){
        return NO;
    }
    if (![super isEqual:parametricDatum]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSParametricDatum class]]) {
        return NO;
    }
    
    return [self isEqualToParametricDatum:(CRSParametricDatum *)object];
}

- (NSUInteger) hash{
    return [super hash];
}

@end
