//
//  CRSUnit.h
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRSIdentifiable.h"
#import "CRSUnitTypes.h"

/**
 * Unit
 */
@interface CRSUnit : NSObject<CRSIdentifiable>

/**
 *  Unit Type
 */
@property (nonatomic) enum CRSUnitType type;

/**
 *  Name
 */
@property (nonatomic, strong) NSString *name;

/**
 *  Conversion Factor
 */
@property (nonatomic, strong) NSDecimalNumber *conversionFactor;

/**
 * Identifiers
 */
@property (nonatomic, strong) NSMutableArray<CRSIdentifier *> *identifiers;

/**
 *  Create
 *
 *  @return new instance
 */
+(CRSUnit *) create;

/**
 *  Initialize
 *
 *  @return new instance
 */
-(instancetype) init;

/**
 *  Initialize
 *
 * @param type
 *            unit type
 * @param name
 *            name
 *
 *  @return new instance
 */
-(instancetype) initWithType: (enum CRSUnitType) type andName: (NSString *) name;

/**
 *  Initialize
 *
 * @param type
 *            unit type
 * @param name
 *            name
 * @param conversionFactor
 *            conversion factor
 *
 *  @return new instance
 */
-(instancetype) initWithType: (enum CRSUnitType) type andName: (NSString *) name andConversionFactor: (double) conversionFactor;

/**
 * Has a conversion factor
 *
 * @return true if has conversion factor
 */
-(BOOL) hasConversionFactor;

@end
