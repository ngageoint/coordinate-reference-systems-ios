//
//  CRSGeographicBoundingBox.m
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSGeographicBoundingBox.h>
#import <CoordinateReferenceSystems/CRSWriter.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>

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

-(instancetype) initWithLowerLeftLatitudeText: (NSString *) lowerLeftLatitude
                    andLowerLeftLongitudeText: (NSString *) lowerLeftLongitude
                    andUpperRightLatitudeText: (NSString *) upperRightLatitude
                   andUpperRightLongitudeText: (NSString *) upperRightLongitude{
    self = [super init];
    if(self != nil){
        [self setLowerLeftLatitudeText:lowerLeftLatitude];
        [self setLowerLeftLongitudeText:lowerLeftLongitude];
        [self setUpperRightLatitudeText:upperRightLatitude];
        [self setUpperRightLongitudeText:upperRightLongitude];
    }
    return self;
}

-(void) setLowerLeftLatitude: (double) lowerLeftLatitude{
    _lowerLeftLatitude = lowerLeftLatitude;
    _lowerLeftLatitudeText = [CRSTextUtils textFromDouble:lowerLeftLatitude];
}

-(void) setLowerLeftLatitudeText: (NSString *) lowerLeftLatitudeText{
    _lowerLeftLatitudeText = lowerLeftLatitudeText;
    _lowerLeftLatitude = [CRSTextUtils doubleFromString:lowerLeftLatitudeText];
}

-(void) setLowerLeftLongitude: (double) lowerLeftLongitude{
    _lowerLeftLongitude = lowerLeftLongitude;
    _lowerLeftLongitudeText = [CRSTextUtils textFromDouble:lowerLeftLongitude];
}

-(void) setLowerLeftLongitudeText: (NSString *) lowerLeftLongitudeText{
    _lowerLeftLongitudeText = lowerLeftLongitudeText;
    _lowerLeftLongitude = [CRSTextUtils doubleFromString:lowerLeftLongitudeText];
}

-(void) setUpperRightLatitude: (double) upperRightLatitude{
    _upperRightLatitude = upperRightLatitude;
    _upperRightLatitudeText = [CRSTextUtils textFromDouble:upperRightLatitude];
}

-(void) setUpperRightLatitudeText: (NSString *) upperRightLatitudeText{
    _upperRightLatitudeText = upperRightLatitudeText;
    _upperRightLatitude = [CRSTextUtils doubleFromString:upperRightLatitudeText];
}

-(void) setUpperRightLongitude: (double) upperRightLongitude{
    _upperRightLongitude = upperRightLongitude;
    _upperRightLongitudeText = [CRSTextUtils textFromDouble:upperRightLongitude];
}

-(void) setUpperRightLongitudeText: (NSString *) upperRightLongitudeText{
    _upperRightLongitudeText = upperRightLongitudeText;
    _upperRightLongitude = [CRSTextUtils doubleFromString:upperRightLongitudeText];
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
