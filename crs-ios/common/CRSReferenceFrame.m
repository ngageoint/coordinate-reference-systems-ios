//
//  CRSReferenceFrame.m
//  crs-ios
//
//  Created by Brian Osborn on 7/15/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSReferenceFrame.h>
#import <CoordinateReferenceSystems/CRSWriter.h>

@implementation CRSReferenceFrame

-(instancetype) initWithType: (CRSType) type{
    self = [super init];
    if(self != nil){
        [self setType:type];
    }
    return self;
}

-(instancetype) initWithName: (NSString *) name andType: (CRSType) type{
    self = [super init];
    if(self != nil){
        [self setName:name];
        [self setType:type];
    }
    return self;
}

-(BOOL) hasAnchor{
    return [self anchor] != nil;
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

- (BOOL) isEqualToReferenceFrame: (CRSReferenceFrame *) referenceFrame{
    if (self == referenceFrame){
        return YES;
    }
    if (referenceFrame == nil){
        return NO;
    }
    if (_name == nil) {
        if (referenceFrame.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:referenceFrame.name]){
        return NO;
    }
    if(_type != referenceFrame.type){
        return NO;
    }
    if (_anchor == nil) {
        if (referenceFrame.anchor != nil){
            return NO;
        }
    } else if (![_anchor isEqualToString:referenceFrame.anchor]){
        return NO;
    }
    if (_identifiers == nil) {
        if (referenceFrame.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:referenceFrame.identifiers]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSReferenceFrame class]]) {
        return NO;
    }
    
    return [self isEqualToReferenceFrame:(CRSReferenceFrame *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + [[NSNumber numberWithInt:_type] hash];
    result = prime * result + ((_anchor == nil) ? 0 : [_anchor hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeReferenceFrame:self];
    return [writer description];
}

@end
