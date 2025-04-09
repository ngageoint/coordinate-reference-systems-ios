//
//  CRSGeoDatumEnsemble.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSGeoDatumEnsemble.h>

@implementation CRSGeoDatumEnsemble

+(CRSGeoDatumEnsemble *) create{
    return [[CRSGeoDatumEnsemble alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithName: (NSString *) name andMember: (CRSDatumEnsembleMember *) member andEllipsoid: (CRSEllipsoid *) ellipsoid andAccuracy: (double) accuracy andPrimeMeridian: (CRSPrimeMeridian *) primeMeridian{
    self = [super initWithName:name andMember:member andAccuracy:accuracy];
    if(self != nil){
        [self setEllipsoid:ellipsoid];
        [self setPrimeMeridian:primeMeridian];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andMembers: (NSArray<CRSDatumEnsembleMember *> *) members andEllipsoid: (CRSEllipsoid *) ellipsoid andAccuracy: (double) accuracy andPrimeMeridian: (CRSPrimeMeridian *) primeMeridian{
    self = [super initWithName:name andMembers:members andAccuracy:accuracy];
    if(self != nil){
        [self setEllipsoid:ellipsoid];
        [self setPrimeMeridian:primeMeridian];
    }
    return self;
}

-(BOOL) hasPrimeMeridian{
    return [self primeMeridian] != nil;
}

- (BOOL) isEqualToGeoDatumEnsemble: (CRSGeoDatumEnsemble *) geoDatumEnsemble{
    if (self == geoDatumEnsemble){
        return YES;
    }
    if (geoDatumEnsemble == nil){
        return NO;
    }
    if (![super isEqual:geoDatumEnsemble]){
        return NO;
    }
    if (_ellipsoid == nil) {
        if (geoDatumEnsemble.ellipsoid != nil){
            return NO;
        }
    } else if (![_ellipsoid isEqual:geoDatumEnsemble.ellipsoid]){
        return NO;
    }
    if (_primeMeridian == nil) {
        if (geoDatumEnsemble.primeMeridian != nil){
            return NO;
        }
    } else if (![_primeMeridian isEqual:geoDatumEnsemble.primeMeridian]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSGeoDatumEnsemble class]]) {
        return NO;
    }
    
    return [self isEqualToGeoDatumEnsemble:(CRSGeoDatumEnsemble *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_ellipsoid == nil) ? 0 : [_ellipsoid hash]);
    result = prime * result + ((_primeMeridian == nil) ? 0 : [_primeMeridian hash]);
    return result;
}

@end
