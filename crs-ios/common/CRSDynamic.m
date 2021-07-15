//
//  CRSDynamic.m
//  crs-ios
//
//  Created by Brian Osborn on 7/15/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSDynamic.h"
#import "CRSWriter.h"

@implementation CRSDynamic

+(CRSDynamic *) create{
    return [[CRSDynamic alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithReferenceEpoch: (double) referenceEpoch{
    self = [super init];
    if(self != nil){
        [self setReferenceEpoch:referenceEpoch];
    }
    return self;
}

-(BOOL) hasDeformationModelName{
    return [self deformationModelName] != nil;
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

- (BOOL) equals: (CRSDynamic *) dynamic{
    if (self == dynamic){
        return YES;
    }
    if (dynamic == nil){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_referenceEpoch] isEqual:[NSNumber numberWithDouble:dynamic.referenceEpoch]]){
        return NO;
    }
    if (_deformationModelName == nil) {
        if (dynamic.deformationModelName != nil){
            return NO;
        }
    } else if (![_deformationModelName isEqualToString:dynamic.deformationModelName]){
        return NO;
    }
    if (_identifiers == nil) {
        if (dynamic.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:dynamic.identifiers]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSDynamic class]]) {
        return NO;
    }
    
    return [self equals:(CRSDynamic *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [[NSNumber numberWithDouble:_referenceEpoch] hash];
    result = prime * result + ((_deformationModelName == nil) ? 0 : [_deformationModelName hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeDynamic:self];
    return [writer description];
}

@end
