//
//  CRSDatumEnsembleMember.m
//  crs-ios
//
//  Created by Brian Osborn on 7/15/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSDatumEnsembleMember.h>
#import <CoordinateReferenceSystems/CRSWriter.h>

@implementation CRSDatumEnsembleMember

+(CRSDatumEnsembleMember *) create{
    return [[CRSDatumEnsembleMember alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithName: (NSString *) name{
    self = [super init];
    if(self != nil){
        [self setName:name];
    }
    return self;
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

- (BOOL) isEqualToDatumEnsembleMember: (CRSDatumEnsembleMember *) datumEnsembleMember{
    if (self == datumEnsembleMember){
        return YES;
    }
    if (datumEnsembleMember == nil){
        return NO;
    }
    if (_name == nil) {
        if (datumEnsembleMember.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:datumEnsembleMember.name]){
        return NO;
    }
    if (_identifiers == nil) {
        if (datumEnsembleMember.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:datumEnsembleMember.identifiers]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSDatumEnsembleMember class]]) {
        return NO;
    }
    
    return [self isEqualToDatumEnsembleMember:(CRSDatumEnsembleMember *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeDatumEnsembleMember:self];
    return [writer description];
}

@end
