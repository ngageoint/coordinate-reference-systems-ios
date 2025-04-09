//
//  CRSWriter.m
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSWriter.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>
#import <CoordinateReferenceSystems/CRSTextConstants.h>
#import <CoordinateReferenceSystems/CRSTriaxialEllipsoid.h>

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

-(void) writeKeywordType: (CRSKeywordType) keyword{
    [self writeKeyword:[CRSKeyword keywordOfType:keyword]];
}

-(void) writeKeyword: (CRSKeyword *) keyword{
    [_text appendString:[keyword name]];
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
    if([number isKindOfClass:[NSDecimalNumber class]]){
        [_text appendString:[CRSTextUtils textFromDecimalNumber:(NSDecimalNumber *)number]];
    }else{
        [_text appendString:[number stringValue]];
    }
}

-(void) writeNumberOrQuotedText: (NSString *) text{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    if([formatter numberFromString:text] != nil){
        [_text appendString:text];
    }else{
        [self writeQuotedText:text];
    }
}

-(void) writeDouble: (double) value{
    [_text appendString:[CRSTextUtils textFromDouble:value]];
}

-(void) writeInt: (int) value{
    [_text appendFormat:@"%d", value];
}

-(void) writeKeywordType: (CRSKeywordType) keyword withDelimitedQuotedText: (NSString *) text{
    [self writeKeyword:[CRSKeyword keywordOfType:keyword] withDelimitedQuotedText:text];
}

-(void) writeKeyword: (CRSKeyword *) keyword withDelimitedQuotedText: (NSString *) text{
    
    [self writeKeyword:keyword];
    
    [self writeLeftDelimiter];
    
    [self writeQuotedText:text];
    
    [self writeRightDelimiter];
}

