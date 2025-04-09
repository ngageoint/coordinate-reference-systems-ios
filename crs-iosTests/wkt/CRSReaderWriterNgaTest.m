//
//  CRSReaderWriterNgaTest.m
//  crs-iosTests
//
//  Created by Brian Osborn on 8/5/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSReaderWriterNgaTest.h"
#import "CRSTestUtils.h"
@import CoordinateReferenceSystems;

@implementation CRSReaderWriterNgaTest

/**
 * Test NGA 8047
 */
-(void) test8047{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"VERTCRS[\"EGM96 geoid depth\","];
    [text appendString:@"VDATUM[\"EGM96 geoid\",ANCHOR[\"WGS 84 ellipsoid\"]],"];
    [text appendString:@"CS[vertical,1],"];
    [text appendString:@"AXIS[\"Gravity-related depth (D)\",down],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1.0],ID[\"NSG\",\"8047\"]]"];
     
    CRSObject *crs = [CRSReader read:text withStrict:YES];
    
    NSString *expectedText = [text stringByReplacingOccurrencesOfString:@"\"8047\"" withString:@"8047"];
    
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
}

/**
 * Test NGA 8056
 */
-(void) test8056{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"VERTCRS[\"EGM2008 geoid depth\","];
    [text appendString:@"VDATUM[\"EGM2008 geoid\",ANCHOR[\"WGS 84 ellipsoid\"]],"];
    [text appendString:@"CS[vertical,1],"];
    [text appendString:@"AXIS[\"Gravity-related depth (D)\",down],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1.0],ID[\"NSG\",\"8056\"]]"];
     
    CRSObject *crs = [CRSReader read:text withStrict:YES];
    
    NSString *expectedText = [text stringByReplacingOccurrencesOfString:@"\"8056\"" withString:@"8056"];
    
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
}

/**
 * Test NGA 8101
 */
-(void) test8101{

    NSMutableString *text = [NSMutableString string];
    [text appendString:@"COMPOUNDCRS[“WGS84 Height (EGM08)”,"];
    [text appendString:@"GEODCRS[\"WGS 84\","];
    [text appendString:@"DATUM[\"World Geodetic System 1984\","];
    [text appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,LENGTHUNIT[\"metre\",1.0]]],"];
    [text appendString:@"CS[ellipsoidal,2],"];
    [text appendString:@"AXIS[\"Geodetic latitude (Lat)\",north],"];
    [text appendString:@"AXIS[\"Geodetic longitude (Long)\",east],"];
    [text appendString:@"ANGLEUNIT[\"degree\",0.0174532925199433],ID[\"EPSG\",4326]],"];
    [text appendString:@"VERTCRS[\"EGM2008 geoid height\","];
    [text appendString:@"VDATUM[\"EGM2008 geoid\",ANCHOR[\"WGS 84 ellipsoid\"]],"];
    [text appendString:@"CS[vertical,1],AXIS[\"Gravity-related height (H)\",up],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1.0]ID[\"EPSG\",\"3855\"]],"];
    [text appendString:@"ID[“NSG”,”8101”]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = [NSMutableString string];
    [expectedText appendString:@"COMPOUNDCRS[\"WGS84 Height (EGM08)\","];
    [expectedText appendString:@"GEODCRS[\"WGS 84\","];
    [expectedText appendString:@"DATUM[\"World Geodetic System 1984\","];
    [expectedText appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,LENGTHUNIT[\"metre\",1.0]]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],"];
    [expectedText appendString:@"AXIS[\"Geodetic latitude (Lat)\",north],"];
    [expectedText appendString:@"AXIS[\"Geodetic longitude (Long)\",east],"];
    [expectedText appendString:@"ANGLEUNIT[\"degree\",0.0174532925199433],ID[\"EPSG\",4326]],"];
    [expectedText appendString:@"VERTCRS[\"EGM2008 geoid height\","];
    [expectedText appendString:@"VDATUM[\"EGM2008 geoid\",ANCHOR[\"WGS 84 ellipsoid\"]],"];
    [expectedText appendString:@"CS[vertical,1],AXIS[\"Gravity-related height (H)\",up],"];
    [expectedText appendString:@"LENGTHUNIT[\"metre\",1.0],ID[\"EPSG\",3855]],"];
    [expectedText appendString:@"ID[\"NSG\",8101]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

}

@end
