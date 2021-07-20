//
//  CRSWriter.h
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRSObject.h"
#import "CRSReferenceFrame.h"
#import "CRSDatumEnsemble.h"
#import "CRSDatumEnsembleMember.h"
#import "CRSDynamic.h"
#import "CRSUnit.h"
#import "CRSIdentifier.h"
#import "CRSCoordinateSystem.h"
#import "CRSAxis.h"
#import "CRSUsage.h"
#import "CRSExtent.h"
#import "CRSGeographicBoundingBox.h"
#import "CRSVerticalExtent.h"
#import "CRSTemporalExtent.h"
#import "CRSOperationMethod.h"
#import "CRSOperationParameter.h"
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
