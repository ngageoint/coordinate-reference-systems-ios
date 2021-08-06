//
//  CRSGeographicBoundingBox.m
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSGeographicBoundingBox.h"
#import "CRSWriter.h"

@implementation CRSGeographicBoundingBox

+(CRSGeographicBoundingBox *) create{
    return [[CRSGeographicBoundingBox alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithLowerLeftLatitude: (double) lowerLeftLatitude
                    andLowerLeftLongitude: (double) lowerLeftLongitude
                    andUpperRightLatitude: (double) upperRightLatitude
                   andUpperRightLongitude: (double) upperRightLongitude{
    self = [super init];
    if(self != nil){
        [self setLowerLeftLatitude:lowerLeftLatitude];
        [self setLowerLeftLongitude:lowerLeftLongitude];
        [self setUpperRightLatitude:upperRightLatitude];
        [self setUpperRightLongitude:upperRightLongitude];
    }
    return self;
}

- (BOOL) isEqualToGeographicBoundingBox: (CRSGeographicBoundingBox *) geographicBoundingBox{
    if (self == geographicBoundingBox){
        return YES;
    }
    if (geographicBoundingBox == nil){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_lowerLeftLatitude] isEqual:[NSNumber numberWithDouble:geographicBoundingBox.lowerLeftLatitude]]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_lowerLeftLongitude] isEqual:[NSNumber numberWithDouble:geographicBoundingBox.lowerLeftLongitude]]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_upperRightLatitude] isEqual:[NSNumber numberWithDouble:geographicBoundingBox.upperRightLatitude]]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_upperRightLongitude] isEqual:[NSNumber numberWithDouble:geographicBoundingBox.upperRightLongitude]]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSGeographicBoundingBox class]]) {
        return NO;
    }
    
    return [self isEqualToGeographicBoundingBox:(CRSGeographicBoundingBox *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [[NSNumber numberWithDouble:_lowerLeftLatitude] hash];
    result = prime * result + [[NSNumber numberWithDouble:_lowerLeftLongitude] hash];
    result = prime * result + [[NSNumber numberWithDouble:_upperRightLatitude] hash];
    result = prime * result + [[NSNumber numberWithDouble:_upperRightLongitude] hash];
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeGeographicBoundingBox:self];
    return [writer description];
}

@end
