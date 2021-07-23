//
//  CRSWriter.m
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSWriter.h"
#import "CRSTextUtils.h"
#import "CRSTextConstants.h"

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

+(NSString *) writePretty: (CRSObject *) crs{
    return [self writePrettyWithText:[self write:crs]];
}

+(NSString *) writePrettyTabIndent: (CRSObject *) crs{
    return [self writePrettyTabIndentWithText:[self write:crs]];
}

+(NSString *) writePrettyNoIndent: (CRSObject *) crs{
    return [self writePrettyNoIndentWithText:[self write:crs]];
}

+(NSString *) writePretty: (CRSObject *) crs withIndent: (NSString *) indent{
    return [self writePrettyWithText:[self write:crs] andIndent:indent];
}

+(NSString *) writePretty: (CRSObject *) crs withNewline: (NSString *) newline andIndent: (NSString *) indent{
    return [self writePrettyWithText:[self write:crs] andNewline:newline andIndent:indent];
}

+(NSString *) writePrettyWithText: (NSString *) wkt{
    return [CRSTextUtils pretty:wkt];
}

+(NSString *) writePrettyTabIndentWithText: (NSString *) wkt{
    return [CRSTextUtils prettyTabIndent:wkt];
}

+(NSString *) writePrettyNoIndentWithText: (NSString *) wkt{
    return [CRSTextUtils prettyNoIndent:wkt];
}

+(NSString *) writePrettyWithText: (NSString *) wkt andIndent: (NSString *) indent{
    return [CRSTextUtils pretty:wkt withIndent:indent];
}

+(NSString *) writePrettyWithText: (NSString *) wkt andNewline: (NSString *) newline andIndent: (NSString *) indent{
    return [CRSTextUtils pretty:wkt withNewline:newline andIndent:indent];
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

    switch(crs.type) {
        case CRS_TYPE_GEODETIC:
        case CRS_TYPE_GEOGRAPHIC:
            [self writeGeo:(CRSGeoCoordinateReferenceSystem *) crs];
            break;
        case CRS_TYPE_PROJECTED:
            [self writeProjected:(CRSProjectedCoordinateReferenceSystem *) crs];
            break;
        case CRS_TYPE_VERTICAL:
            [self writeVertical:(CRSVerticalCoordinateReferenceSystem *) crs];
            break;
        case CRS_TYPE_ENGINEERING:
            [self writeEngineering:(CRSEngineeringCoordinateReferenceSystem *) crs];
            break;
        case CRS_TYPE_PARAMETRIC:
            [self writeParametric:(CRSParametricCoordinateReferenceSystem *) crs];
            break;
        case CRS_TYPE_TEMPORAL:
            [self writeTemporal:(CRSTemporalCoordinateReferenceSystem *) crs];
            break;
        case CRS_TYPE_DERIVED:
            [self writeDerived:(CRSDerivedCoordinateReferenceSystem *) crs];
            break;
        case CRS_TYPE_COMPOUND:
            [self writeCompound:(CRSCompoundCoordinateReferenceSystem *) crs];
            break;
        case CRS_TYPE_COORDINATE_METADATA:
            [self writeCoordinateMetadata:(CRSCoordinateMetadata *) crs];
            break;
        case CRS_TYPE_COORDINATE_OPERATION:
            [self writeCoordinateOperation:(CRSCoordinateOperation *) crs];
            break;
        case CRS_TYPE_POINT_MOTION_OPERATION:
            [self writePointMotionOperation:(CRSPointMotionOperation *) crs];
            break;
        case CRS_TYPE_CONCATENATED_OPERATION:
            [self writeConcatenatedOperation:(CRSConcatenatedOperation *) crs];
            break;
        case CRS_TYPE_BOUND:
            [self writeBound:(CRSBoundCoordinateReferenceSystem *) crs];
            break;
        default:
            [NSException raise:@"Unsupported CRS" format:@"Unsupported CRS type: %@", [CRSTypes name:crs.type]];
    }

}

