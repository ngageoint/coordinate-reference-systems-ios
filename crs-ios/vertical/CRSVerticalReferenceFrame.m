//
//  CRSVerticalReferenceFrame.m
//  crs-ios
//
//  Created by Brian Osborn on 7/21/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSVerticalReferenceFrame.h>

@implementation CRSVerticalReferenceFrame

+(CRSVerticalReferenceFrame *) create{
    return [[CRSVerticalReferenceFrame alloc] init];
}

-(instancetype) init{
    self = [super initWithType:CRS_TYPE_VERTICAL];
    return self;
}

-(instancetype) initWithName: (NSString *) name{
    self = [super initWithName:name andType:CRS_TYPE_VERTICAL];
    return self;
}

- (BOOL) isEqualToVerticalReferenceFrame: (CRSVerticalReferenceFrame *) verticalReferenceFrame{
    if (self == verticalReferenceFrame){
        return YES;
    }
    if (verticalReferenceFrame == nil){
        return NO;
    }
    if (![super isEqual:verticalReferenceFrame]){
        return NO;
    }
    return YES;
}

- (BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CRSVerticalReferenceFrame class]]) {
        return NO;
    }
    
    return [self isEqualToVerticalReferenceFrame:(CRSVerticalReferenceFrame *)object];
}

- (NSUInteger) hash{
    return [super hash];
}

@end
