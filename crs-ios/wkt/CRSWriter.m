//
//  CRSWriter.m
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSWriter.h"

@interface CRSWriter()

/**
 * Text
 */
@property (nonatomic, strong) NSMutableString *text;

@end

@implementation CRSWriter

-(instancetype) init{
    return [self initWithText:[NSMutableString string]];
}

-(instancetype) initWithText: (NSMutableString *) text{
    self = [super init];
    if(self != nil){
        _text = text;
    }
    return self;
}

-(NSMutableString *) text{
    return _text;
}

-(void) writeUnit: (CRSUnit *) unit{
    // TODO
}

-(void) writeIdentifier: (CRSIdentifier *) identifier{
    // TODO
}

-(void) writeGeographicBoundingBox: (CRSGeographicBoundingBox *) geographicBoundingBox{
    // TODO
}

-(void) writeVerticalExtent: (CRSVerticalExtent *) verticalExtent{
    // TODO
}

@end
