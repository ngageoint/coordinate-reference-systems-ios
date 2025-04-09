//
//  CRSCommon.m
//  crs-ios
//
//  Created by Brian Osborn on 7/14/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSCommon.h>

@implementation CRSCommon

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithType: (CRSType) type{
    self = [super initWithType:type];
    return self;
}

-(instancetype) initWithName: (NSString *) name andType: (CRSType) type{
    self = [super initWithType:type];
    if(self != nil){
        [self setName:name];
    }
    return self;
}

-(BOOL) hasUsages{
    return _usages != nil && _usages.count > 0;
}

-(int) numUsages{
    return _usages != nil ? (int) _usages.count : 0;
}

-(CRSUsage *) usageAtIndex: (int) index{
    return [_usages objectAtIndex:index];
}

-(void) addUsage: (CRSUsage *) usage{
    if(_usages == nil){
        _usages = [NSMutableArray array];
    }
    [_usages addObject:usage];
}

-(void) addUsages: (NSArray<CRSUsage *> *) usages{
    if(_usages == nil){
        _usages = [NSMutableArray array];
    }
    [_usages addObjectsFromArray:usages];
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

-(BOOL) hasRemark{
    return [self remark] != nil;
}

- (BOOL) isEqualToCommon: (CRSCommon *) common{
    if (self == common){
        return YES;
    }
    if (common == nil){
        return NO;
    }
    if (![super isEqual:common]){
        return NO;
    }
    if (_name == nil) {
        if (common.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:common.name]){
        return NO;
    }
    if (_usages == nil) {
        if (common.usages != nil){
            return NO;
        }
    } else if (![_usages isEqual:common.usages]){
        return NO;
    }
    if (_identifiers == nil) {
        if (common.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:common.identifiers]){
        return NO;
    }
    if (_remark == nil) {
        if (common.remark != nil){
            return NO;
        }
    } else if (![_remark isEqualToString:common.remark]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSCommon class]]) {
        return NO;
    }
    
    return [self isEqualToCommon:(CRSCommon *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + ((_usages == nil) ? 0 : [_usages hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    result = prime * result + ((_remark == nil) ? 0 : [_remark hash]);
    return result;
}

@end
