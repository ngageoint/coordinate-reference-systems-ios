//
//  CRSReader.m
//  crs-ios
//
//  Created by Brian Osborn on 7/22/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSReader.h"

@interface CRSReader()

/**
 * Text Reader
 */
@property (nonatomic, strong) CRSTextReader *reader;

@end

@implementation CRSReader

+(CRSObject *) read: (NSString *) text{
    return nil; // TODO
}

+(CRSObject *) read: (NSString *) text withStrict: (BOOL) strict{
    return nil; // TODO
}

+(CRSObject *) read: (NSString *) text withType: (enum CRSType) expected{
    return nil; // TODO
}

+(CRSObject *) read: (NSString *) text withTypes: (NSArray<NSNumber *> *) expected{
    return nil; // TODO
}

+(CRSObject *) read: (NSString *) text withStrict: (BOOL) strict withType: (enum CRSType) expected{
    return nil; // TODO
}

+(CRSCoordinateReferenceSystem *) readCoordinateReferenceSystem: (NSString *) text{
    return nil; // TODO
}

+(CRSCoordinateReferenceSystem *) readCoordinateReferenceSystem: (NSString *) text withStrict: (BOOL) strict{
    return nil; // TODO
}

+(CRSSimpleCoordinateReferenceSystem *) readSimpleCoordinateReferenceSystem: (NSString *) text{
    return nil; // TODO
}

+(CRSSimpleCoordinateReferenceSystem *) readSimpleCoordinateReferenceSystem: (NSString *) text withStrict: (BOOL) strict{
    return nil; // TODO
}

+(CRSGeoCoordinateReferenceSystem *) readGeo: (NSString *) text{
    return nil; // TODO
}

+(CRSGeoCoordinateReferenceSystem *) readGeodetic: (NSString *) text{
    return nil; // TODO
}

+(CRSGeoCoordinateReferenceSystem *) readGeographic: (NSString *) text{
    return nil; // TODO
}

