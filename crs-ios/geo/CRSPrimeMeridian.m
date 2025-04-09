//
//  CRSPrimeMeridian.m
//  crs-ios
//
//  Created by Brian Osborn on 7/21/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSPrimeMeridian.h>
#import <CoordinateReferenceSystems/CRSWriter.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>

@implementation CRSPrimeMeridian

+(CRSPrimeMeridian *) create{
    return [[CRSPrimeMeridian alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithName: (NSString *) name andLongitude: (double) longitude{
    self = [super init];
    if(self != nil){
        [self setName:name];
        [self setLongitude:longitude];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andLongitudeText: (NSString *) longitude{
    self = [super init];
    if(self != nil){
        [self setName:name];
        [self setLongitudeText:longitude];
    }
    return self;
}

-(void) setLongitude: (double) longitude{
    _longitude = longitude;
    _longitudeText = [CRSTextUtils textFromDouble:longitude];
}

-(void) setLongitudeText: (NSString *) longitudeText{
    _longitudeText = longitudeText;
    _longitude = [CRSTextUtils doubleFromString:longitudeText];
}

-(BOOL) hasLongitudeUnit{
    return [self longitudeUnit] != nil;
}

-(BOOL) hasIdentifiers{
    return _identifiers != nil && _identifiers.count > 0;
}

-(int) numIdentifiers{
    return _identifiers != nil ? (int) _identifiers.count : 0;
}

-(CRSIdentifier *) identifierAtIndex: (int) index{
    return [_identifiers objectAtIndex:index];
}

-(void) addIdentifier: (CRSIdentifier *) identifier{
    if(_identifiers == nil){
        _identifiers = [NSMutableArray array];
    }
    [_identifiers addObject:identifier];
}

-(void) addIdentifiers: (NSArray<CRSIdentifier *> *) identifiers{
    if(_identifiers == nil){
        _identifiers = [NSMutableArray array];
    }
    [_identifiers addObjectsFromArray:identifiers];
}

- (BOOL) isEqualToPrimeMeridian: (CRSPrimeMeridian *) primeMeridian{
    if (self == primeMeridian){
        return YES;
    }
    if (primeMeridian == nil){
        return NO;
    }
    if (_name == nil) {
        if (primeMeridian.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:primeMeridian.name]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_longitude] isEqual:[NSNumber numberWithDouble:primeMeridian.longitude]]){
        return NO;
    }
    if (_longitudeUnit == nil) {
        if (primeMeridian.longitudeUnit != nil){
            return NO;
        }
    } else if (![_longitudeUnit isEqual:primeMeridian.longitudeUnit]){
        return NO;
    }
    if (_identifiers == nil) {
        if (primeMeridian.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:primeMeridian.identifiers]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSPrimeMeridian class]]) {
        return NO;
    }
    
    return [self isEqualToPrimeMeridian:(CRSPrimeMeridian *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + [[NSNumber numberWithDouble:_longitude] hash];
    result = prime * result + ((_longitudeUnit == nil) ? 0 : [_longitudeUnit hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writePrimeMeridian:self];
    return [writer description];
}

@end
