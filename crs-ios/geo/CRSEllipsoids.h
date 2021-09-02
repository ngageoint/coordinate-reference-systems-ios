//
//  CRSEllipsoids.h
//  crs-ios
//
//  Created by Brian Osborn on 9/2/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Common Ellipsoids
 */
enum CRSEllipsoidsType{
    CRS_ELLIPSOID_INTERNATIONAL,
    CRS_ELLIPSOID_BESSEL,
    CRS_ELLIPSOID_CLARKE_1866,
    CRS_ELLIPSOID_CLARKE_1880,
    CRS_ELLIPSOID_AIRY,
    CRS_ELLIPSOID_WGS60,
    CRS_ELLIPSOID_WGS66,
    CRS_ELLIPSOID_WGS72,
    CRS_ELLIPSOID_WGS84,
    CRS_ELLIPSOID_KRASSOVSKY,
    CRS_ELLIPSOID_EVEREST,
    CRS_ELLIPSOID_INTERNATIONAL_1967,
    CRS_ELLIPSOID_GRS80,
    CRS_ELLIPSOID_AUSTRALIAN,
    CRS_ELLIPSOID_MERIT,
    CRS_ELLIPSOID_SGS85,
    CRS_ELLIPSOID_IAU76,
    CRS_ELLIPSOID_APL4_9,
    CRS_ELLIPSOID_NWL9D,
    CRS_ELLIPSOID_MOD_AIRY,
    CRS_ELLIPSOID_ANDRAE,
    CRS_ELLIPSOID_AUST_SA,
    CRS_ELLIPSOID_GRS67,
    CRS_ELLIPSOID_BESS_NAM,
    CRS_ELLIPSOID_CPM,
    CRS_ELLIPSOID_DELMBR,
    CRS_ELLIPSOID_ENGELIS,
    CRS_ELLIPSOID_EVRST48,
    CRS_ELLIPSOID_EVRST56,
    CRS_ELLIPSOID_EVRTS69,
    CRS_ELLIPSOID_EVRTSTSS,
    CRS_ELLIPSOID_FRSCH60,
    CRS_ELLIPSOID_FSRCH60M,
    CRS_ELLIPSOID_FSCHR68,
    CRS_ELLIPSOID_HELMERT,
    CRS_ELLIPSOID_HOUGH,
    CRS_ELLIPSOID_KAULA,
    CRS_ELLIPSOID_LERCH,
    CRS_ELLIPSOID_MPRTS,
    CRS_ELLIPSOID_PLESSIS,
    CRS_ELLIPSOID_SEASIA,
    CRS_ELLIPSOID_WALBECK,
    CRS_ELLIPSOID_NAD27,
    CRS_ELLIPSOID_NAD83,
    CRS_ELLIPSOID_SPHERE
};

/**
 * Ellipsoids
 */
@interface CRSEllipsoids : NSObject

/**
 * Get a predefined proj4 ellipsoid by type
 *
 * @param type
 *            ellipsoid type
 * @return ellipsoid
 */
+(CRSEllipsoids *) fromType: (enum CRSEllipsoidsType) type;

/**
 * Get a predefined proj4 ellipsoid by name or short name
 *
 * @param name
 *            name or short name
 * @return ellipsoid or nil
 */
+(CRSEllipsoids *) fromName: (NSString *) name;

/**
 * Get the type
 *
 * @return type
 */
-(enum CRSEllipsoidsType) type;

/**
 * Get the name
 *
 * @return name
 */
-(NSString *) name;

/**
 * Get the names
 *
 * @return names
 */
-(NSArray<NSString *> *) names;

/**
 * Get the short name
 *
 * @return short name
 */
-(NSString *) shortName;

/**
 * Get the equator radius
 *
 * @return equator radius
 */
-(double) equatorRadius;

/**
 * Get the a
 *
 * @return a
 */
-(double) a;

/**
 * Get the b
 *
 * @return b
 */
-(double) b;

/**
 * Get the eccentricity squared
 *
 * @return eccentricity squared
 */
-(double) eccentricitySquared;

/**
 * Ellipsoid equator radius and eccentricity squared equality comparison
 *
 * @param ellipsoid
 *            ellipsoid
 * @return true if equal
 */
-(BOOL) isEqualToEllipsoid: (CRSEllipsoids *) ellipsoid;

/**
 * Ellipsoid equator radius and eccentricity squared within tolerance equality comparison
 *
 * @param ellipsoid
 *            ellipsoid
 * @param e2Tolerance
 *            eccentricity squared tolerance
 * @return true if equal
 */
-(BOOL) isEqualToEllipsoid: (CRSEllipsoids *) ellipsoid withTolerance: (double) e2Tolerance;

@end
