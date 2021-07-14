//
//  CRSWriter.h
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRSObject.h"
#import "CRSUnit.h"
#import "CRSIdentifier.h"
#import "CRSUsage.h"
#import "CRSExtent.h"
#import "CRSGeographicBoundingBox.h"
#import "CRSVerticalExtent.h"
#import "CRSTemporalExtent.h"

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

@end
