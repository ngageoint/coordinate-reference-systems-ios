//
//  CRSIdentifier.m
//  crs-ios
//
//  Created by Brian Osborn on 7/12/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSIdentifier.h>
#import <CoordinateReferenceSystems/CRSWriter.h>

@implementation CRSIdentifier

+(CRSIdentifier *) create{
    return [[CRSIdentifier alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithName: (NSString *) name andUniqueIdentifier: (NSString *) uniqueIdentifier{
    self = [super init];
    if(self != nil){
        [self setName:name];
        [self setUniqueIdentifier:uniqueIdentifier];
    }
    return self;
}

-(NSString *) nameAndUniqueIdentifier{
    return [self nameAndUniqueIdentifierWithDelimiter:@":"];
}

-(NSString *) nameAndUniqueIdentifierWithDelimiter: (NSString *) delimiter{
    return [NSString stringWithFormat:@"%@%@%@", [self name], delimiter, [self uniqueIdentifier]];
}

-(BOOL) hasVersion{
    return [self version] != nil;
}

-(BOOL) hasCitation{
    return [self citation] != nil;
}

-(BOOL) hasUri{
    return [self uri] != nil;
}

- (BOOL) isEqualToIdentifier: (CRSIdentifier *) identifier{
    if (self == identifier){
        return YES;
    }
    if (identifier == nil){
        return NO;
    }
    if (_name == nil) {
        if (identifier.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:identifier.name]){
        return NO;
    }
    if (_uniqueIdentifier == nil) {
        if (identifier.uniqueIdentifier != nil){
            return NO;
        }
    } else if (![_uniqueIdentifier isEqualToString:identifier.uniqueIdentifier]){
        return NO;
    }
    if (_version == nil) {
        if (identifier.version != nil){
            return NO;
        }
    } else if (![_version isEqualToString:identifier.version]){
        return NO;
    }
    if (_citation == nil) {
        if (identifier.citation != nil){
            return NO;
        }
    } else if (![_citation isEqualToString:identifier.citation]){
        return NO;
    }
    if (_uri == nil) {
        if (identifier.uri != nil){
            return NO;
        }
    } else if (![_uri isEqualToString:identifier.uri]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSIdentifier class]]) {
        return NO;
    }
    
    return [self isEqualToIdentifier:(CRSIdentifier *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + ((_uniqueIdentifier == nil) ? 0 : [_uniqueIdentifier hash]);
    result = prime * result + ((_version == nil) ? 0 : [_version hash]);
    result = prime * result + ((_citation == nil) ? 0 : [_citation hash]);
    result = prime * result + ((_uri == nil) ? 0 : [_uri hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeIdentifier:self];
    return [writer description];
}

@end