-(void) writeKeywordType: (enum CRSKeywordType) keyword{
    [self writeKeyword:[CRSKeyword keywordOfType:keyword]];
}

-(void) writeKeyword: (CRSKeyword *) keyword{
    [_text appendString:keyword.name];
}

-(void) writeLeftDelimiter{
    [_text appendString:CRS_WKT_LEFT_DELIMITER];
}

-(void) writeRightDelimiter{
    [_text appendString:CRS_WKT_RIGHT_DELIMITER];
}

-(void) writeSeparator{
    [_text appendString:CRS_WKT_SEPARATOR];
}

-(void) writeQuotedText: (NSString *) text{
    [_text appendString:@"\""];
    [_text appendString:[text stringByReplacingOccurrencesOfString:@"\"" withString:@"\"\""]];
    [_text appendString:@"\""];
}

-(void) writeNumber: (NSNumber *) number{
    [_text appendString:[number stringValue]];
}

-(void) writeNumberOrQuotedText: (NSString *) text{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    if([formatter numberFromString:text] != nil){
        [_text appendString:text];
    }else{
        [self writeQuotedText:text];
    }
}

-(void) writeKeywordType: (enum CRSKeywordType) keyword withDelimitedQuotedText: (NSString *) text{
    [self writeKeyword:[CRSKeyword keywordOfType:keyword] withDelimitedQuotedText:text];
}

-(void) writeKeyword: (CRSKeyword *) keyword withDelimitedQuotedText: (NSString *) text{
    
    [self writeKeyword:keyword];
    
    [self writeLeftDelimiter];
    
    [self writeQuotedText:text];
    
    [self writeRightDelimiter];
}

-(void) writeGeo: (CRSGeoCoordinateReferenceSystem *) crs{

    enum CRSKeywordType keyword;
    switch (crs.type) {
        case CRS_TYPE_GEODETIC:
            keyword = CRS_KEYWORD_GEODCRS;
            break;
        case CRS_TYPE_GEOGRAPHIC:
            keyword = CRS_KEYWORD_GEOGCRS;
            break;
        default:
            [NSException raise:@"Invalid CRS" format:@"Invalid Geodetic or Geographic Coordinate Reference System Type: %@", [CRSTypes name:crs.type]];
    }
    [self writeKeywordType:keyword];

    [self writeLeftDelimiter];

    [self writeQuotedText:crs.name];

    if([crs hasDynamic]){
        [self writeSeparator];
        [self writeDynamic:crs.dynamic];
    }

    [self writeSeparator];
    if([crs hasDynamic] || [crs hasReferenceFrame]){
        [self writeReferenceFrame:crs.referenceFrame];
    }else{
        [self writeDatumEnsemble:crs.datumEnsemble];
    }

    [self writeSeparator];
    [self writeCoordinateSystem:crs.coordinateSystem];

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeProjected: (CRSProjectedCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeVertical: (CRSVerticalCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeEngineering: (CRSEngineeringCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeParametric: (CRSParametricCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeTemporal: (CRSTemporalCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeDerived: (CRSDerivedCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeDerivedGeoCRS: (CRSDerivedCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeDerivedProjectedCRS: (CRSDerivedCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeDerivedVerticalCRS: (CRSDerivedCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeDerivedEngineeringCRS: (CRSDerivedCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeDerivedParametricCRS: (CRSDerivedCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeDerivedTemporalCRS: (CRSDerivedCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeCompound: (CRSCompoundCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeCoordinateMetadata: (CRSCoordinateMetadata *) metadata{
    // TODO
}

-(void) writeCoordinateOperation: (CRSCoordinateOperation *) operation{
    // TODO
}

-(void) writePointMotionOperation: (CRSPointMotionOperation *) operation{
    // TODO
}

-(void) writeConcatenatedOperation: (CRSConcatenatedOperation *) operation{
    // TODO
}

-(void) writeBound: (CRSBoundCoordinateReferenceSystem *) crs{
    // TODO
}

-(void) writeScopeExtentIdentifierRemark: (NSObject<CRSScopeExtentIdentifierRemark> *) object{
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