-(void) writeGeo: (CRSGeoCoordinateReferenceSystem *) crs{

    CRSKeywordType keyword;
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

    [self writeKeywordType:CRS_KEYWORD_PROJCRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:crs.name];

    CRSKeywordType baseKeyword;
    switch([crs baseType]){
        case CRS_TYPE_GEODETIC:
            baseKeyword = CRS_KEYWORD_BASEGEODCRS;
            break;
        case CRS_TYPE_GEOGRAPHIC:
            baseKeyword = CRS_KEYWORD_BASEGEOGCRS;
            break;
        default:
            [NSException raise:@"Invalid CRS Type" format:@"Invalid Geodetic or Geographic Base Coordinate Reference System Type: %@", [CRSTypes name:[crs baseType]]];
    }

    [self writeSeparator];
    [self writeKeywordType:baseKeyword];

    [self writeLeftDelimiter];

    [self writeQuotedText:[crs baseName]];

    if([crs hasDynamic]){
        [self writeSeparator];
        [self writeDynamic:[crs dynamic]];
    }

    [self writeSeparator];
    if([crs hasDynamic] || [crs hasReferenceFrame]){
        [self writeReferenceFrame:[crs referenceFrame]];
    }else{
        [self writeDatumEnsemble:[crs datumEnsemble]];
    }

    if([crs hasUnit]){
        [self writeSeparator];
        [self writeUnit:[crs unit]];
    }
    
    if([crs hasBaseIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:[crs baseIdentifiers]];
    }

    [self writeRightDelimiter];

    [self writeSeparator];
    [self writeMapProjection:crs.mapProjection];

    [self writeSeparator];
    [self writeCoordinateSystem:crs.coordinateSystem];

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeVertical: (CRSVerticalCoordinateReferenceSystem *) crs{

    [self writeKeywordType:CRS_KEYWORD_VERTCRS];

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

    if([crs hasGeoidModelName]){
        [self writeSeparator];
        [self writeKeywordType:CRS_KEYWORD_GEOIDMODEL];
        [self writeLeftDelimiter];
        [self writeQuotedText:crs.geoidModelName];
        if([crs hasGeoidModelIdentifier]){
            [self writeSeparator];
            [self writeIdentifier:crs.geoidModelIdentifier];
        }
        [self writeRightDelimiter];
    }

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeEngineering: (CRSEngineeringCoordinateReferenceSystem *) crs{

    [self writeKeywordType:CRS_KEYWORD_ENGCRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:crs.name];

    [self writeSeparator];
    [self writeReferenceFrame:crs.datum];

    [self writeSeparator];
    [self writeCoordinateSystem:crs.coordinateSystem];

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeParametric: (CRSParametricCoordinateReferenceSystem *) crs{

    [self writeKeywordType:CRS_KEYWORD_PARAMETRICCRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:crs.name];

    [self writeSeparator];
    [self writeReferenceFrame:crs.datum];

    [self writeSeparator];
    [self writeCoordinateSystem:crs.coordinateSystem];

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeTemporal: (CRSTemporalCoordinateReferenceSystem *) crs{

    [self writeKeywordType:CRS_KEYWORD_TIMECRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:crs.name];

    [self writeSeparator];
    [self writeTemporalDatum:crs.datum];

    [self writeSeparator];
    [self writeCoordinateSystem:crs.coordinateSystem];

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeDerived: (CRSDerivedCoordinateReferenceSystem *) crs{

    switch([crs baseType]){
        case CRS_TYPE_GEODETIC:
        case CRS_TYPE_GEOGRAPHIC:
            [self writeDerivedGeoCRS:crs];
            break;
        case CRS_TYPE_PROJECTED:
            [self writeDerivedProjectedCRS:crs];
            break;
        case CRS_TYPE_VERTICAL:
            [self writeDerivedVerticalCRS:crs];
            break;
        case CRS_TYPE_ENGINEERING:
            [self writeDerivedEngineeringCRS:crs];
            break;
        case CRS_TYPE_PARAMETRIC:
            [self writeDerivedParametricCRS:crs];
            break;
        case CRS_TYPE_TEMPORAL:
            [self writeDerivedTemporalCRS:crs];
            break;
        default:
            [NSException raise:@"Unsupported CRS Type" format:@"Unsupported derived base CRS type: %@", [CRSTypes name:[crs baseType]]];
    }

}

-(void) writeDerivedGeoCRS: (CRSDerivedCoordinateReferenceSystem *) crs{

    CRSKeywordType keyword;
    CRSKeywordType baseKeyword;
    switch([crs baseType]){
        case CRS_TYPE_GEODETIC:
            keyword = CRS_KEYWORD_GEODCRS;
            baseKeyword = CRS_KEYWORD_BASEGEODCRS;
            break;
        case CRS_TYPE_GEOGRAPHIC:
            keyword = CRS_KEYWORD_GEOGCRS;
            baseKeyword = CRS_KEYWORD_BASEGEOGCRS;
            break;
        default:
            [NSException raise:@"Invalid CRS Type" format:@"Invalid Derived Geodetic or Geographic Coordinate Reference System Type: %@", [CRSTypes name:[crs baseType]]];
    }

    CRSGeoCoordinateReferenceSystem *baseCrs = (CRSGeoCoordinateReferenceSystem *) crs.base;

    [self writeKeywordType:keyword];

    [self writeLeftDelimiter];

    [self writeQuotedText:crs.name];

    [self writeSeparator];
    [self writeKeywordType:baseKeyword];

    [self writeLeftDelimiter];

    [self writeQuotedText:baseCrs.name];

    if([baseCrs hasDynamic]){
        [self writeSeparator];
        [self writeDynamic:baseCrs.dynamic];
    }

    [self writeSeparator];
    if([baseCrs hasDynamic] || [baseCrs hasReferenceFrame]){
        [self writeReferenceFrame:baseCrs.referenceFrame];
    }else{
        [self writeDatumEnsemble:baseCrs.datumEnsemble];
    }

    if([baseCrs hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:baseCrs.identifiers];
    }

    [self writeRightDelimiter];

    [self writeSeparator];
    [self writeDerivingConversion:crs.conversion];

    [self writeSeparator];
    [self writeCoordinateSystem:crs.coordinateSystem];

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeDerivedProjectedCRS: (CRSDerivedCoordinateReferenceSystem *) crs{

    CRSProjectedCoordinateReferenceSystem *projectedCrs = (CRSProjectedCoordinateReferenceSystem *) crs.base;

    [self writeKeywordType:CRS_KEYWORD_DERIVEDPROJCRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:crs.name];

    [self writeSeparator];
    [self writeKeywordType:CRS_KEYWORD_BASEPROJCRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:projectedCrs.name];

    CRSKeywordType keyword;
    switch([projectedCrs baseType]){
        case CRS_TYPE_GEODETIC:
            keyword = CRS_KEYWORD_BASEGEODCRS;
            break;
        case CRS_TYPE_GEOGRAPHIC:
            keyword = CRS_KEYWORD_BASEGEOGCRS;
            break;
        default:
            [NSException raise:@"Invalid CRS Type" format:@"Invalid Derived Projected Geodetic or Geographic Coordinate Reference System Type: %@", [CRSTypes name:[projectedCrs baseType]]];
    }

    [self writeSeparator];
    [self writeKeywordType:keyword];

    [self writeLeftDelimiter];

    [self writeQuotedText:[projectedCrs baseName]];

    if([projectedCrs hasDynamic]){
        [self writeSeparator];
        [self writeDynamic:[projectedCrs dynamic]];
    }

    [self writeSeparator];
    if([projectedCrs hasDynamic] || [projectedCrs hasReferenceFrame]){
        [self writeReferenceFrame:[projectedCrs referenceFrame]];
    }else{
        [self writeDatumEnsemble:[projectedCrs datumEnsemble]];
    }

    if([projectedCrs hasBaseIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:[projectedCrs baseIdentifiers]];
    }

    [self writeRightDelimiter];

    [self writeSeparator];
    [self writeMapProjection: projectedCrs.mapProjection];

    if([projectedCrs hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:projectedCrs.identifiers];
    }

    [self writeRightDelimiter];

    [self writeSeparator];
    [self writeDerivingConversion:crs.conversion];

    [self writeSeparator];
    [self writeCoordinateSystem:crs.coordinateSystem];

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeDerivedVerticalCRS: (CRSDerivedCoordinateReferenceSystem *) crs{

    CRSVerticalCoordinateReferenceSystem *baseCrs = (CRSVerticalCoordinateReferenceSystem *) crs.base;

    [self writeKeywordType:CRS_KEYWORD_VERTCRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:crs.name];

    [self writeSeparator];
    [self writeKeywordType:CRS_KEYWORD_BASEVERTCRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:baseCrs.name];

    if([baseCrs hasDynamic]){
        [self writeSeparator];
        [self writeDynamic:baseCrs.dynamic];
    }

    [self writeSeparator];
    if([baseCrs hasDynamic] || [baseCrs hasReferenceFrame]){
        [self writeReferenceFrame:baseCrs.referenceFrame];
    }else{
        [self writeDatumEnsemble:baseCrs.datumEnsemble];
    }

    if([baseCrs hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:baseCrs.identifiers];
    }

    [self writeRightDelimiter];

    [self writeSeparator];
    [self writeDerivingConversion:crs.conversion];

    [self writeSeparator];
    [self writeCoordinateSystem:crs.coordinateSystem];

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeDerivedEngineeringCRS: (CRSDerivedCoordinateReferenceSystem *) crs{

    CRSEngineeringCoordinateReferenceSystem *baseCrs = (CRSEngineeringCoordinateReferenceSystem *) crs.base;

    [self writeKeywordType:CRS_KEYWORD_ENGCRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:crs.name];

    [self writeSeparator];
    [self writeKeywordType:CRS_KEYWORD_BASEENGCRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:baseCrs.name];

    [self writeSeparator];
    [self writeReferenceFrame:baseCrs.datum];

    if([baseCrs hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:baseCrs.identifiers];
    }

    [self writeRightDelimiter];

    [self writeSeparator];
    [self writeDerivingConversion:crs.conversion];

    [self writeSeparator];
    [self writeCoordinateSystem:crs.coordinateSystem];

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeDerivedParametricCRS: (CRSDerivedCoordinateReferenceSystem *) crs{

    CRSParametricCoordinateReferenceSystem *baseCrs = (CRSParametricCoordinateReferenceSystem *) crs.base;

    [self writeKeywordType:CRS_KEYWORD_PARAMETRICCRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:crs.name];
    
    [self writeSeparator];
    [self writeKeywordType:CRS_KEYWORD_BASEPARAMCRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:baseCrs.name];

    [self writeSeparator];
    [self writeReferenceFrame:baseCrs.datum];

    if([baseCrs hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:baseCrs.identifiers];
    }

    [self writeRightDelimiter];

    [self writeSeparator];
    [self writeDerivingConversion:crs.conversion];

    [self writeSeparator];
    [self writeCoordinateSystem:crs.coordinateSystem];

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeDerivedTemporalCRS: (CRSDerivedCoordinateReferenceSystem *) crs{

    CRSTemporalCoordinateReferenceSystem *baseCrs = (CRSTemporalCoordinateReferenceSystem *) crs.base;

    [self writeKeywordType:CRS_KEYWORD_TIMECRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:crs.name];
    
    [self writeSeparator];
    [self writeKeywordType:CRS_KEYWORD_BASETIMECRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:baseCrs.name];
    
    [self writeSeparator];
    [self writeTemporalDatum:baseCrs.datum];

    if([baseCrs hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:baseCrs.identifiers];
    }

    [self writeRightDelimiter];

    [self writeSeparator];
    [self writeDerivingConversion:crs.conversion];

    [self writeSeparator];
    [self writeCoordinateSystem:crs.coordinateSystem];

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeCompound: (CRSCompoundCoordinateReferenceSystem *) crs{

    [self writeKeywordType:CRS_KEYWORD_COMPOUNDCRS];

    [self writeLeftDelimiter];

    [self writeQuotedText:crs.name];

    for(CRSObject *coordinateReferenceSystem in crs.coordinateReferenceSystems){
        [self writeSeparator];
        [self writeCRS:coordinateReferenceSystem];
    }

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeCoordinateMetadata: (CRSCoordinateMetadata *) metadata{

    [self writeKeywordType:CRS_KEYWORD_COORDINATEMETADATA];

    [self writeLeftDelimiter];

    [self writeCRS:metadata.coordinateReferenceSystem];

    if([metadata hasEpoch]){
        
        [self writeSeparator];
        [self writeKeywordType:CRS_KEYWORD_EPOCH];
        [self writeLeftDelimiter];
        [_text appendString:metadata.epochText];
        [self writeRightDelimiter];
        
    }

    [self writeRightDelimiter];
}

-(void) writeCoordinateOperation: (CRSCoordinateOperation *) operation{

    [self writeKeywordType:CRS_KEYWORD_COORDINATEOPERATION];

    [self writeLeftDelimiter];

    [self writeQuotedText:operation.name];

    if([operation hasVersion]){
        [self writeSeparator];
        [self writeVersion:operation.version];
    }

    [self writeSeparator];
    [self writeSource:operation.source];

    [self writeSeparator];
    [self writeTarget:operation.target];

    [self writeSeparator];
    CRSOperationMethod *method = operation.method;
    [self writeOperationMethod:method];

    if([method hasParameters]){
        [self writeSeparator];
        [self writeOperationParameters:method.parameters];
    }

    if([operation hasInterpolation]){
        [self writeSeparator];
        [self writeInterpolation:operation.interpolation];
    }

    if([operation hasAccuracy]){
        [self writeSeparator];
        [self writeAccuracyText:operation.accuracyText];
    }

    [self writeScopeExtentIdentifierRemark:operation];

    [self writeRightDelimiter];
}

-(void) writePointMotionOperation: (CRSPointMotionOperation *) operation{

    [self writeKeywordType:CRS_KEYWORD_POINTMOTIONOPERATION];

    [self writeLeftDelimiter];

    [self writeQuotedText:operation.name];

    if([operation hasVersion]){
        [self writeSeparator];
        [self writeVersion:operation.version];
    }

    [self writeSeparator];
    [self writeSource:operation.source];

    [self writeSeparator];
    CRSOperationMethod *method = operation.method;
    [self writeOperationMethod:method];
    
    if([method hasParameters]){
        [self writeSeparator];
        [self writeOperationParameters:method.parameters];
    }

    if([operation hasAccuracy]){
        [self writeSeparator];
        [self writeAccuracy:[operation.accuracy doubleValue]];
    }

    [self writeScopeExtentIdentifierRemark:operation];

    [self writeRightDelimiter];
}

-(void) writeConcatenatedOperation: (CRSConcatenatedOperation *) operation{

    [self writeKeywordType:CRS_KEYWORD_CONCATENATEDOPERATION];

    [self writeLeftDelimiter];

    [self writeQuotedText:operation.name];

    if([operation hasVersion]){
        [self writeSeparator];
        [self writeVersion:operation.version];
    }

    [self writeSeparator];
    [self writeSource:operation.source];

    [self writeSeparator];
    [self writeTarget:operation.target];

    for(NSObject<CRSCommonOperation> *concatenable in operation.operations){
        
        [self writeSeparator];
        [self writeKeywordType:CRS_KEYWORD_STEP];

        [self writeLeftDelimiter];

        switch([concatenable operationType]){
            case CRS_OPERATION_COORDINATE:
                [self writeCoordinateOperation:(CRSCoordinateOperation *)concatenable];
                break;
            case CRS_OPERATION_POINT_MOTION:
                [self writePointMotionOperation:(CRSPointMotionOperation *)concatenable];
                break;
            case CRS_OPERATION_MAP_PROJECTION:
                [self writeMapProjection:(CRSMapProjection *)concatenable];
                break;
            case CRS_OPERATION_DERIVING_CONVERSION:
                [self writeDerivingConversion:(CRSDerivingConversion *)concatenable];
                break;
            default:
                [NSException raise:@"Unsupported Operation" format:@"Unsupported concatenable operation type: %@", [CRSOperationTypes name:[concatenable operationType]]];
        }

        [self writeRightDelimiter];
    }

    if([operation hasAccuracy]){
        [self writeSeparator];
        [self writeAccuracy:[operation.accuracy doubleValue]];
    }

    [self writeScopeExtentIdentifierRemark:operation];

    [self writeRightDelimiter];
}

-(void) writeBound: (CRSBoundCoordinateReferenceSystem *) crs{

    [self writeKeywordType:CRS_KEYWORD_BOUNDCRS];

    [self writeLeftDelimiter];

    [self writeSource:crs.source];

    [self writeSeparator];
    [self writeTarget:crs.target];
    
    [self writeSeparator];
    [self writeAbridgedCoordinateTransformation:crs.transformation];

    [self writeScopeExtentIdentifierRemark:crs];

    [self writeRightDelimiter];
}

-(void) writeScopeExtentIdentifierRemark: (NSObject<CRSScopeExtentIdentifierRemark> *) object{

    if([object hasUsages]){
        [self writeSeparator];
        [self writeUsages:[object usages]];
    }
    
    if([object hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:[object identifiers]];
    }
    
    if([object hasRemark]){
        [self writeSeparator];
        [self writeRemark:[object remark]];
    }

}

-(void) writeReferenceFrame: (CRSReferenceFrame *) referenceFrame{

    CRSGeoReferenceFrame *geodeticReferenceFrame = nil;
    if([referenceFrame isKindOfClass:[CRSGeoReferenceFrame class]]){
        geodeticReferenceFrame = (CRSGeoReferenceFrame *) referenceFrame;
    }
    
    switch(referenceFrame.type){
        case CRS_TYPE_GEODETIC:
        case CRS_TYPE_GEOGRAPHIC:
            [self writeKeywordType:CRS_KEYWORD_DATUM];
            break;
        case CRS_TYPE_VERTICAL:
            [self writeKeywordType:CRS_KEYWORD_VDATUM];
            break;
        case CRS_TYPE_ENGINEERING:
            [self writeKeywordType:CRS_KEYWORD_EDATUM];
            break;
        case CRS_TYPE_PARAMETRIC:
            [self writeKeywordType:CRS_KEYWORD_PDATUM];
            break;
        default:
            [NSException raise:@"Unexpected CRS Type" format:@"Unexpected Reference Frame Coordinate Reference System Type: %@", [CRSTypes name:referenceFrame.type]];
    }

    [self writeLeftDelimiter];

    [self writeQuotedText:referenceFrame.name];

    if(geodeticReferenceFrame != nil){
        [self writeSeparator];
        [self writeEllipsoid:geodeticReferenceFrame.ellipsoid];
    }

    if([referenceFrame hasAnchor]){
        [self writeSeparator];
        [self writeKeywordType:CRS_KEYWORD_ANCHOR withDelimitedQuotedText:referenceFrame.anchor];
    }

    if([referenceFrame hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:referenceFrame.identifiers];
    }

    [self writeRightDelimiter];

    if(geodeticReferenceFrame != nil && [geodeticReferenceFrame hasPrimeMeridian]){
        [self writeSeparator];
        [self writePrimeMeridian:geodeticReferenceFrame.primeMeridian];
    }

}

-(void) writeDatumEnsemble: (CRSDatumEnsemble *) datumEnsemble{

    CRSGeoDatumEnsemble *geodeticDatumEnsemble = nil;
    if([datumEnsemble isKindOfClass:[CRSGeoDatumEnsemble class]]){
        geodeticDatumEnsemble = (CRSGeoDatumEnsemble *) datumEnsemble;
    }

    [self writeKeywordType:CRS_KEYWORD_ENSEMBLE];

    [self writeLeftDelimiter];

    [self writeQuotedText:datumEnsemble.name];

    for(CRSDatumEnsembleMember *member in datumEnsemble.members){
        [self writeSeparator];
        [self writeDatumEnsembleMember:member];
    }

    if(geodeticDatumEnsemble != nil){
        [self writeSeparator];
        [self writeEllipsoid:geodeticDatumEnsemble.ellipsoid];
    }

    [self writeSeparator];
    [self writeKeywordType:CRS_KEYWORD_ENSEMBLEACCURACY];
    [self writeLeftDelimiter];
    [_text appendString:datumEnsemble.accuracyText];
    [self writeRightDelimiter];

    if([datumEnsemble hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:datumEnsemble.identifiers];
    }

    [self writeRightDelimiter];

    if(geodeticDatumEnsemble != nil && [geodeticDatumEnsemble hasPrimeMeridian]){
        [self writeSeparator];
        [self writePrimeMeridian:geodeticDatumEnsemble.primeMeridian];
    }

}

-(void) writeDatumEnsembleMember: (CRSDatumEnsembleMember *) datumEnsembleMember{

    [self writeKeywordType:CRS_KEYWORD_MEMBER];

    [self writeLeftDelimiter];

    [self writeQuotedText:datumEnsembleMember.name];

    if([datumEnsembleMember hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:datumEnsembleMember.identifiers];
    }

    [self writeRightDelimiter];
}

-(void) writeDynamic: (CRSDynamic *) dynamic{

    [self writeKeywordType:CRS_KEYWORD_DYNAMIC];

    [self writeLeftDelimiter];

    [self writeKeywordType:CRS_KEYWORD_FRAMEEPOCH];

    [self writeLeftDelimiter];

    [_text appendString:dynamic.referenceEpochText];

    [self writeRightDelimiter];

    if([dynamic hasDeformationModelName]){

        [self writeSeparator];
        [self writeKeywordType:CRS_KEYWORD_MODEL];

        [self writeLeftDelimiter];

        [self writeQuotedText:dynamic.deformationModelName];

        if([dynamic hasIdentifiers]){
            [self writeSeparator];
            [self writeIdentifiers:dynamic.identifiers];
        }

        [self writeRightDelimiter];
    }

    [self writeRightDelimiter];
}

-(void) writePrimeMeridian: (CRSPrimeMeridian *) primeMeridian{

    [self writeKeywordType:CRS_KEYWORD_PRIMEM];

    [self writeLeftDelimiter];

    [self writeQuotedText:primeMeridian.name];

    [self writeSeparator];
    [_text appendString:primeMeridian.longitudeText];

    if([primeMeridian hasLongitudeUnit]){
        [self writeSeparator];
        [self writeUnit:primeMeridian.longitudeUnit];
    }

    if([primeMeridian hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:primeMeridian.identifiers];
    }

    [self writeRightDelimiter];
}

-(void) writeEllipsoid: (CRSEllipsoid *) ellipsoid{

    CRSTriaxialEllipsoid *triaxial = nil;

    if([ellipsoid isKindOfClass:[CRSTriaxialEllipsoid class]]){
        triaxial = (CRSTriaxialEllipsoid *) ellipsoid;
        [self writeKeywordType:CRS_KEYWORD_TRIAXIAL];
    }else{
        [self writeKeywordType:CRS_KEYWORD_ELLIPSOID];
    }

    [self writeLeftDelimiter];

    [self writeQuotedText:ellipsoid.name];

    [self writeSeparator];
    [_text appendString:ellipsoid.semiMajorAxisText];

    if(triaxial != nil){
        
        [self writeSeparator];
        [_text appendString:triaxial.semiMedianAxisText];
        
        [self writeSeparator];
        [_text appendString:triaxial.semiMinorAxisText];
        
    }else{
        
        [self writeSeparator];
        [_text appendString:ellipsoid.inverseFlatteningText];
        
    }

    if([ellipsoid hasUnit]){
        [self writeSeparator];
        [self writeUnit:ellipsoid.unit];
    }

    if([ellipsoid hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:ellipsoid.identifiers];
    }

    [self writeRightDelimiter];
}

-(void) writeUnit: (CRSUnit *) unit{

    [_text appendString:[CRSUnitTypes name:unit.type]];

    [self writeLeftDelimiter];

    [self writeQuotedText:unit.name];
    
    if([unit hasConversionFactor]){
        [self writeSeparator];
        [_text appendString:unit.conversionFactorText];
    }

    if([unit hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:unit.identifiers];
    }

    [self writeRightDelimiter];
}

-(void) writeIdentifiers: (NSArray<CRSIdentifier *> *) identifiers{
    
    for(int i = 0; i < identifiers.count; i++){
        
        if(i > 0){
            [self writeSeparator];
        }
        
        [self writeIdentifier:[identifiers objectAtIndex:i]];
    }
    
}

-(void) writeIdentifier: (CRSIdentifier *) identifier{

    [self writeKeywordType:CRS_KEYWORD_ID];

    [self writeLeftDelimiter];

    [self writeQuotedText:identifier.name];

    [self writeSeparator];
    [self writeNumberOrQuotedText:identifier.uniqueIdentifier];

    if([identifier hasVersion]){
        [self writeSeparator];
        [self writeNumberOrQuotedText:identifier.version];
    }

    if([identifier hasCitation]){
        [self writeSeparator];
        [self writeKeywordType:CRS_KEYWORD_CITATION withDelimitedQuotedText:identifier.citation];
    }

    if([identifier hasUri]){
        [self writeSeparator];
        [self writeKeywordType:CRS_KEYWORD_URI withDelimitedQuotedText:identifier.uri];
    }

    [self writeRightDelimiter];
}

-(void) writeCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{

    [self writeKeywordType:CRS_KEYWORD_CS];

    [self writeLeftDelimiter];

    [_text appendString:[CRSCoordinateSystemTypes name:coordinateSystem.type]];

    [self writeSeparator];
    [self writeInt:coordinateSystem.dimension];

    if([coordinateSystem hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:coordinateSystem.identifiers];
    }

    [self writeRightDelimiter];

    for(CRSAxis *axis in coordinateSystem.axes){
        [self writeSeparator];
        [self writeAxis:axis];
    }

    if([coordinateSystem hasUnit]){
        [self writeSeparator];
        [self writeUnit:coordinateSystem.unit];
    }

}

-(void) writeAxis: (CRSAxis *) axis{

    [self writeKeywordType:CRS_KEYWORD_AXIS];

    [self writeLeftDelimiter];

    NSMutableString *nameAbbrev = [NSMutableString string];
    if([axis hasName]){
        [nameAbbrev appendString:axis.name];
    }
    if([axis hasAbbreviation]){
        if(nameAbbrev.length > 0){
            [nameAbbrev appendString:@" "];
        }
        [nameAbbrev appendString:CRS_WKT_AXIS_ABBREV_LEFT_DELIMITER];
        [nameAbbrev appendString:axis.abbreviation];
        [nameAbbrev appendString:CRS_WKT_AXIS_ABBREV_RIGHT_DELIMITER];
    }
    [self writeQuotedText:nameAbbrev];

    [self writeSeparator];
    [_text appendString:[CRSAxisDirectionTypes name:axis.direction]];

    switch(axis.direction){
            
        case CRS_AXIS_NORTH:
        case CRS_AXIS_SOUTH:
            
            if([axis hasMeridian]){
                
                [self writeSeparator];
                [self writeKeywordType:CRS_KEYWORD_MERIDIAN];
                
                [self writeLeftDelimiter];
                
                [_text appendString:axis.meridianText];
                
                [self writeSeparator];
                [self writeUnit:axis.meridianUnit];
                
                [self writeRightDelimiter];
            }
            
            break;
            
        case CRS_AXIS_CLOCKWISE:
        case CRS_AXIS_COUNTER_CLOCKWISE:
            
            [self writeSeparator];
            [self writeKeywordType:CRS_KEYWORD_BEARING];
            
            [self writeLeftDelimiter];
            
            [_text appendString:axis.bearingText];
            
            [self writeRightDelimiter];
            
            break;
            
        default:
            break;
    }

    if([axis hasOrder]){
        
        [self writeSeparator];
        [self writeKeywordType:CRS_KEYWORD_ORDER];
        
        [self writeLeftDelimiter];
        
        [self writeNumber:axis.order];
        
        [self writeRightDelimiter];
    }
    
    if([axis hasUnit]){
        [self writeSeparator];
        [self writeUnit:axis.unit];
    }

    if([axis hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:axis.identifiers];
    }

    [self writeRightDelimiter];
}

-(void) writeRemark: (NSString *) remark{
    [self writeKeywordType:CRS_KEYWORD_REMARK withDelimitedQuotedText:remark];
}

-(void) writeUsages: (NSArray<CRSUsage *> *) usages{

    for(int i = 0; i < usages.count; i++){

        if(i > 0){
            [self writeSeparator];
        }

        [self writeUsage:[usages objectAtIndex:i]];
    }

}

-(void) writeUsage: (CRSUsage *) usage{

    [self writeKeywordType:CRS_KEYWORD_USAGE];

    [self writeLeftDelimiter];

    [self writeScope:usage.scope];

    [self writeExtent:usage.extent];

    [self writeRightDelimiter];
}

-(void) writeScope: (NSString *) scope{
    [self writeKeywordType:CRS_KEYWORD_SCOPE withDelimitedQuotedText:scope];
}

-(void) writeExtent: (CRSExtent *) extent{

    if([extent hasAreaDescription]){
        [self writeSeparator];
        [self writeAreaDescription:extent.areaDescription];
    }

    if([extent hasGeographicBoundingBox]){
        [self writeSeparator];
        [self writeGeographicBoundingBox:extent.geographicBoundingBox];
    }

    if([extent hasVerticalExtent]){
        [self writeSeparator];
        [self writeVerticalExtent:extent.verticalExtent];
    }

    if([extent hasTemporalExtent]){
        [self writeSeparator];
        [self writeTemporalExtent:extent.temporalExtent];
    }

}

-(void) writeAreaDescription: (NSString *) areaDescription{
    [self writeKeywordType:CRS_KEYWORD_AREA withDelimitedQuotedText:areaDescription];
}

-(void) writeGeographicBoundingBox: (CRSGeographicBoundingBox *) geographicBoundingBox{

    [self writeKeywordType:CRS_KEYWORD_BBOX];

    [self writeLeftDelimiter];

    [_text appendString:geographicBoundingBox.lowerLeftLatitudeText];

    [self writeSeparator];
    [_text appendString:geographicBoundingBox.lowerLeftLongitudeText];

    [self writeSeparator];
    [_text appendString:geographicBoundingBox.upperRightLatitudeText];

    [self writeSeparator];
    [_text appendString:geographicBoundingBox.upperRightLongitudeText];

    [self writeRightDelimiter];
}

-(void) writeVerticalExtent: (CRSVerticalExtent *) verticalExtent{

    [self writeKeywordType:CRS_KEYWORD_VERTICALEXTENT];

    [self writeLeftDelimiter];
    
    [_text appendString:verticalExtent.minimumHeightText];

    [self writeSeparator];
    [_text appendString:verticalExtent.maximumHeightText];

    if([verticalExtent hasUnit]){
        [self writeSeparator];
        [self writeUnit:verticalExtent.unit];
    }

    [self writeRightDelimiter];
}

-(void) writeTemporalExtent: (CRSTemporalExtent *) temporalExtent{

    [self writeKeywordType:CRS_KEYWORD_TIMEEXTENT];

    [self writeLeftDelimiter];

    if([temporalExtent hasStartDateTime]){
        [_text appendString:[temporalExtent.startDateTime description]];
    }else{
        [self writeQuotedText:temporalExtent.start];
    }

    [self writeSeparator];

    if([temporalExtent hasEndDateTime]){
        [_text appendString:[temporalExtent.endDateTime description]];
    }else{
        [self writeQuotedText:temporalExtent.end];
    }

    [self writeRightDelimiter];
}

-(void) writeMapProjection: (CRSMapProjection *) mapProjection{

    [self writeKeywordType:CRS_KEYWORD_CONVERSION];

    [self writeLeftDelimiter];

    [self writeQuotedText:mapProjection.name];

    [self writeSeparator];

    CRSOperationMethod *method = mapProjection.method;
    [self writeOperationMethod:method];

    if([method hasParameters]){
        [self writeSeparator];
        [self writeOperationParameters:method.parameters];
    }

    if([mapProjection hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:mapProjection.identifiers];
    }

    [self writeRightDelimiter];
}

-(void) writeOperationMethod: (CRSOperationMethod *) method{

    [self writeKeywordType:CRS_KEYWORD_METHOD];

    [self writeLeftDelimiter];

    [self writeQuotedText:method.name];

    if([method hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:method.identifiers];
    }

    [self writeRightDelimiter];
}

-(void) writeOperationParameter: (CRSOperationParameter *) parameter{

    if([parameter isFile]){
        [self writeKeywordType:CRS_KEYWORD_PARAMETERFILE];
    }else{
        [self writeKeywordType:CRS_KEYWORD_PARAMETER];
    }

    [self writeLeftDelimiter];

    [self writeQuotedText:parameter.name];

    [self writeSeparator];
    if([parameter isFile]){
        [self writeQuotedText:parameter.fileName];
    } else {
        [_text appendString:parameter.valueText];

        if([parameter hasUnit]){
            [self writeSeparator];
            [self writeUnit:parameter.unit];
        }
    }

    if([parameter hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:parameter.identifiers];
    }

    [self writeRightDelimiter];
}

-(void) writeTemporalDatum: (CRSTemporalDatum *) temporalDatum{

    [self writeKeywordType:CRS_KEYWORD_TDATUM];

    [self writeLeftDelimiter];

    [self writeQuotedText:temporalDatum.name];

    if([temporalDatum hasCalendar]){
        [self writeSeparator];
        [self writeKeywordType:CRS_KEYWORD_CALENDAR withDelimitedQuotedText:temporalDatum.calendar];
    }

    if([temporalDatum hasOrigin] || [temporalDatum hasOriginDateTime]){
        [self writeSeparator];
        [self writeKeywordType:CRS_KEYWORD_TIMEORIGIN];
        [self writeLeftDelimiter];
        if([temporalDatum hasOriginDateTime]){
            [_text appendString:[temporalDatum.originDateTime description]];
        }else{
            [self writeQuotedText:temporalDatum.origin];
        }
        [self writeRightDelimiter];
    }

    if([temporalDatum hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:temporalDatum.identifiers];
    }

    [self writeRightDelimiter];
}

-(void) writeDerivingConversion: (CRSDerivingConversion *) derivingConversion{

    [self writeKeywordType:CRS_KEYWORD_DERIVINGCONVERSION];

    [self writeLeftDelimiter];

    [self writeQuotedText:derivingConversion.name];

    [self writeSeparator];
    CRSOperationMethod *method = derivingConversion.method;
    [self writeOperationMethod:method];

    if([method hasParameters]){
        [self writeSeparator];
        [self writeOperationParameters:method.parameters];
    }

    if([derivingConversion hasIdentifiers]){
        [self writeSeparator];
        [self writeIdentifiers:derivingConversion.identifiers];
    }

    [self writeRightDelimiter];
}

-(void) writeOperationParameters: (NSArray<CRSOperationParameter *> *) parameters{

    for(int i = 0; i < parameters.count; i++){

        if(i > 0){
            [self writeSeparator];
        }

        [self writeOperationParameter:[parameters objectAtIndex:i]];
    }

}

-(void) writeVersion: (NSString *) version{

    [self writeKeywordType:CRS_KEYWORD_VERSION];

    [self writeLeftDelimiter];

    [self writeQuotedText:version];

    [self writeRightDelimiter];
}

-(void) writeSource: (CRSCoordinateReferenceSystem *) crs{
    [self writeCoordinateReferenceSystem:crs withKeywordType:CRS_KEYWORD_SOURCECRS];
}

-(void) writeTarget: (CRSCoordinateReferenceSystem *) crs{
    [self writeCoordinateReferenceSystem:crs withKeywordType:CRS_KEYWORD_TARGETCRS];
}

-(void) writeInterpolation: (CRSCoordinateReferenceSystem *) crs{
    [self writeCoordinateReferenceSystem:crs withKeywordType:CRS_KEYWORD_INTERPOLATIONCRS];
}

-(void) writeCoordinateReferenceSystem: (CRSCoordinateReferenceSystem *) crs withKeywordType: (CRSKeywordType) keyword{

    [self writeKeywordType:keyword];
    [self writeLeftDelimiter];

    [self writeCRS:crs];

    [self writeRightDelimiter];
}

-(void) writeAccuracy: (double) accuracy{
    
    [self writeKeywordType:CRS_KEYWORD_OPERATIONACCURACY];

    [self writeLeftDelimiter];

    [self writeDouble:accuracy];

    [self writeRightDelimiter];
}

-(void) writeAccuracyText: (NSString *) accuracy{
    
    [self writeKeywordType:CRS_KEYWORD_OPERATIONACCURACY];

    [self writeLeftDelimiter];

    [_text appendString:accuracy];

    [self writeRightDelimiter];
}

-(void) writeAbridgedCoordinateTransformation: (CRSAbridgedCoordinateTransformation *) transformation{

    [self writeKeywordType:CRS_KEYWORD_ABRIDGEDTRANSFORMATION];

    [self writeLeftDelimiter];

    [self writeQuotedText:transformation.name];

    if([transformation hasVersion]){
        [self writeSeparator];
        [self writeVersion:transformation.version];
    }

    [self writeSeparator];
    CRSOperationMethod *method = transformation.method;
    [self writeOperationMethod:method];

    if([method hasParameters]){
        [self writeSeparator];
        [self writeOperationParameters:method.parameters];
    }

    [self writeScopeExtentIdentifierRemark:transformation];

    [self writeRightDelimiter];
}

-(NSString *) description{
    return [self text];
}

@end
