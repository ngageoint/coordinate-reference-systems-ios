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
    return [self read:text withStrict:NO];
}

+(CRSObject *) read: (NSString *) text withStrict: (BOOL) strict{
    CRSReader *reader = [CRSReader createWithText:text andStrict:strict];
    CRSObject *crs = [reader read];
    [reader readEnd];
    return crs;
}

+(CRSObject *) read: (NSString *) text withType: (enum CRSType) expected{
    return [self read:text withStrict:NO andType:expected];
}

+(CRSObject *) read: (NSString *) text withTypes: (NSArray<NSNumber *> *) expected{
    return [self read:text withStrict:NO andTypes:expected];
}

+(CRSObject *) read: (NSString *) text withStrict: (BOOL) strict andType: (enum CRSType) expected{
    return [self read:text withStrict:strict andTypes:[NSArray arrayWithObject:[NSNumber numberWithInt:expected]]];
}

+(CRSObject *) read: (NSString *) text withStrict: (BOOL) strict andTypes: (NSArray<NSNumber *> *) expected{
    CRSObject *crs = [self read:text withStrict:strict];
    if(![expected containsObject:[NSNumber numberWithInt:crs.type]]){
        [NSException raise:@"Unexpected CRS Type" format:@"Unexpected Coordinate Reference System Type: %@, Expected: %@", [CRSTypes name:crs.type], [CRSTypes names:expected]];
    }
    return crs;
}

+(CRSCoordinateReferenceSystem *) readCoordinateReferenceSystem: (NSString *) text{
    return [self readCoordinateReferenceSystem:text withStrict:NO];
}

+(CRSCoordinateReferenceSystem *) readCoordinateReferenceSystem: (NSString *) text withStrict: (BOOL) strict{
    return (CRSCoordinateReferenceSystem *) [self read:text withStrict:strict andTypes:[NSArray arrayWithObjects:
                                                                                        [NSNumber numberWithInt:CRS_TYPE_GEODETIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_GEOGRAPHIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_PROJECTED],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_VERTICAL],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_ENGINEERING],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_PARAMETRIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_TEMPORAL],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_DERIVED],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_COMPOUND],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_BOUND],
                                                                                        nil]];
}

+(CRSSimpleCoordinateReferenceSystem *) readSimpleCoordinateReferenceSystem: (NSString *) text{
    return [self readSimpleCoordinateReferenceSystem:text withStrict:NO];
}

+(CRSSimpleCoordinateReferenceSystem *) readSimpleCoordinateReferenceSystem: (NSString *) text withStrict: (BOOL) strict{
    return (CRSSimpleCoordinateReferenceSystem *) [self read:text withStrict:strict andTypes:[NSArray arrayWithObjects:
                                                                                        [NSNumber numberWithInt:CRS_TYPE_GEODETIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_GEOGRAPHIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_PROJECTED],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_VERTICAL],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_ENGINEERING],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_PARAMETRIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_TEMPORAL],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_DERIVED],
                                                                                        nil]];
}

+(CRSGeoCoordinateReferenceSystem *) readGeo: (NSString *) text{
    return (CRSGeoCoordinateReferenceSystem *) [self read:text withTypes:[NSArray arrayWithObjects:
                                                                                        [NSNumber numberWithInt:CRS_TYPE_GEODETIC],
                                                                                        [NSNumber numberWithInt:CRS_TYPE_GEOGRAPHIC],
                                                                                        nil]];
}

+(CRSGeoCoordinateReferenceSystem *) readGeodetic: (NSString *) text{
    return (CRSGeoCoordinateReferenceSystem *) [self read:text withType:CRS_TYPE_GEODETIC];
}

+(CRSGeoCoordinateReferenceSystem *) readGeographic: (NSString *) text{
    return (CRSGeoCoordinateReferenceSystem *) [self read:text  withType:CRS_TYPE_GEOGRAPHIC];
}

+(CRSProjectedCoordinateReferenceSystem *) readProjected: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSProjectedCoordinateReferenceSystem *crs = [reader readProjected];
    [reader readEnd];
    return crs;
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedGeodetic: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSProjectedCoordinateReferenceSystem *crs = [reader readProjectedGeodetic];
    [reader readEnd];
    return crs;
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedGeographic: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSProjectedCoordinateReferenceSystem *crs = [reader readProjectedGeographic];
    [reader readEnd];
    return crs;
}

