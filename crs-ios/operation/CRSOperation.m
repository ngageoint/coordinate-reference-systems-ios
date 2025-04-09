//
//  CRSOperation.m
//  crs-ios
//
//  Created by Brian Osborn on 7/19/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSOperation.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>

@implementation CRSOperation

-(instancetype) initWithType: (CRSType) type{
    self = [super initWithType:type];
    return self;
}

-(instancetype) initWithName: (NSString *) name andType: (CRSType) type andSource: (CRSCoordinateReferenceSystem *) source{
    self = [super initWithName:name andType:type];
    if(self != nil){
        [self setSource:source];
    }
    return self;
}

-(BOOL) hasVersion{
    return [self version] != nil;
}

-(BOOL) hasAccuracy{
    return [self accuracy] != nil;
}

-(void) setAccuracy: (NSDecimalNumber *) accuracy{
    _accuracy = accuracy;
    _accuracyText = [CRSTextUtils textFromDecimalNumber:accuracy];
}

-(void) setAccuracyText: (NSString *) accuracyText{
    _accuracyText = accuracyText;
    _accuracy = [CRSTextUtils decimalNumberFromString:accuracyText];
}

- (BOOL) isEqualToOperation: (CRSOperation *) operation{
    if (self == operation){
        return YES;
    }
    if (operation == nil){
        return NO;
    }
    if (![super isEqual:operation]){
        return NO;
    }
    if (_version == nil) {
        if (operation.version != nil){
            return NO;
        }
    } else if (![_version isEqualToString:operation.version]){
        return NO;
    }
    if (_source == nil) {
        if (operation.source != nil){
            return NO;
        }
    } else if (![_source isEqual:operation.source]){
        return NO;
    }
    if (_accuracy == nil) {
        if (operation.accuracy != nil){
            return NO;
        }
    } else if (![_accuracy isEqual:operation.accuracy]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSOperation class]]) {
        return NO;
    }
    
    return [self isEqualToOperation:(CRSOperation *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_version == nil) ? 0 : [_version hash]);
    result = prime * result + ((_source == nil) ? 0 : [_source hash]);
    result = prime * result + ((_accuracy == nil) ? 0 : [_accuracy hash]);
    return result;
}

@end
