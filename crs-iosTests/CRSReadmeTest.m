//
//  CRSReadmeTest.m
//  crs-iosTests
//
//  Created by Brian Osborn on 7/12/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSReadmeTest.h"
#import "CRSTestUtils.h"
@import CoordinateReferenceSystems;

@implementation CRSReadmeTest

/**
 * Test crs
 */
-(void) testCRS{
    
    NSMutableString *wkt = [NSMutableString string];
    [wkt appendString:@"GEOGCRS[\"WGS 84\",ENSEMBLE[\"World Geodetic System 1984 ensemble\","];
    [wkt appendString:@"MEMBER[\"World Geodetic System 1984 (Transit)\",ID[\"EPSG\",1166]],"];
    [wkt appendString:@"MEMBER[\"World Geodetic System 1984 (G730)\",ID[\"EPSG\",1152]],"];
    [wkt appendString:@"MEMBER[\"World Geodetic System 1984 (G873)\",ID[\"EPSG\",1153]],"];
    [wkt appendString:@"MEMBER[\"World Geodetic System 1984 (G1150)\",ID[\"EPSG\",1154]],"];
    [wkt appendString:@"MEMBER[\"World Geodetic System 1984 (G1674)\",ID[\"EPSG\",1155]],"];
    [wkt appendString:@"MEMBER[\"World Geodetic System 1984 (G1762)\",ID[\"EPSG\",1156]],"];
    [wkt appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,ID[\"EPSG\",7030]],"];
    [wkt appendString:@"ENSEMBLEACCURACY[2],ID[\"EPSG\",6326]],"];
    [wkt appendString:@"CS[ellipsoidal,2,ID[\"EPSG\",6422]],"];
    [wkt appendString:@"AXIS[\"Geodetic latitude (Lat)\",north],AXIS[\"Geodetic longitude (Lon)\",east],"];
    [wkt appendString:@"ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]],"];
    [wkt appendString:@"ID[\"EPSG\",4326]]"];;
    
    [CRSTestUtils assertEqualWithValue:wkt andValue2:[self testCRSWithText:wkt]];
    
    [CRSTestUtils assertEqualWithValue:@"+proj=longlat +datum=WGS84 +no_defs" andValue2:[self testProjWithText:wkt]];
    
}

/**
 * Test crs
 *
 * @param wkt
 *            crs well-known text
 * @return well-known text
 */
-(NSString *) testCRSWithText: (NSString *) wkt{
    
    // NSString *wkt = ...

    CRSObject *crs = [CRSReader read:wkt];

    CRSType type = crs.type;
    CRSCategoryType category = crs.categoryType;

    NSString *text = [CRSWriter write:crs];
    NSString *prettyText = [CRSWriter writePretty:crs];

    switch(category){

        case CRS_CATEGORY_CRS:
        {
            CRSCoordinateReferenceSystem *coordRefSys = (CRSCoordinateReferenceSystem *) crs;

            switch (type) {
                case CRS_TYPE_BOUND:
                {
                    CRSBoundCoordinateReferenceSystem *bound = (CRSBoundCoordinateReferenceSystem *) coordRefSys;
                    // ...
                    break;
                }
                case CRS_TYPE_COMPOUND:
                {
                    CRSCompoundCoordinateReferenceSystem *compound = (CRSCompoundCoordinateReferenceSystem *) coordRefSys;
                    // ...
                    break;
                }
                case CRS_TYPE_DERIVED:
                {
                    CRSDerivedCoordinateReferenceSystem *derived = (CRSDerivedCoordinateReferenceSystem *) coordRefSys;
                    // ...
                    break;
                }
                case CRS_TYPE_ENGINEERING:
                {
                    CRSEngineeringCoordinateReferenceSystem *engineering = (CRSEngineeringCoordinateReferenceSystem *) coordRefSys;
                    // ...
                    break;
                }
                case CRS_TYPE_GEODETIC:
                case CRS_TYPE_GEOGRAPHIC:
                {
                    CRSGeoCoordinateReferenceSystem *geo = (CRSGeoCoordinateReferenceSystem *) coordRefSys;
                    // ...
                    break;
                }
                case CRS_TYPE_PARAMETRIC:
                {
                    CRSParametricCoordinateReferenceSystem *parametric = (CRSParametricCoordinateReferenceSystem *) coordRefSys;
                    // ...
                    break;
                }
                case CRS_TYPE_PROJECTED:
                {
                    CRSProjectedCoordinateReferenceSystem *projected = (CRSProjectedCoordinateReferenceSystem *) coordRefSys;
                    // ...
                    break;
                }
                case CRS_TYPE_TEMPORAL:
                {
                    CRSTemporalCoordinateReferenceSystem *temporal = (CRSTemporalCoordinateReferenceSystem *) coordRefSys;
                    // ...
                    break;
                }
                case CRS_TYPE_VERTICAL:
                {
                    CRSVerticalCoordinateReferenceSystem *vertical = (CRSVerticalCoordinateReferenceSystem *) coordRefSys;
                    // ...
                    break;
                }
                default:
                    break;
            }

            // ...
            break;
        }
            
        case CRS_CATEGORY_METADATA:
        {

            CRSCoordinateMetadata *metadata = (CRSCoordinateMetadata *) crs;

            // ...
            break;
        }

        case CRS_CATEGORY_OPERATION:
        {

            CRSOperation *operation = (CRSOperation *) crs;

            switch (type) {
                case CRS_TYPE_CONCATENATED_OPERATION:
                {
                    CRSConcatenatedOperation *concatenatedOperation = (CRSConcatenatedOperation *) operation;
                    // ...
                    break;
                }
                case CRS_TYPE_COORDINATE_OPERATION:
                {
                    CRSCoordinateOperation *coordinateOperation = (CRSCoordinateOperation *) operation;
                    // ...
                    break;
                }
                case CRS_TYPE_POINT_MOTION_OPERATION:
                {
                    CRSPointMotionOperation *pointMotionOperation = (CRSPointMotionOperation *) operation;
                    // ...
                    break;
                }
                default:
                    break;
            }

            // ...
            break;

        }
            
    }
     
    return text;
}

/**
 * Test proj
 *
 * @param wkt
 *            crs well-known text
 * @return PROJ text
 */
-(NSString *) testProjWithText: (NSString *) wkt{
    
    // NSString *wkt = ...
    
    CRSObject *crs = [CRSReader read:wkt];
    
    CRSProjParams *projParamsFromCRS = [CRSProjParser paramsFromCRS:crs];
    NSString *projTextFromCRS = [CRSProjParser paramsTextFromCRS:crs];
    CRSProjParams *projParamsFromWKT = [CRSProjParser paramsFromText:wkt];
    NSString *projTextFromWKT = [CRSProjParser paramsTextFromText:wkt];
    
    return projTextFromWKT;
}

@end
