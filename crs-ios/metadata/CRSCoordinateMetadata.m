//
//  CRSCoordinateMetadata.m
//  crs-ios
//
//  Created by Brian Osborn on 7/19/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSCoordinateMetadata.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>

@implementation CRSCoordinateMetadata

+(CRSCoordinateMetadata *) create{
    return [[CRSCoordinateMetadata alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_COORDINATE_METADATA];
    return self;
}

-(instancetype) initWithCoordinateReferenceSystem: (CRSCoordinateReferenceSystem *) crs{
    self = [self init];
    if(self != nil){
        [self setCoordinateReferenceSystem:crs];
    }
    return self;
}

-(instancetype) initWithCoordinateReferenceSystem: (CRSCoordinateReferenceSystem *) crs andEpoch: (NSDecimalNumber *) epoch{
    self = [self initWithCoordinateReferenceSystem:crs];
    if(self != nil){
        [self setEpoch:epoch];
    }
    return self;
}

-(instancetype) initWithCoordinateReferenceSystem: (CRSCoordinateReferenceSystem *) crs andEpochText: (NSString *) epoch{
    self = [self initWithCoordinateReferenceSystem:crs];
    if(self != nil){
        [self setEpochText:epoch];
    }
    return self;
}

-(BOOL) hasEpoch{
    return [self epoch] != nil;
}

-(void) setEpoch: (NSDecimalNumber *) epoch{
    _epoch = epoch;
    _epochText = [CRSTextUtils textFromDecimalNumber:epoch];
}

-(void) setEpochText: (NSString *) epochText{
    _epochText = epochText;
    _epoch = [CRSTextUtils decimalNumberFromString:epochText];
}

-(NSString *) name{
    return _coordinateReferenceSystem.name;
}

-(void) setName: (NSString *) name{
    [_coordinateReferenceSystem setName:name];
}

-(NSMutableArray<CRSUsage *> *) usages{
    return [_coordinateReferenceSystem usages];
}

-(BOOL) hasUsages{
    return [_coordinateReferenceSystem hasUsages];
}

-(int) numUsages{
    return [_coordinateReferenceSystem numUsages];
}

-(CRSUsage *) usageAtIndex: (int) index{
    return [_coordinateReferenceSystem usageAtIndex:index];
}

-(void) setUsages: (NSArray<CRSUsage *> *) usages{
    [_coordinateReferenceSystem setUsages:[NSMutableArray arrayWithArray:usages]];
}

-(void) addUsage: (CRSUsage *) usage{
    [_coordinateReferenceSystem addUsage:usage];
}

-(void) addUsages: (NSArray<CRSUsage *> *) usages{
    [_coordinateReferenceSystem addUsages:usages];
}

-(NSMutableArray<CRSIdentifier *> *) identifiers{
    return [_coordinateReferenceSystem identifiers];
}

-(BOOL) hasIdentifiers{
    return [_coordinateReferenceSystem hasIdentifiers];
}

-(int) numIdentifiers{
    return [_coordinateReferenceSystem numIdentifiers];
}

-(CRSIdentifier *) identifierAtIndex: (int) index{
    return [_coordinateReferenceSystem identifierAtIndex:index];
}

-(void) setIdentifiers: (NSArray<CRSIdentifier *> *) identifiers{
    [_coordinateReferenceSystem setIdentifiers:[NSMutableArray arrayWithArray:identifiers]];
}

-(void) addIdentifier: (CRSIdentifier *) identifier{
    [_coordinateReferenceSystem addIdentifier:identifier];
}

-(void) addIdentifiers: (NSArray<CRSIdentifier *> *) identifiers{
    [_coordinateReferenceSystem addIdentifiers:identifiers];
}

-(NSString *) remark{
    return [_coordinateReferenceSystem remark];
}

-(BOOL) hasRemark{
    return [_coordinateReferenceSystem hasRemark];
}

-(void) setRemark: (NSString *)remark{
    [_coordinateReferenceSystem setRemark:remark];
}

- (BOOL) isEqualToCoordinateMetadata: (CRSCoordinateMetadata *) coordinateMetadata{
    if (self == coordinateMetadata){
        return YES;
    }
    if (coordinateMetadata == nil){
        return NO;
    }
    if (![super isEqual:coordinateMetadata]){
        return NO;
    }
    if (_coordinateReferenceSystem == nil) {
        if (coordinateMetadata.coordinateReferenceSystem != nil){
            return NO;
        }
    } else if (![_coordinateReferenceSystem isEqual:coordinateMetadata.coordinateReferenceSystem]){
        return NO;
    }
    if (_epoch == nil) {
        if (coordinateMetadata.epoch != nil){
            return NO;
        }
    } else if (![_epoch isEqual:coordinateMetadata.epoch]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSCoordinateMetadata class]]) {
        return NO;
    }
    
    return [self isEqualToCoordinateMetadata:(CRSCoordinateMetadata *)object];
}

- (NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((_coordinateReferenceSystem == nil) ? 0 : [_coordinateReferenceSystem hash]);
    result = prime * result + ((_epoch == nil) ? 0 : [_epoch hash]);
    return result;
}

@end