+(CRSVerticalCoordinateReferenceSystem *) readVertical: (NSString *) text{
    return (CRSVerticalCoordinateReferenceSystem *) [self read:text withType:CRS_TYPE_VERTICAL];
}

+(CRSEngineeringCoordinateReferenceSystem *) readEngineering: (NSString *) text{
    return (CRSEngineeringCoordinateReferenceSystem *) [self read:text withType:CRS_TYPE_ENGINEERING];
}

+(CRSParametricCoordinateReferenceSystem *) readParametric: (NSString *) text{
    return (CRSParametricCoordinateReferenceSystem *) [self read:text withType:CRS_TYPE_PARAMETRIC];
}

+(CRSTemporalCoordinateReferenceSystem *) readTemporal: (NSString *) text{
    return (CRSTemporalCoordinateReferenceSystem *) [self read:text withType:CRS_TYPE_TEMPORAL];
}

+(CRSDerivedCoordinateReferenceSystem *) readDerived: (NSString *) text{
    return (CRSDerivedCoordinateReferenceSystem *) [self read:text withType:CRS_TYPE_DERIVED];
}

+(CRSCompoundCoordinateReferenceSystem *) readCompound: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSCompoundCoordinateReferenceSystem *crs = [reader readCompound];
    [reader readEnd];
    return crs;
}

+(CRSCoordinateMetadata *) readCoordinateMetadata: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSCoordinateMetadata *metadata = [reader readCoordinateMetadata];
    [reader readEnd];
    return metadata;
}

+(CRSCoordinateOperation *) readCoordinateOperation: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSCoordinateOperation *operation = [reader readCoordinateOperation];
    [reader readEnd];
    return operation;
}

+(CRSPointMotionOperation *) readPointMotionOperation: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSPointMotionOperation *operation = [reader readPointMotionOperation];
    [reader readEnd];
    return operation;
}

+(CRSConcatenatedOperation *) readConcatenatedOperation: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSConcatenatedOperation *operation = [reader readConcatenatedOperation];
    [reader readEnd];
    return operation;
}

+(CRSBoundCoordinateReferenceSystem *) readBound: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSBoundCoordinateReferenceSystem *crs = [reader readBound];
    [reader readEnd];
    return crs;
}

+(CRSGeoCoordinateReferenceSystem *) readGeoCompat: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSGeoCoordinateReferenceSystem *crs = [reader readGeoCompat];
    [reader readEnd];
    return crs;
}

+(CRSGeoCoordinateReferenceSystem *) readGeodeticCompat: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSGeoCoordinateReferenceSystem *crs = [reader readGeodeticCompat];
    [reader readEnd];
    return crs;
}

+(CRSGeoCoordinateReferenceSystem *) readGeographicCompat: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSGeoCoordinateReferenceSystem *crs = [reader readGeographicCompat];
    [reader readEnd];
    return crs;
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedCompat: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSProjectedCoordinateReferenceSystem *crs = [reader readProjectedCompat];
    [reader readEnd];
    return crs;
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedGeodeticCompat: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSProjectedCoordinateReferenceSystem *crs = [reader readProjectedGeodeticCompat];
    [reader readEnd];
    return crs;
}

+(CRSProjectedCoordinateReferenceSystem *) readProjectedGeographicCompat: (NSString *) text{
    CRSReader *reader = [CRSReader createWithText:text];
    CRSProjectedCoordinateReferenceSystem *crs = [reader readProjectedGeographicCompat];
    [reader readEnd];
    return crs;
}

+(CRSReader *) createWithText: (NSString *) text{
    return [[CRSReader alloc] initWithText:text];
}

+(CRSReader *) createWithReader: (CRSTextReader *) reader{
    return [[CRSReader alloc] initWithReader:reader];
}

+(CRSReader *) createWithText: (NSString *) text andStrict: (BOOL) strict{
    return [[CRSReader alloc] initWithText:text andStrict:strict];
}

