//
//  CRSSwiftReadmeTest.swift
//  crs-iosTests
//
//  Created by Brian Osborn on 7/12/21.
//  Copyright © 2021 NGA. All rights reserved.
//

import XCTest

/**
* README example tests
*/
class CRSSwiftReadmeTest: XCTestCase{
    
    /**
     * Test crs
     */
    func testCRS(){
        
        let wkt: String = "GEOGCRS[\"WGS 84\",ENSEMBLE[\"World Geodetic System 1984 ensemble\","
            + "MEMBER[\"World Geodetic System 1984 (Transit)\",ID[\"EPSG\",1166]],"
            + "MEMBER[\"World Geodetic System 1984 (G730)\",ID[\"EPSG\",1152]],"
            + "MEMBER[\"World Geodetic System 1984 (G873)\",ID[\"EPSG\",1153]],"
            + "MEMBER[\"World Geodetic System 1984 (G1150)\",ID[\"EPSG\",1154]],"
            + "MEMBER[\"World Geodetic System 1984 (G1674)\",ID[\"EPSG\",1155]],"
            + "MEMBER[\"World Geodetic System 1984 (G1762)\",ID[\"EPSG\",1156]],"
            + "ELLIPSOID[\"WGS 84\",6378137,298.257223563,ID[\"EPSG\",7030]],"
            + "ENSEMBLEACCURACY[2],ID[\"EPSG\",6326]],"
            + "CS[ellipsoidal,2,ID[\"EPSG\",6422]],"
            + "AXIS[\"Geodetic latitude (Lat)\",north],AXIS[\"Geodetic longitude (Lon)\",east],"
            + "ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]],"
            + "ID[\"EPSG\",4326]]"
        
        CRSTestUtils.assertEqual(withValue: wkt as NSObject, andValue2: testCRS(wkt) as NSObject)
        
        CRSTestUtils.assertEqual(withValue: "+proj=longlat +datum=WGS84 +no_defs" as NSObject, andValue2: testProj(wkt) as NSObject)
        
    }
 
    /**
     * Test crs
     *
     * @param wkt
     *            crs well-known text
     * @return well-known text
     */
    func testCRS(_ wkt: String) -> String{
        
        // var wkt: String = ...

        let crs : CRSObject = CRSReader.read(wkt)

        var type : CRSType = crs.type
        var category : CRSCategoryType = crs.categoryType()

        let text : String = CRSWriter.write(crs)
        let prettyText : String = CRSWriter.writePretty(crs)
        
        switch category{

        case CRS_CATEGORY_CRS:
            
            let coordRefSys : CRSCoordinateReferenceSystem = crs as! CRSCoordinateReferenceSystem
            
            switch type {
            case CRS_TYPE_BOUND:
                let bound : CRSBoundCoordinateReferenceSystem = coordRefSys as! CRSBoundCoordinateReferenceSystem
                // ...
                break
            case CRS_TYPE_COMPOUND:
                let compound : CRSCompoundCoordinateReferenceSystem = coordRefSys as! CRSCompoundCoordinateReferenceSystem
                // ...
                break
            case CRS_TYPE_DERIVED:
                let derived : CRSDerivedCoordinateReferenceSystem = coordRefSys as! CRSDerivedCoordinateReferenceSystem
                // ...
                break
            case CRS_TYPE_ENGINEERING:
                let engineering : CRSEngineeringCoordinateReferenceSystem = coordRefSys as! CRSEngineeringCoordinateReferenceSystem
                // ...
                break
            case CRS_TYPE_GEODETIC, CRS_TYPE_GEOGRAPHIC:
                let geo : CRSGeoCoordinateReferenceSystem = coordRefSys as! CRSGeoCoordinateReferenceSystem
                // ...
                break
            case CRS_TYPE_PARAMETRIC:
                let parametric : CRSParametricCoordinateReferenceSystem = coordRefSys as! CRSParametricCoordinateReferenceSystem
                // ...
                break
            case CRS_TYPE_PROJECTED:
                let projected : CRSProjectedCoordinateReferenceSystem = coordRefSys as! CRSProjectedCoordinateReferenceSystem
                // ...
                break
            case CRS_TYPE_TEMPORAL:
                let temporal : CRSTemporalCoordinateReferenceSystem = coordRefSys as! CRSTemporalCoordinateReferenceSystem
                // ...
                break
            case CRS_TYPE_VERTICAL:
                let vertical : CRSVerticalCoordinateReferenceSystem = coordRefSys as! CRSVerticalCoordinateReferenceSystem
                // ...
                break
            default:
                break
            }
            
            // ...
            break
            
        case CRS_CATEGORY_METADATA:
            
            let metadata : CRSCoordinateMetadata = crs as! CRSCoordinateMetadata
            
            // ...
            break
                
        case CRS_CATEGORY_OPERATION:
            
            let operation = crs as! CRSOperation
            
            switch type {
            case CRS_TYPE_CONCATENATED_OPERATION:
                let concatenatedOperation : CRSConcatenatedOperation = operation as! CRSConcatenatedOperation
                // ...
                break
            case CRS_TYPE_COORDINATE_OPERATION:
                let coordinateOperation : CRSCoordinateOperation = operation as! CRSCoordinateOperation
                // ...
                break
            case CRS_TYPE_POINT_MOTION_OPERATION:
                let pointMotionOperation : CRSPointMotionOperation = operation as! CRSPointMotionOperation
                // ...
                break
            default:
                break
            }
            
            // ...
            break
                
        default:
            break
        }
        
        return text
    }
    
    /**
     * Test proj
     *
     * @param wkt
     *            crs well-known text
     * @return proj text
     */
    func testProj(_ wkt: String) -> String{
        
        // var wkt: String = ...
        
        let crs : CRSObject = CRSReader.read(wkt)
        
        let projParamsFromCRS : CRSProjParams = CRSProjParser.params(fromCRS: crs)
        let projTextFromCRS : String = CRSProjParser.paramsText(fromCRS: crs)
        let projParamsFromWKT : CRSProjParams = CRSProjParser.params(fromText: wkt)
        let projTextFromWKT : String = CRSProjParser.paramsText(fromText: wkt)
        
        return projTextFromWKT
    }
    
}
