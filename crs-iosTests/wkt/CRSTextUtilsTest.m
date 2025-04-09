//
//  CRSTextUtilsTest.m
//  crs-iosTests
//
//  Created by Brian Osborn on 8/5/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSTextUtilsTest.h"
#import "CRSTestUtils.h"
@import CoordinateReferenceSystems;

@implementation CRSTextUtilsTest

/**
 * Test pretty WKT
 */
-(void) testPretty{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"PROJCRS[\"WGS 84 / Pseudo-Mercator\",BASEGEOGCRS[\"WGS 84\","];
    [text appendString:@"ENSEMBLE[\"World Geodetic System 1984 ensemble\","];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (Transit)\",ID[\"EPSG\",1166]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G730)\",ID[\"EPSG\",1152]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G873)\",ID[\"EPSG\",1153]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1150)\",ID[\"EPSG\",1154]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1674)\",ID[\"EPSG\",1155]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1762)\",ID[\"EPSG\",1156]],"];
    [text appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,ID[\"EPSG\",7030]],"];
    [text appendString:@"ENSEMBLEACCURACY[2],ID[\"EPSG\",6326]],ID[\"EPSG\",4326]],"];
    [text appendString:@"CONVERSION[\"Popular Visualisation Pseudo-Mercator\","];
    [text appendString:@"METHOD[\"Popular Visualisation Pseudo Mercator\",ID[\"EPSG\",1024]],"];
    [text appendString:@"PARAMETER[\"Latitude of natural origin\",0,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Longitude of natural origin\",0,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"False easting\",0,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"PARAMETER[\"False northing\",0,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"ID[\"EPSG\",3856]],CS[Cartesian,2,ID[\"EPSG\",4499]],"];
    [text appendString:@"AXIS[\"Easting (X)\",east],AXIS[\"Northing (Y)\",north],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",3857]]"];
    
    CRSObject *crs = [CRSReader read:text withStrict:YES];
    
    NSString *wkt = [CRSWriter write:crs];
    NSString *pretty = [CRSWriter writePretty:crs];
    NSString *prettyTab = [CRSWriter writePrettyTabIndent:crs];
    NSString *prettyNo = [CRSWriter writePrettyNoIndent:crs];
    NSString *prettyCustom = [CRSWriter writePretty:crs withIndent:@"\t  "];
    NSString *prettyNewline = [CRSWriter writePretty:crs withNewline:@"\n\n" andIndent:@"\t  "];
    
    [CRSTestUtils assertNotEqualWithValue:wkt andValue2:pretty];
    [CRSTestUtils assertNotEqualWithValue:wkt andValue2:prettyTab];
    [CRSTestUtils assertNotEqualWithValue:wkt andValue2:prettyNo];
    [CRSTestUtils assertNotEqualWithValue:wkt andValue2:prettyCustom];
    [CRSTestUtils assertNotEqualWithValue:wkt andValue2:prettyNewline];
    [CRSTestUtils assertNotEqualWithValue:pretty andValue2:prettyTab];
    [CRSTestUtils assertNotEqualWithValue:pretty andValue2:prettyNo];
    [CRSTestUtils assertNotEqualWithValue:pretty andValue2:prettyCustom];
    [CRSTestUtils assertNotEqualWithValue:pretty andValue2:prettyNewline];
    [CRSTestUtils assertNotEqualWithValue:prettyTab andValue2:prettyNo];
    [CRSTestUtils assertNotEqualWithValue:prettyTab andValue2:prettyCustom];
    [CRSTestUtils assertNotEqualWithValue:prettyTab andValue2:prettyNewline];
    [CRSTestUtils assertNotEqualWithValue:prettyNo andValue2:prettyCustom];
    [CRSTestUtils assertNotEqualWithValue:prettyNo andValue2:prettyNewline];
    [CRSTestUtils assertNotEqualWithValue:prettyCustom andValue2:prettyNewline];
    
    NSString *pretty2 = [CRSWriter writePrettyWithText:text];
    NSString *prettyTab2 = [CRSWriter writePrettyTabIndentWithText:text];
    NSString *prettyNo2 = [CRSWriter writePrettyNoIndentWithText:text];
    NSString *prettyCustom2 = [CRSWriter writePrettyWithText:text andIndent:@"\t  "];
    NSString *prettyNewline2 = [CRSWriter writePrettyWithText:text andNewline:@"\n\n" andIndent:@"\t  "];
    
    [CRSTestUtils assertEqualWithValue:pretty andValue2:pretty2];
    [CRSTestUtils assertEqualWithValue:prettyTab andValue2:prettyTab2];
    [CRSTestUtils assertEqualWithValue:prettyNo andValue2:prettyNo2];
    [CRSTestUtils assertEqualWithValue:prettyCustom andValue2:prettyCustom2];
    [CRSTestUtils assertEqualWithValue:prettyNewline andValue2:prettyNewline2];
    
    NSString *pretty3 = [CRSWriter writePrettyWithText:wkt];
    NSString *prettyTab3 = [CRSWriter writePrettyTabIndentWithText:wkt];
    NSString *prettyNo3 = [CRSWriter writePrettyNoIndentWithText:wkt];
    NSString *prettyCustom3 = [CRSWriter writePrettyWithText:wkt andIndent:@"\t  "];
    NSString *prettyNewline3 = [CRSWriter writePrettyWithText:wkt andNewline:@"\n\n" andIndent:@"\t  "];
    
    [CRSTestUtils assertEqualWithValue:pretty andValue2:pretty3];
    [CRSTestUtils assertEqualWithValue:prettyTab andValue2:prettyTab3];
    [CRSTestUtils assertEqualWithValue:prettyNo andValue2:prettyNo3];
    [CRSTestUtils assertEqualWithValue:prettyCustom andValue2:prettyCustom3];
    [CRSTestUtils assertEqualWithValue:prettyNewline andValue2:prettyNewline3];
    
    CRSObject *prettyCrs = [CRSReader read:pretty withStrict:YES];
    CRSObject *prettyTabCrs = [CRSReader read:prettyTab withStrict:YES];
    CRSObject *prettyNoCrs = [CRSReader read:prettyNo withStrict:YES];
    CRSObject *prettyCustomCrs = [CRSReader read:prettyCustom withStrict:YES];
    CRSObject *prettyNewlineCrs = [CRSReader read:prettyNewline withStrict:YES];
    
    [CRSTestUtils assertEqualWithValue:crs andValue2:prettyCrs];
    [CRSTestUtils assertEqualWithValue:crs andValue2:prettyTabCrs];
    [CRSTestUtils assertEqualWithValue:crs andValue2:prettyNoCrs];
    [CRSTestUtils assertEqualWithValue:crs andValue2:prettyCustomCrs];
    [CRSTestUtils assertEqualWithValue:crs andValue2:prettyNewlineCrs];
    
    [CRSTestUtils assertEqualWithValue:wkt andValue2:[CRSWriter write:prettyCrs]];
    [CRSTestUtils assertEqualWithValue:wkt andValue2:[CRSWriter write:prettyTabCrs]];
    [CRSTestUtils assertEqualWithValue:wkt andValue2:[CRSWriter write:prettyNoCrs]];
    [CRSTestUtils assertEqualWithValue:wkt andValue2:[CRSWriter write:prettyCustomCrs]];
    [CRSTestUtils assertEqualWithValue:wkt andValue2:[CRSWriter write:prettyNewlineCrs]];
    
}

@end
