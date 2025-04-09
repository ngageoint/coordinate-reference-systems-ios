//
//  CRSDatumEnsemble.m
//  crs-ios
//
//  Created by Brian Osborn on 7/15/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSDatumEnsemble.h>
#import <CoordinateReferenceSystems/CRSWriter.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>

@implementation CRSDatumEnsemble

-(instancetype) init{
    self = [super init];
    if(self != nil){
        _members = [NSMutableArray array];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andMember: (CRSDatumEnsembleMember *) member andAccuracy: (double) accuracy{
    self = [self init];
    if(self != nil){
        [self setName:name];
        [self addMember:member];
        [self setAccuracy:accuracy];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andMember: (CRSDatumEnsembleMember *) member andAccuracyText: (NSString *) accuracy{
    self = [self init];
    if(self != nil){
        [self setName:name];
        [self addMember:member];
        [self setAccuracyText:accuracy];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andMembers: (NSArray<CRSDatumEnsembleMember *> *) members andAccuracy: (double) accuracy{
    self = [self init];
    if(self != nil){
        [self setName:name];
        [self addMembers:members];
        [self setAccuracy:accuracy];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andMembers: (NSArray<CRSDatumEnsembleMember *> *) members andAccuracyText: (NSString *) accuracy{
    self = [self init];
    if(self != nil){
        [self setName:name];
        [self addMembers:members];
        [self setAccuracyText:accuracy];
    }
    return self;
}

-(int) numMembers{
    return (int) _members.count;
}

-(CRSDatumEnsembleMember *) memberAtIndex: (int) index{
    return [_members objectAtIndex:index];
}

-(void) addMember: (CRSDatumEnsembleMember *) member{
    [_members addObject:member];
}

-(void) addMembers: (NSArray<CRSDatumEnsembleMember *> *) members{
    [_members addObjectsFromArray:members];
}

-(void) setAccuracy: (double) accuracy{
    _accuracy = accuracy;
    _accuracyText = [CRSTextUtils textFromDouble:accuracy];
}

-(void) setAccuracyText: (NSString *) accuracyText{
    _accuracyText = accuracyText;
    _accuracy = [CRSTextUtils doubleFromString:accuracyText];
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

- (BOOL) isEqualToDatumEnsemble: (CRSDatumEnsemble *) datumEnsemble{
    if (self == datumEnsemble){
        return YES;
    }
    if (datumEnsemble == nil){
        return NO;
    }
    if (_name == nil) {
        if (datumEnsemble.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:datumEnsemble.name]){
        return NO;
    }
    if (_members == nil) {
        if (datumEnsemble.members != nil){
            return NO;
        }
    } else if (![_members isEqual:datumEnsemble.members]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_accuracy] isEqual:[NSNumber numberWithDouble:datumEnsemble.accuracy]]){
        return NO;
    }
    if (_identifiers == nil) {
        if (datumEnsemble.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:datumEnsemble.identifiers]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSDatumEnsemble class]]) {
        return NO;
    }
    
    return [self isEqualToDatumEnsemble:(CRSDatumEnsemble *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + ((_members == nil) ? 0 : [_members hash]);
    result = prime * result + [[NSNumber numberWithDouble:_accuracy] hash];
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeDatumEnsemble:self];
    return [writer description];
}

@end
