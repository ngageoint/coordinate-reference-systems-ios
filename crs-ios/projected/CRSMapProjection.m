//
//  CRSMapProjection.m
//  crs-ios
//
//  Created by Brian Osborn on 7/20/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSMapProjection.h>
#import <CoordinateReferenceSystems/CRSWriter.h>

@implementation CRSMapProjection

+(CRSMapProjection *) create{
    return [[CRSMapProjection alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithName: (NSString *) name andMethod: (CRSOperationMethod *) method{
    self = [super init];
    if(self != nil){
        [self setName:name];
        [self setMethod:method];
    }
    return self;
}

-(CRSOperationType) operationType{
    return CRS_OPERATION_MAP_PROJECTION;
}

-(NSString *) version{
    return nil;
}

-(BOOL) hasVersion{
    return NO;
}

-(void) setVersion: (NSString *) version{
    [NSException raise:@"Not Supported" format:@"Map Projection does not support version"];
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

- (BOOL) isEqualToMapProjection: (CRSMapProjection *) mapProjection{
    if (self == mapProjection){
        return YES;
    }
    if (mapProjection == nil){
        return NO;
    }
    if (_name == nil) {
        if (mapProjection.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:mapProjection.name]){
        return NO;
    }
    if (_method == nil) {
        if (mapProjection.method != nil){
            return NO;
        }
    } else if (![_method isEqual:mapProjection.method]){
        return NO;
    }
    if (_identifiers == nil) {
        if (mapProjection.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:mapProjection.identifiers]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSMapProjection class]]) {
        return NO;
    }
    
    return [self isEqualToMapProjection:(CRSMapProjection *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + ((_method == nil) ? 0 : [_method hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeMapProjection:self];
    return [writer description];
}

@end
