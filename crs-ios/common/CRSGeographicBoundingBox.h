//
//  CRSGeographicBoundingBox.h
//  crs-ios
//
//  Created by Brian Osborn on 7/13/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Geographic Bounding Box
 */
@interface CRSGeographicBoundingBox : NSObject

/**
 *  Lower Left Latitude
 */
@property (nonatomic) double lowerLeftLatitude;

/**
 *  Lower Left Longitude
 */
@property (nonatomic) double lowerLeftLongitude;

/**
 *  Upper Right Latitude
 */
@property (nonatomic) double upperRightLatitude;

/**
 *  Upper Right Longitude
 */
@property (nonatomic) double upperRightLongitude;

/**
 *  Initialize
 *
 *  @return new instance
 */
-(instancetype) init;

/**
 *  Initialize
 *
 * @param lowerLeftLatitude
 *            lower left latitude
 * @param lowerLeftLongitude
 *            lower left longitude
 * @param upperRightLatitude
 *            upper right latitude
 * @param upperRightLongitude
 *            upper right longitude
 *
 *  @return new instance
 */
-(instancetype) initWithLowerLeftLatitude: (double) lowerLeftLatitude
                    andLowerLeftLongitude: (double) lowerLeftLongitude
                    andUpperRightLatitude: (double) upperRightLatitude
                   andUpperRightLongitude: (double) upperRightLongitude;

@end