+(CRSReader *) createWithReader: (CRSTextReader *) reader andStrict: (BOOL) strict{
    return [[CRSReader alloc] initWithReader:reader andStrict:strict];
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

    CRSObject *crs = nil;
    
    enum CRSKeywordType keyword = [self peekKeyword];
    switch(keyword){
        case CRS_KEYWORD_GEODCRS:
        case CRS_KEYWORD_GEOGCRS:
            crs = [self readGeo];
            break;
        case CRS_KEYWORD_GEOCCS:
        case CRS_KEYWORD_GEOGCS:
            crs = [self readGeoCompat];
            break;
        case CRS_KEYWORD_PROJCRS:
            crs = [self readProjected];
            break;
        case CRS_KEYWORD_PROJCS:
            crs = [self readProjectedCompat];
            break;
        case CRS_KEYWORD_VERTCRS:
            crs = [self readVertical];
            break;
        case CRS_KEYWORD_VERT_CS:
            crs = [self readVerticalCompat];
            break;
        case CRS_KEYWORD_ENGCRS:
            crs = [self readEngineering];
            break;
        case CRS_KEYWORD_LOCAL_CS:
            crs = [self readEngineeringCompat];
            break;
        case CRS_KEYWORD_PARAMETRICCRS:
            crs = [self readParametric];
            break;
        case CRS_KEYWORD_TIMECRS:
            crs = [self readTemporal];
            break;
        case CRS_KEYWORD_DERIVEDPROJCRS:
            crs = [self readDerivedProjected];
            break;
        case CRS_KEYWORD_COMPOUNDCRS:
            crs = [self readCompound];
            break;
        case CRS_KEYWORD_COORDINATEMETADATA:
            crs = [self readCoordinateMetadata];
            break;
        case CRS_KEYWORD_COORDINATEOPERATION:
            crs = [self readCoordinateOperation];
            break;
        case CRS_KEYWORD_POINTMOTIONOPERATION:
            crs = [self readPointMotionOperation];
            break;
        case CRS_KEYWORD_CONCATENATEDOPERATION:
            crs = [self readConcatenatedOperation];
            break;
        case CRS_KEYWORD_BOUNDCRS:
            crs = [self readBound];
            break;
        default:
            [NSException raise:@"Unsupported Keyword" format:@"Unsupported WKT CRS keyword: %@", [CRSKeyword keywordOfType:keyword].name];
    }

    return crs;
}

-(CRSCoordinateReferenceSystem *) readCoordinateReferenceSystem{
    CRSObject *crs = [self read];
    if(![crs isKindOfClass:[CRSCoordinateReferenceSystem class]]){
        [NSException raise:@"Unexpected CRS Type" format:@"Unexpected Coordinate Reference System Type: %@", [CRSTypes name:crs.type]];
    }
    return (CRSCoordinateReferenceSystem *) crs;
}

-(CRSSimpleCoordinateReferenceSystem *) readSimpleCoordinateReferenceSystem{
    CRSObject *crs = [self read];
    if(![crs isKindOfClass:[CRSSimpleCoordinateReferenceSystem class]]){
        [NSException raise:@"Unexpected CRS Type" format:@"Unexpected Simple Coordinate Reference System Type: %@", [CRSTypes name:crs.type]];
    }
    return (CRSSimpleCoordinateReferenceSystem *) crs;
}

-(enum CRSKeywordType) readKeyword{
    return [CRSKeyword requiredType:[_reader readToken]];
}

-(NSArray<NSNumber *> *) readKeywords{
    return [CRSKeyword requiredTypes:[_reader readToken]];
}

-(enum CRSKeywordType) readKeywordWithType: (enum CRSKeywordType) keyword{
    return [self readKeywordWithType:keyword andRequired:YES];
}

-(enum CRSKeywordType) readKeywordWithTypes: (NSArray<NSNumber *> *) keywords{
    return [self readKeywordWithTypes:keywords andRequired:YES];
}

-(enum CRSKeywordType) readToKeyword: (enum CRSKeywordType) keyword{
    return [self readToKeywords:[NSArray arrayWithObject:[NSNumber numberWithInt:keyword]]];
}

-(enum CRSKeywordType) readToKeywords: (NSArray<NSNumber *> *) keywords{
    enum CRSKeywordType keyword = [self readKeywordWithTypes:keywords andRequired:NO];
    if(keyword != -1){
        [_reader pushToken:[CRSKeyword keywordOfType:keyword].name]; // TODO keyword object?
    }
    return keyword;
}

-(enum CRSKeywordType) readKeywordWithType: (enum CRSKeywordType) keyword andRequired: (BOOL) required{
    return [self readKeywordWithTypes:[NSArray arrayWithObject:[NSNumber numberWithInt:keyword]] andRequired:required];
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
