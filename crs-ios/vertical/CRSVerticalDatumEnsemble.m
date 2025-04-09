//
//  CRSVerticalDatumEnsemble.m
//  crs-ios
//
//  Created by Brian Osborn on 7/21/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSVerticalDatumEnsemble.h>

@implementation CRSVerticalDatumEnsemble

+(CRSVerticalDatumEnsemble *) create{
    return [[CRSVerticalDatumEnsemble alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithName: (NSString *) name andMember: (CRSDatumEnsembleMember *) member andAccuracy: (double) accuracy{
    self = [super initWithName:name andMember:member andAccuracy:accuracy];
    return self;
}

-(instancetype) initWithName: (NSString *) name andMembers: (NSArray<CRSDatumEnsembleMember *> *) members andAccuracy: (double) accuracy{
    self = [super initWithName:name andMembers:members andAccuracy:accuracy];
    return self;
}

- (BOOL) isEqualToVerticalDatumEnsemble: (CRSVerticalDatumEnsemble *) verticalDatumEnsemble{
    if (self == verticalDatumEnsemble){
        return YES;
    }
    if (verticalDatumEnsemble == nil){
        return NO;
    }
    if (![super isEqual:verticalDatumEnsemble]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSVerticalDatumEnsemble class]]) {
        return NO;
    }
    
    return [self isEqualToVerticalDatumEnsemble:(CRSVerticalDatumEnsemble *)object];
}

- (NSUInteger) hash{
    return [super hash];
}

@end
