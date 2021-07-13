//
//  CRSWriter.h
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRSUnit.h"
#import "CRSIdentifier.h"
#import "CRSGeographicBoundingBox.h"
#import "CRSVerticalExtent.h"

/**
 * Well-Known Text writer
 */
@interface CRSWriter : NSObject

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

@end