+(CRSProjectedCoordinateReferenceSystem *) readProjected: (NSString *) text{
    return nil; // TODO
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedGeodetic: (NSString *) text{
    return nil; // TODO
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedGeographic: (NSString *) text{
    return nil; // TODO
}

+(CRSVerticalCoordinateReferenceSystem *) readVertical: (NSString *) text{
    return nil; // TODO
}

+(CRSEngineeringCoordinateReferenceSystem *) readEngineering: (NSString *) text{
    return nil; // TODO
}

+(CRSParametricCoordinateReferenceSystem *) readParametric: (NSString *) text{
    return nil; // TODO
}

+(CRSTemporalCoordinateReferenceSystem *) readTemporal: (NSString *) text{
    return nil; // TODO
}

+(CRSDerivedCoordinateReferenceSystem *) readDerived: (NSString *) text{
    return nil; // TODO
}

+(CRSCompoundCoordinateReferenceSystem *) readCompound: (NSString *) text{
    return nil; // TODO
}

+(CRSCoordinateMetadata *) readCoordinateMetadata: (NSString *) text{
    return nil; // TODO
}

+(CRSCoordinateOperation *) readCoordinateOperation: (NSString *) text{
    return nil; // TODO
}

+(CRSPointMotionOperation *) readPointMotionOperation: (NSString *) text{
    return nil; // TODO
}

+(CRSConcatenatedOperation *) readConcatenatedOperation: (NSString *) text{
    return nil; // TODO
}

+(CRSBoundCoordinateReferenceSystem *) readBound: (NSString *) text{
    return nil; // TODO
}

+(CRSGeoCoordinateReferenceSystem *) readGeoCompat: (NSString *) text{
    return nil; // TODO
}

+(CRSGeoCoordinateReferenceSystem *) readGeodeticCompat: (NSString *) text{
    return nil; // TODO
}

+(CRSGeoCoordinateReferenceSystem *) readGeographicCompat: (NSString *) text{
    return nil; // TODO
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedCompat: (NSString *) text{
    return nil; // TODO
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedGeodeticCompat: (NSString *) text{
    return nil; // TODO
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedGeographicCompat: (NSString *) text{
    return nil; // TODO
}

-(instancetype) initWithText: (NSString *) text{
    return [self initWithReader:[CRSTextReader createWithText:text]];
}

-(instancetype) initWithReader: (CRSTextReader *) reader{
    return [self initWithReader:reader andStrict:NO];
}

-(instancetype) initWithText: (NSString *) text andStrict: (BOOL) strict{
    return [self initWithReader:[CRSTextReader createWithText:text] andStrict:strict];
}

-(instancetype) initWithReader: (CRSTextReader *) reader andStrict: (BOOL) strict{
    self = [super init];
    if(self != nil){
        _reader = reader;
        _strict = strict;
    }
    return self;
}

-(CRSTextReader *) textReader{
    return _reader;
}

-(void) reset{
    [_reader reset];
}

-(CRSObject *) read{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readCoordinateReferenceSystem{
    return nil; // TODO
}

-(CRSSimpleCoordinateReferenceSystem *) readSimpleCoordinateReferenceSystem{
    return nil; // TODO
}

-(enum CRSKeywordType) readKeyword{
    return -1; // TODO
}

-(NSArray<NSNumber *> *) readKeywords{
    return nil; // TODO
}

-(enum CRSKeywordType) readKeywordWithType: (enum CRSKeywordType) keyword{
    return -1; // TODO
}

-(enum CRSKeywordType) readKeywordWithTypes: (NSArray<NSNumber *> *) keywords{
    return -1; // TODO
}

-(enum CRSKeywordType) readToKeyword: (enum CRSKeywordType) keyword{
    return -1; // TODO
}

-(enum CRSKeywordType) readToKeywords: (NSArray<NSNumber *> *) keywords{
    return -1; // TODO
}

-(enum CRSKeywordType) readKeywordWithType: (enum CRSKeywordType) keyword andRequired: (BOOL) required{
    return -1; // TODO
}

-(enum CRSKeywordType) readKeywordWithTypes: (NSArray<NSNumber *> *) keywords andRequired: (BOOL) required{
    return -1; // TODO
}

-(enum CRSKeywordType) peekKeyword{
    return -1; // TODO
}

-(NSArray<NSNumber *> *) peekKeywords{
    return nil; // TODO
}

-(enum CRSKeywordType) peekOptionalKeyword{
    return -1; // TODO
}

-(NSArray<NSNumber *> *) peekOptionalKeywords{
    return nil; // TODO
}

-(enum CRSKeywordType) peekOptionalKeywordAtNum: (int) num{
    return -1; // TODO
}

-(NSArray<NSNumber *> *) peekOptionalKeywordsAtNum: (int) num{
    return nil; // TODO
}

-(void) readLeftDelimiter{
    // TODO
}

-(BOOL) peekLeftDelimiter{
    return NO; // TODO
}

-(void) readRightDelimiter{
    // TODO
}

-(BOOL) peekRightDelimiter{
    return NO; // TODO
}

-(void) readSeparator{
    // TODO
}

-(BOOL) peekSeparator{
    return NO; // TODO
}

-(void) readEnd{
    // TODO
}

-(NSString *) readKeywordDelimitedToken: (enum CRSKeywordType) keyword{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readGeo{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjected{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedGeodetic{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedGeographic{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedWithType: (enum CRSType) expectedBaseType{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readVertical{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readEngineering{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readParametric{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readTemporal{
    return nil; // TODO
}

-(CRSDerivedCoordinateReferenceSystem *) readDerivedProjected{
    return nil; // TODO
}

-(CRSCompoundCoordinateReferenceSystem *) readCompound{
    return nil; // TODO
}

-(CRSCoordinateMetadata *) readCoordinateMetadata{
    return nil; // TODO
}

-(CRSCoordinateOperation *) readCoordinateOperation{
    return nil; // TODO
}

-(CRSPointMotionOperation *) readPointMotionOperation{
    return nil; // TODO
}

-(CRSConcatenatedOperation *) readConcatenatedOperation{
    return nil; // TODO
}

-(CRSBoundCoordinateReferenceSystem *) readBound{
    return nil; // TODO
}

-(void) readScopeExtentIdentifierRemark: (NSObject<CRSScopeExtentIdentifierRemark> *) object{
    // TODO
}

-(CRSGeoReferenceFrame *) readGeoReferenceFrame{
    return nil; // TODO
}

-(CRSGeoReferenceFrame *) readGeoReferenceFrameWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSVerticalReferenceFrame *) readVerticalReferenceFrame{
    return nil; // TODO
}

-(CRSVerticalReferenceFrame *) readVerticalReferenceFrameWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSEngineeringDatum *) readEngineeringDatum{
    return nil; // TODO
}

-(CRSEngineeringDatum *) readEngineeringDatumWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSParametricDatum *) readParametricDatum{
    return nil; // TODO
}

-(CRSParametricDatum *) readParametricDatumWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSReferenceFrame *) readReferenceFrame{
    return nil; // TODO
}

-(CRSReferenceFrame *) readReferenceFrameWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSGeoDatumEnsemble *) readGeoDatumEnsemble{
    return nil; // TODO
}

-(CRSVerticalDatumEnsemble *) readVerticalDatumEnsemble{
    return nil; // TODO
}

-(CRSDatumEnsemble *) readDatumEnsemble{
    return nil; // TODO
}

-(CRSDatumEnsembleMember *) readDatumEnsembleMember{
    return nil; // TODO
}

-(CRSDynamic *) readDynamic{
    return nil; // TODO
}

-(CRSPrimeMeridian *) readPrimeMeridian{
    return nil; // TODO
}

-(CRSEllipsoid *) readEllipsoid{
    return nil; // TODO
}

-(CRSUnit *) readUnit{
    return nil; // TODO
}

-(CRSUnit *) readAngleUnit{
    return nil; // TODO
}

-(CRSUnit *) readLengthUnit{
    return nil; // TODO
}

-(CRSUnit *) readParametricUnit{
    return nil; // TODO
}

-(CRSUnit *) readScaleUnit{
    return nil; // TODO
}

-(CRSUnit *) readTimeUnit{
    return nil; // TODO
}

-(CRSUnit *) readUnitWithType: (enum CRSUnitType) type{
    return nil; // TODO
}

-(NSArray<CRSIdentifier *> *) readIdentifiers{
    return nil; // TODO
}

-(CRSIdentifier *) readIdentifier{
    return nil; // TODO
}

-(CRSCoordinateSystem *) readCoordinateSystem{
    return nil; // TODO
}

-(NSArray<CRSAxis *> *) readAxes{
    return nil; // TODO
}

-(NSArray<CRSAxis *> *) readAxesWithType: (enum CRSCoordinateSystemType) type{
    return nil; // TODO
}

-(CRSAxis *) readAxis{
    return nil; // TODO
}

-(CRSAxis *) readAxisWithType: (enum CRSCoordinateSystemType) type{
    return nil; // TODO
}

-(NSString *) readRemark{
    return nil; // TODO
}

-(NSArray<CRSUsage *> *) readUsages{
    return nil; // TODO
}

-(CRSUsage *) readUsage{
    return nil; // TODO
}

-(NSString *) readScope{
    return nil; // TODO
}

-(CRSExtent *) readExtent{
    return nil; // TODO
}

-(NSString *) readAreaDescription{
    return nil; // TODO
}

-(CRSGeographicBoundingBox *) readGeographicBoundingBox{
    return nil; // TODO
}

-(CRSVerticalExtent *) readVerticalExtent{
    return nil; // TODO
}

-(CRSTemporalExtent *) readTemporalExtent{
    return nil; // TODO
}

-(CRSMapProjection *) readMapProjection{
    return nil; // TODO
}

-(CRSOperationMethod *) readMethod{
    return nil; // TODO
}

-(NSArray<CRSOperationParameter *> *) readProjectedParameters{
    return nil; // TODO
}

-(NSArray<CRSOperationParameter *> *) readParametersWithType: (enum CRSType) type{
    return nil; // TODO
}

-(CRSOperationParameter *) readParameterWithType: (enum CRSType) type{
    return nil; // TODO
}

-(CRSTemporalDatum *) readTemporalDatum{
    return nil; // TODO
}

-(CRSDerivingConversion *) readDerivingConversion{
    return nil; // TODO
}

-(NSArray<CRSOperationParameter *> *) readDerivedParameters{
    return nil; // TODO
}

-(NSArray<CRSOperationParameter *> *) readParametersAndFilesWithType: (enum CRSType) type{
    return nil; // TODO
}

-(CRSOperationParameter *) readParameterFile{
    return nil; // TODO
}

-(NSArray<CRSOperationParameter *> *) readCoordinateOperationParameters{
    return nil; // TODO
}

-(NSString *) readVersion{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readSource{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readTarget{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readInterpolation{
    return nil; // TODO
}

-(CRSCoordinateReferenceSystem *) readCoordinateReferenceSystemWithKeyword: (enum CRSKeywordType) keyword{
    return nil; // TODO
}

-(double) readAccuracy{
    return -1; // TODO
}

-(NSArray<CRSOperationParameter *> *) readPointMotionOperationParameters{
    return nil; // TODO
}

-(CRSAbridgedCoordinateTransformation *) readAbridgedCoordinateTransformation{
    return nil; // TODO
}

-(NSArray<CRSOperationParameter *> *) readBoundParameters{
    return nil; // TODO
}

-(CRSGeoCoordinateReferenceSystem *) readGeoCompat{
    return nil; // TODO
}

-(CRSGeoCoordinateReferenceSystem *) readGeodeticCompat{
    return nil; // TODO
}

-(CRSGeoCoordinateReferenceSystem *) readGeographicCompat{
    return nil; // TODO
}

-(CRSGeoCoordinateReferenceSystem *) readGeoCompatWithType: (enum CRSType) expectedType{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedCompat{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedGeodeticCompat{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedGeographicCompat{
    return nil; // TODO
}

-(CRSProjectedCoordinateReferenceSystem *) readProjectedCompatWithType: (enum CRSType) expectedType{
    return nil; // TODO
}

+(void) addTransformParameters: (NSArray<NSDecimalNumber *> *) transform toMapProjection: (CRSMapProjection *) mapProjection{
    // TODO
}

-(CRSVerticalCoordinateReferenceSystem *) readVerticalCompat{
    return nil; // TODO
}

-(CRSEngineeringCoordinateReferenceSystem *) readEngineeringCompat{
    return nil; // TODO
}

-(CRSMapProjection *) readMapProjectionCompat{
    return nil; // TODO
}

-(CRSCoordinateSystem *) readCoordinateSystemCompatWithType: (enum CRSType) type andReferenceFrame: (CRSReferenceFrame *) datum{
    return nil; // TODO
}

-(CRSVerticalReferenceFrame *) readVerticalDatumCompat{
    return nil; // TODO
}

-(CRSVerticalReferenceFrame *) readVerticalDatumCompatWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSEngineeringDatum *) readEngineeringDatumCompat{
    return nil; // TODO
}

-(CRSEngineeringDatum *) readEngineeringDatumCompatWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(CRSReferenceFrame *) readDatumCompat{
    return nil; // TODO
}

-(CRSReferenceFrame *) readDatumCompatWithCRS: (CRSSimpleCoordinateReferenceSystem *) crs{
    return nil; // TODO
}

-(NSArray<NSDecimalNumber *> *) readToWGS84Compat{
    return nil; // TODO
}

-(NSDictionary<NSString *, NSObject *> *) readExtensionsCompat{
    return nil; // TODO
}

@end
