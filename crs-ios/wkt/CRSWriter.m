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

+(NSString *) write: (CRSObject *) crs{
    NSString *value = nil;
    CRSWriter *writer = [CRSWriter create];
    [writer writeCRS:crs];
    value = [writer text];
    return value;
}

+(CRSWriter *) create{
    return [[CRSWriter alloc] init];
}

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

-(void) writeCRS: (CRSObject *) crs{
    // TODO
}

-(void) writeReferenceFrame: (CRSReferenceFrame *) referenceFrame{
    // TODO
}

-(void) writeDatumEnsemble: (CRSDatumEnsemble *) datumEnsemble{
    // TODO
}

-(void) writeDatumEnsembleMember: (CRSDatumEnsembleMember *) datumEnsembleMember{
    // TODO
}

-(void) writeDynamic: (CRSDynamic *) dynamic{
    // TODO
}

-(void) writePrimeMeridian: (CRSPrimeMeridian *) primeMeridian{
    // TODO
}

-(void) writeEllipsoid: (CRSEllipsoid *) ellipsoid{
    // TODO
}

-(void) writeUnit: (CRSUnit *) unit{
    // TODO
}

-(void) writeIdentifier: (CRSIdentifier *) identifier{
    // TODO
}

-(void) writeCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    // TODO
}

-(void) writeAxis: (CRSAxis *) axis{
    // TODO
}

-(void) writeUsage: (CRSUsage *) usage{
    // TODO
}

-(void) writeExtent: (CRSExtent *) extent{
    // TODO
}

-(void) writeGeographicBoundingBox: (CRSGeographicBoundingBox *) geographicBoundingBox{
    // TODO
}

-(void) writeVerticalExtent: (CRSVerticalExtent *) verticalExtent{
    // TODO
}

-(void) writeTemporalExtent: (CRSTemporalExtent *) temporalExtent{
    // TODO
}

-(void) writeMapProjection: (CRSMapProjection *) mapProjection{
    // TODO
}

-(void) writeOperationMethod: (CRSOperationMethod *) operationMethod{
    // TODO
}

-(void) writeOperationParameter: (CRSOperationParameter *) operationParameter{
    // TODO
}

-(void) writeTemporalDatum: (CRSTemporalDatum *) temporalDatum{
    // TODO
}

-(void) writeDerivingConversion: (CRSDerivingConversion *) derivingConversion{
    // TODO
}

-(void) writeAbridgedCoordinateTransformation: (CRSAbridgedCoordinateTransformation *) transformation{
    // TODO
}

@end
