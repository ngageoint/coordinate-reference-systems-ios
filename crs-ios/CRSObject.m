//
//  CRSObject.m
//  crs-ios
//
//  Created by Brian Osborn on 7/12/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSObject.h>
#import <CoordinateReferenceSystems/CRSWriter.h>

@implementation CRSObject

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithType: (CRSType) type{
    self = [super init];
    if(self != nil){
        [self setType:type];
    }
    return self;
}

-(CRSCategoryType) categoryType{
    return [CRSTypes categoryType:_type];
}

-(BOOL) hasExtras{
    return _extras != nil && _extras.count > 0;
}

-(int) numExtras{
    return _extras != nil ? (int) _extras.count : 0;
}

-(NSObject *) extraWithName: (NSString *) name{
    NSObject *extra = nil;
    if([self hasExtras]){
        extra = [_extras objectForKey:name];
    }
    return extra;
}

-(void) addExtra: (NSObject *) extra withName: (NSString *) name{
    if(_extras == nil){
        _extras = [NSMutableDictionary dictionary];
    }
    [_extras setObject:extra forKey:name];
}

-(void) addExtras: (NSMutableDictionary<NSString *, NSObject *> *) extras{
    if(_extras == nil){
        _extras = [NSMutableDictionary dictionary];
    }
    [_extras addEntriesFromDictionary:extras];
}

-(NSString *) name{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(void) setName: (NSString *) name{
    [self doesNotRecognizeSelector:_cmd];
}

-(NSMutableArray<CRSUsage *> *) usages{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(BOOL) hasUsages{
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

-(int) numUsages{
    [self doesNotRecognizeSelector:_cmd];
    return -1;
}

-(CRSUsage *) usageAtIndex: (int) index{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(void) setUsages: (NSArray<CRSUsage *> *) usages{
    [self doesNotRecognizeSelector:_cmd];
}

-(void) addUsage: (CRSUsage *) usage{
    [self doesNotRecognizeSelector:_cmd];
}

-(void) addUsages: (NSArray<CRSUsage *> *) usages{
    [self doesNotRecognizeSelector:_cmd];
}

-(NSMutableArray<CRSIdentifier *> *) identifiers{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(BOOL) hasIdentifiers{
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

-(int) numIdentifiers{
    [self doesNotRecognizeSelector:_cmd];
    return -1;
}

-(CRSIdentifier *) identifierAtIndex: (int) index{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(void) setIdentifiers: (NSArray<CRSIdentifier *> *) identifiers{
    [self doesNotRecognizeSelector:_cmd];
}

-(void) addIdentifier: (CRSIdentifier *) identifier{
    [self doesNotRecognizeSelector:_cmd];
}

-(void) addIdentifiers: (NSArray<CRSIdentifier *> *) identifiers{
    [self doesNotRecognizeSelector:_cmd];
}

-(NSString *) remark{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(BOOL) hasRemark{
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

-(void) setRemark: (NSString *)remark{
    [self doesNotRecognizeSelector:_cmd];
}

- (BOOL) isEqualToObject: (CRSObject *) object{
    if (self == object){
        return YES;
    }
    if (object == nil){
        return NO;
    }
    if(_type != object.type){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSObject class]]) {
        return NO;
    }
    
    return [self isEqualToObject:(CRSObject *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [[NSNumber numberWithInt:_type] hash];
    return result;
}

-(NSString *) description{
    return [CRSWriter write:self];
}

@end
