//
//  CRSGeoReferenceFrame.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSGeoReferenceFrame.h>

@implementation CRSGeoReferenceFrame

+(CRSGeoReferenceFrame *) create{
    return [[CRSGeoReferenceFrame alloc] init];
}

-(instancetype) init{
    return [self initWithType:CRS_TYPE_GEODETIC];
}

-(instancetype) initWithType: (CRSType) type{
    self = [super initWithType:type];
    return self;
}

-(instancetype) initWithName: (NSString *) name andEllipsoid: (CRSEllipsoid *) ellipsoid{
    return [self initWithName:name andType:CRS_TYPE_GEODETIC andEllipsoid:ellipsoid];
}

-(instancetype) initWithName: (NSString *) name andType: (CRSType) type andEllipsoid: (CRSEllipsoid *) ellipsoid{
    self = [super initWithName:name andType:type];
    if(self != nil){
        [self setEllipsoid:ellipsoid];
    }
    return self;
}

-(BOOL) hasPrimeMeridian{
    return [self primeMeridian] != nil;
}

- (BOOL) isEqualToGeoReferenceFrame: (CRSGeoReferenceFrame *) geoReferenceFrame{
    if (self == geoReferenceFrame){
        return YES;
    }
    if (geoReferenceFrame == nil){
        return NO;
    }
    if (![super isEqual:geoReferenceFrame]){
        return NO;
    }
    if (_ellipsoid == nil) {
        if (geoReferenceFrame.ellipsoid != nil){
            return NO;
        }
    } else if (![_ellipsoid isEqual:geoReferenceFrame.ellipsoid]){
        return NO;
    }
    if (_primeMeridian == nil) {
        if (geoReferenceFrame.primeMeridian != nil){
            return NO;
        }
    } else if (![_primeMeridian isEqual:geoReferenceFrame.primeMeridian]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSGeoReferenceFrame class]]) {
        return NO;
    }
    
    return [self isEqualToGeoReferenceFrame:(CRSGeoReferenceFrame *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_ellipsoid == nil) ? 0 : [_ellipsoid hash]);
    result = prime * result + ((_primeMeridian == nil) ? 0 : [_primeMeridian hash]);
    return result;
}

@end
