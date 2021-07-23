//
//  CRSWriter.h
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRSObject.h"
#import "CRSKeyword.h"
#import "CRSReferenceFrame.h"
#import "CRSDatumEnsemble.h"
#import "CRSDatumEnsembleMember.h"
#import "CRSDynamic.h"
#import "CRSPrimeMeridian.h"
#import "CRSEllipsoid.h"
#import "CRSUnit.h"
#import "CRSIdentifier.h"
#import "CRSCoordinateSystem.h"
#import "CRSAxis.h"
#import "CRSUsage.h"
#import "CRSExtent.h"
#import "CRSGeographicBoundingBox.h"
#import "CRSVerticalExtent.h"
#import "CRSTemporalExtent.h"
#import "CRSMapProjection.h"
#import "CRSOperationMethod.h"
#import "CRSOperationParameter.h"
#import "CRSTemporalDatum.h"
#import "CRSDerivingConversion.h"
#import "CRSAbridgedCoordinateTransformation.h"

/**
 * Well-Known Text writer
 */
@interface CRSWriter : NSObject

/**
 * Write a coordinate reference system to well-known text
 *
 * @param crs
 *            coordinate reference system
 * @return well-known text
 */
+(NSString *) write: (CRSObject *) crs;

/**
 * Write a coordinate reference system to well-known pretty text, 4 space
 * indents
 *
 * @param crs
 *            coordinate reference system
 * @return well-known pretty text
 */
+(NSString *) writePretty: (CRSObject *) crs;

/**
 * Write a coordinate reference system to well-known pretty text, tab
 * indents
 *
 * @param crs
 *            coordinate reference system
 * @return well-known pretty text
 */
+(NSString *) writePrettyTabIndent: (CRSObject *) crs;

/**
 * Write a coordinate reference system to well-known pretty text, no indents
 *
 * @param crs
 *            coordinate reference system
 * @return well-known pretty text
 */
+(NSString *) writePrettyNoIndent: (CRSObject *) crs;

/**
 * Write a coordinate reference system to well-known pretty text
 *
 * @param crs
 *            coordinate reference system
 * @param indent
 *            indent string
 * @return well-known pretty text
 */
+(NSString *) writePretty: (CRSObject *) crs withIndent: (NSString *) indent;

/**
 * Write a coordinate reference system to well-known pretty text
 *
 * @param crs
 *            coordinate reference system
 * @param newline
 *            newline string
 * @param indent
 *            indent string
 * @return well-known pretty text
 */
+(NSString *) writePretty: (CRSObject *) crs withNewline: (NSString *) newline andIndent: (NSString *) indent;

/**
 * Write well-known text to well-known pretty text, 4 space indents
 *
 * @param wkt
 *            well-known text
 * @return well-known pretty text
 */
+(NSString *) writePrettyWithText: (NSString *) wkt;

/**
 * Write well-known text to well-known pretty text, tab indents
 *
 * @param wkt
 *            well-known text
 * @return well-known pretty text
 */
+(NSString *) writePrettyTabIndentWithText: (NSString *) wkt;

/**
 * Write well-known text to well-known pretty text, no indents
 *
 * @param wkt
 *            well-known text
 * @return well-known pretty text
 */
+(NSString *) writePrettyNoIndentWithText: (NSString *) wkt;

/**
 * Write well-known text to well-known pretty text
 *
 * @param wkt
 *            well-known text
 * @param indent
 *            indent string
 * @return well-known pretty text
 */
+(NSString *) writePrettyWithText: (NSString *) wkt andIndent: (NSString *) indent;

/**
 * Write well-known text to well-known pretty text
 *
 * @param wkt
 *            well-known text
 * @param newline
 *            newline string
 * @param indent
 *            indent string
 * @return well-known pretty text
 */
+(NSString *) writePrettyWithText: (NSString *) wkt andNewline: (NSString *) newline andIndent: (NSString *) indent;

/**
 *  Create
 *
 *  @return new instance
 */
+(CRSWriter *) create;

/**
 *  Initialize
 *
 *  @return new instance
 */
-(instancetype) init;

/**
 * Initializer
 *
 * @param text  mutable string
 */
-(instancetype) initWithText: (NSMutableString *) text;

/**
 * Get the well-known text
 *
 * @return text
 */
-(NSMutableString *) text;

/**
 * Write a CRS to well-known text
 *
 * @param crs
 *            coordinate reference system
 */
-(void) writeCRS: (CRSObject *) crs;

/**
 * Write a keyword type
 *
 * @param keyword
 *            keyword type
 */
-(void) writeKeywordType: (enum CRSKeywordType) keyword;

/**
 * Write a keyword
 *
 * @param keyword
 *            keyword
 */
-(void) writeKeyword: (CRSKeyword *) keyword;

/**
 * Write a left delimiter
 */
-(void) writeLeftDelimiter;

/**
 * Write a right delimiter
 */
-(void) writeRightDelimiter;

