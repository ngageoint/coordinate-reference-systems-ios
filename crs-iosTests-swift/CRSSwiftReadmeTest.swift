//
//  CRSSwiftReadmeTest.swift
//  crs-iosTests
//
//  Created by Brian Osborn on 7/12/21.
//  Copyright © 2021 NGA. All rights reserved.
//

import XCTest
import CoordinateReferenceSystems


/**
* README.md example code
*/
class CRSSwiftReadmeTest: XCTestCase{
    
    /**
     * Test crs for the README.md code samples
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
        
        XCTAssertEqual(wkt, testCRS(wkt))
        XCTAssertEqual("+proj=longlat +datum=WGS84 +no_defs", testProj(wkt))
    }
 
    /**
     * Test crs for the README.md code samples
     *
     * @param wkt
     *            crs well-known text
     * @return well-known text
     */
    func testCRS(_ wkt: String) -> String{
        
        // var wkt: String = ...

        let crs : CRSObject = CRSReader.read(wkt)
        
        let type : CRSType = crs.type
        let category : CRSCategoryType = crs.categoryType()

        let text : String = CRSWriter.write(crs)
        let prettyText : String = CRSWriter.writePretty(crs)
        print(prettyText)
        
        switch category {

        case .CATEGORY_CRS:
            
            let coordRefSys : CRSCoordinateReferenceSystem = crs as! CRSCoordinateReferenceSystem
            
            switch type {
            case .TYPE_BOUND:
                let bound : CRSBoundCoordinateReferenceSystem = coordRefSys as! CRSBoundCoordinateReferenceSystem
                
                _ = bound // Suppress warnings about unused variables
                // ...
                break
            case .TYPE_COMPOUND:
                let compound : CRSCompoundCoordinateReferenceSystem = coordRefSys as! CRSCompoundCoordinateReferenceSystem
                
                _ = compound
                // ...
                break
            case .TYPE_DERIVED:
                let derived : CRSDerivedCoordinateReferenceSystem = coordRefSys as! CRSDerivedCoordinateReferenceSystem
                
                _ = derived
                // ...
                break
            case .TYPE_ENGINEERING:
                let engineering : CRSEngineeringCoordinateReferenceSystem = coordRefSys as! CRSEngineeringCoordinateReferenceSystem
                
                _ = engineering
                // ...
                break
            case .TYPE_GEODETIC, .TYPE_GEOGRAPHIC:
                let geo : CRSGeoCoordinateReferenceSystem = coordRefSys as! CRSGeoCoordinateReferenceSystem
                
                _ = geo
                // ...
                break
            case .TYPE_PARAMETRIC:
                let parametric : CRSParametricCoordinateReferenceSystem = coordRefSys as! CRSParametricCoordinateReferenceSystem
                
                _ = parametric
                // ...
                break
            case .TYPE_PROJECTED:
                let projected : CRSProjectedCoordinateReferenceSystem = coordRefSys as! CRSProjectedCoordinateReferenceSystem
                
                _ = projected
                // ...
                break
            case .TYPE_TEMPORAL:
                let temporal : CRSTemporalCoordinateReferenceSystem = coordRefSys as! CRSTemporalCoordinateReferenceSystem
                
                _ = temporal
                // ...
                break
            case .TYPE_VERTICAL:
                let vertical : CRSVerticalCoordinateReferenceSystem = coordRefSys as! CRSVerticalCoordinateReferenceSystem
                
                _ = vertical
                // ...
                break
            default:
                break
            }
            
            // ...
            break
            
        case .CATEGORY_METADATA:
            
            let metadata : CRSCoordinateMetadata = crs as! CRSCoordinateMetadata
            
            _ = metadata
            // ...
            break
                
        case .CATEGORY_OPERATION:
            
            let operation = crs as! CRSOperation
            
            switch type {
            case .TYPE_CONCATENATED_OPERATION:
                let concatenatedOperation : CRSConcatenatedOperation = operation as! CRSConcatenatedOperation
                
                _ = concatenatedOperation // Suppress warnings about unused variables
                // ...
                break
            case .TYPE_COORDINATE_OPERATION:
                let coordinateOperation : CRSCoordinateOperation = operation as! CRSCoordinateOperation
                
                _ = coordinateOperation
                // ...
                break
            case .TYPE_POINT_MOTION_OPERATION:
                let pointMotionOperation : CRSPointMotionOperation = operation as! CRSPointMotionOperation
                
                _ = pointMotionOperation
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
     * @return PROJ text
     */
    func testProj(_ wkt: String) -> String{
        
        // var wkt: String = ...
        
        let crs : CRSObject = CRSReader.read(wkt)
        
        let projParamsFromCRS : CRSProjParams = CRSProjParser.params(fromCRS: crs)
        let projTextFromCRS : String = CRSProjParser.paramsText(fromCRS: crs)
        let projParamsFromWKT : CRSProjParams = CRSProjParser.params(fromText: wkt)
        let projTextFromWKT : String = CRSProjParser.paramsText(fromText: wkt)
        
        // Suppress warnings about unused variables
        print(projParamsFromCRS)
        print(projTextFromCRS)
        print(projParamsFromWKT)
        
        return projTextFromWKT
    }
    
}
