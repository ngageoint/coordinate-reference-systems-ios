//
//  CRSAbridgedCoordinateTransformation.m
//  crs-ios
//
//  Created by Brian Osborn on 7/19/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSAbridgedCoordinateTransformation.h>
#import <CoordinateReferenceSystems/CRSWriter.h>

@implementation CRSAbridgedCoordinateTransformation

+(CRSAbridgedCoordinateTransformation *) create{
    return [[CRSAbridgedCoordinateTransformation alloc] init];
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
    return CRS_OPERATION_ABRIDGED_COORDINATE_TRANSFORMATION;
}

-(BOOL) hasVersion{
    return [self version] != nil;
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

- (BOOL) isEqualToAbridgedCoordinateTransformation: (CRSAbridgedCoordinateTransformation *) abridgedCoordinateTransformation{
    if (self == abridgedCoordinateTransformation){
        return YES;
    }
    if (abridgedCoordinateTransformation == nil){
        return NO;
    }
    if (_name == nil) {
        if (abridgedCoordinateTransformation.name != nil){
            return NO;
        }
    } else if (![_name isEqualToString:abridgedCoordinateTransformation.name]){
        return NO;
    }
    if (_version == nil) {
        if (abridgedCoordinateTransformation.version != nil){
            return NO;
        }
    } else if (![_version isEqualToString:abridgedCoordinateTransformation.version]){
        return NO;
    }
    if (_method == nil) {
        if (abridgedCoordinateTransformation.method != nil){
            return NO;
        }
    } else if (![_method isEqual:abridgedCoordinateTransformation.method]){
        return NO;
    }
    if (_usages == nil) {
        if (abridgedCoordinateTransformation.usages != nil){
            return NO;
        }
    } else if (![_usages isEqual:abridgedCoordinateTransformation.usages]){
        return NO;
    }
    if (_identifiers == nil) {
        if (abridgedCoordinateTransformation.identifiers != nil){
            return NO;
        }
    } else if (![_identifiers isEqual:abridgedCoordinateTransformation.identifiers]){
        return NO;
    }
    if (_remark == nil) {
        if (abridgedCoordinateTransformation.remark != nil){
            return NO;
        }
    } else if (![_remark isEqualToString:abridgedCoordinateTransformation.remark]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSAbridgedCoordinateTransformation class]]) {
        return NO;
    }
    
    return [self isEqualToAbridgedCoordinateTransformation:(CRSAbridgedCoordinateTransformation *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + ((_name == nil) ? 0 : [_name hash]);
    result = prime * result + ((_version == nil) ? 0 : [_version hash]);
    result = prime * result + ((_method == nil) ? 0 : [_method hash]);
    result = prime * result + ((_usages == nil) ? 0 : [_usages hash]);
    result = prime * result + ((_identifiers == nil) ? 0 : [_identifiers hash]);
    result = prime * result + ((_remark == nil) ? 0 : [_remark hash]);
    return result;
}

-(NSString *) description{
    CRSWriter *writer = [CRSWriter create];
    [writer writeAbridgedCoordinateTransformation:self];
    return [writer description];
}

@end