/**
 * Write a separator
 */
-(void) writeSeparator;

/**
 * Write the text as quoted
 *
 * @param text
 *            text
 */
-(void) writeQuotedText: (NSString *) text;

/**
 * Write a number
 *
 * @param number
 *            number
 */
-(void) writeNumber: (NSNumber *) number;

/**
 * Write a number or quoted text if not a number
 *
 * @param text
 *            text
 */
-(void) writeNumberOrQuotedText: (NSString *) text;

/**
 * Write a keyword type delimited text
 *
 * @param keyword
 *            keyword type
 * @param text
 *            text
 */
-(void) writeKeywordType: (enum CRSKeywordType) keyword withDelimitedQuotedText: (NSString *) text;

/**
 * Write a keyword delimited text
 *
 * @param keyword
 *            keyword
 * @param text
 *            text
 */
-(void) writeKeyword: (CRSKeyword *) keyword withDelimitedQuotedText: (NSString *) text;

/**
 * Write a reference frame to well-known text
 *
 * @param referenceFrame
 *            reference frame
 */
-(void) writeReferenceFrame: (CRSReferenceFrame *) referenceFrame;

/**
 * Write a datum ensemble to well-known text
 *
 * @param datumEnsemble
 *            datum ensemble
 */
-(void) writeDatumEnsemble: (CRSDatumEnsemble *) datumEnsemble;

/**
 * Write a datum ensemble member to well-known text
 *
 * @param datumEnsembleMember
 *            datum ensemble member
 */
-(void) writeDatumEnsembleMember: (CRSDatumEnsembleMember *) datumEnsembleMember;

/**
 * Write a dynamic to well-known text
 *
 * @param dynamic
 *            dynamic
 */
-(void) writeDynamic: (CRSDynamic *) dynamic;

/**
 * Write a prime meridian to well-known text
 *
 * @param primeMeridian
 *            prime meridian
 */
-(void) writePrimeMeridian: (CRSPrimeMeridian *) primeMeridian;

/**
 * Write an ellipsoid to well-known text
 *
 * @param ellipsoid
 *            ellipsoid
 */
-(void) writeEllipsoid: (CRSEllipsoid *) ellipsoid;

/**
 * Write a unit to well-known text
 *
 * @param unit
 *            unit
 */
-(void) writeUnit: (CRSUnit *) unit;

/**
 * Write an identifier to well-known text
 *
 * @param identifier
 *            identifier
 */
-(void) writeIdentifier: (CRSIdentifier *) identifier;

/**
 * Write a coordinate system to well-known text
 *
 * @param coordinateSystem
 *            coordinate system
 */
-(void) writeCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem;

/**
 * Write an axis to well-known text
 *
 * @param axis
 *            axis
 */
-(void) writeAxis: (CRSAxis *) axis;

/**
 * Write a usage to well-known text
 *
 * @param usage
 *            usage
 */
-(void) writeUsage: (CRSUsage *) usage;

/**
 * Write an extent to well-known text
 *
 * @param extent
 *            extent
 */
-(void) writeExtent: (CRSExtent *) extent;

/**
 * Write a geographic bounding box to well-known text
 *
 * @param geographicBoundingBox
 *            geographic bounding box
 */
-(void) writeGeographicBoundingBox: (CRSGeographicBoundingBox *) geographicBoundingBox;

/**
 * Write a vertical extent to well-known text
 *
 * @param verticalExtent
 *            vertical extent
 */
-(void) writeVerticalExtent: (CRSVerticalExtent *) verticalExtent;

/**
 * Write a temporal extent to well-known text
 *
 * @param temporalExtent
 *            temporal extent
 */
-(void) writeTemporalExtent: (CRSTemporalExtent *) temporalExtent;

/**
 * Write a map projection to well-known text
 *
 * @param mapProjection
 *            map projection
 */
-(void) writeMapProjection: (CRSMapProjection *) mapProjection;

/**
 * Write an operation method to well-known text
 *
 * @param method
 *            operation method
 */
-(void) writeOperationMethod: (CRSOperationMethod *) operationMethod;

/**
 * Write an operation parameter to well-known text
 *
 * @param parameter
 *            operation parameter
 */
-(void) writeOperationParameter: (CRSOperationParameter *) operationParameter;

/**
 * Write a temporal datum to well-known text
 *
 * @param temporalDatum
 *            temporal datum
 */
-(void) writeTemporalDatum: (CRSTemporalDatum *) temporalDatum;

/**
 * Write a deriving conversion to well-known text
 *
 * @param derivingConversion
 *            deriving conversion
 */
-(void) writeDerivingConversion: (CRSDerivingConversion *) derivingConversion;

/**
 * Write an abridged coordinate transformation
 *
 * @param transformation
 *            abridged coordinate transformation
 */
-(void) writeAbridgedCoordinateTransformation: (CRSAbridgedCoordinateTransformation *) transformation;

@end
