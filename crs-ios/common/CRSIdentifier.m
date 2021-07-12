//
//  CRSIdentifier.m
//  crs-ios
//
//  Created by Brian Osborn on 7/12/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSIdentifier.h"

@implementation CRSIdentifier

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

- (BOOL)equals:(CRSIdentifier *)identifier {
    if (self == identifier)
        return YES;
    if (identifier == nil)
        return NO;
    if (![self.name isEqualToString:identifier.name])
        return NO;
    if (![self.uniqueIdentifier isEqualToString:identifier.uniqueIdentifier])
        return NO;
    if (![self.version isEqualToString:identifier.version])
        return NO;
    if (![self.citation isEqualToString:identifier.citation])
        return NO;
    if (![self.uri isEqualToString:identifier.uri])
        return NO;
    return YES;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSIdentifier class]]) {
        return NO;
    }
    
    return [self equals:(CRSIdentifier *)object];
}

- (NSUInteger)hash {
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((self.name == nil) ? 0 : [self.name hash]);
    result = prime * result + ((self.uniqueIdentifier == nil) ? 0 : [self.uniqueIdentifier hash]);
    result = prime * result + ((self.version == nil) ? 0 : [self.version hash]);
    result = prime * result + ((self.citation == nil) ? 0 : [self.citation hash]);
    result = prime * result + ((self.uri == nil) ? 0 : [self.uri hash]);
    return result;
}

-(NSString *) description{
    NSString *value = nil;
    // TODO
    return value;
}

@end
