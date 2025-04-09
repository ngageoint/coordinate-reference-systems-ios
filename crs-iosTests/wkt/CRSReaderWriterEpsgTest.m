//
//  CRSReaderWriterEpsgTest.m
//  crs-iosTests
//
//  Created by Brian Osborn on 8/5/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSReaderWriterEpsgTest.h"
#import "CRSTestUtils.h"
@import CoordinateReferenceSystems;

@implementation CRSReaderWriterEpsgTest

/**
 * Test EPSG 2057
 */
-(void) test2057{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"PROJCRS[\"Rassadiran / Nakhl e Taqi\",BASEGEOGCRS[\"Rassadiran\","];
    [text appendString:@"DATUM[\"Rassadiran\",ELLIPSOID[\"International 1924\",6378388,297,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [text appendString:@"ID[\"EPSG\",7022]],ID[\"EPSG\",6153]],ID[\"EPSG\",4153]],"];
    [text appendString:@"CONVERSION[\"Nakhl e Taqi Oblique Mercator\",METHOD[\"Hotine Oblique Mercator (variant B)\",ID[\"EPSG\",9815]],"];
    [text appendString:@"PARAMETER[\"Latitude of projection centre\",27.518828806,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Longitude of projection centre\",52.603539167,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Azimuth of initial line\",0.571661194,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Angle from Rectified to Skew Grid\",0.571661194,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Scale factor on initial line\",0.999895934,SCALEUNIT[\"unity\",1,ID[\"EPSG\",9201]]],"];
    [text appendString:@"PARAMETER[\"Easting at projection centre\",658377.437,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"PARAMETER[\"Northing at projection centre\",3044969.194,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"ID[\"EPSG\",19951]],CS[Cartesian,2,ID[\"EPSG\",4400]],"];
    [text appendString:@"AXIS[\"Easting (E)\",east],AXIS[\"Northing (N)\",north],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",2057]]"];
    
    CRSObject *crs = [CRSReader read:text withStrict:YES];
    
    NSMutableString *expectedText = text;
    
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"Rassadiran / Nakhl e Taqi\",GEOGCS[\"Rassadiran\","];
    [text appendString:@"DATUM[\"Rassadiran\",SPHEROID[\"International 1924\",6378388,297,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"7022\"]],TOWGS84[-133.63,-157.5,-158.62,0,0,0,0],AUTHORITY[\"EPSG\",\"6153\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],UNIT[\"degree\",0.01745329251994328,AUTHORITY[\"EPSG\",\"9122\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"4153\"]],UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],"];
    [text appendString:@"PROJECTION[\"Hotine_Oblique_Mercator\"],"];
    [text appendString:@"PARAMETER[\"latitude_of_center\",27.51882880555555],"];
    [text appendString:@"PARAMETER[\"longitude_of_center\",52.60353916666667],"];
    [text appendString:@"PARAMETER[\"azimuth\",0.5716611944444444],"];
    [text appendString:@"PARAMETER[\"rectified_grid_angle\",0.5716611944444444],"];
    [text appendString:@"PARAMETER[\"scale_factor\",0.999895934],"];
    [text appendString:@"PARAMETER[\"false_easting\",658377.437],"];
    [text appendString:@"PARAMETER[\"false_northing\",3044969.194],AUTHORITY[\"EPSG\",\"2057\"],"];
    [text appendString:@"AXIS[\"Easting\",EAST],AXIS[\"Northing\",NORTH]]"];
    
    crs = [CRSReader read:text withStrict:YES];
    
    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"Rassadiran / Nakhl e Taqi\",BASEGEOGCRS[\"Rassadiran\","];
    [expectedText appendString:@"DATUM[\"Rassadiran\",ELLIPSOID[\"International 1924\",6378388,297,"];
    [expectedText appendString:@"ID[\"EPSG\",7022]],ID[\"EPSG\",6153]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],UNIT[\"degree\",0.01745329251994328,ID[\"EPSG\",9122]],ID[\"EPSG\",4153]],"];
    [expectedText appendString:@"CONVERSION[\"Rassadiran / Nakhl e Taqi / Hotine_Oblique_Mercator\",METHOD[\"Hotine_Oblique_Mercator\"],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_center\",27.51882880555555],"];
    [expectedText appendString:@"PARAMETER[\"longitude_of_center\",52.60353916666667],"];
    [expectedText appendString:@"PARAMETER[\"azimuth\",0.5716611944444444],"];
    [expectedText appendString:@"PARAMETER[\"rectified_grid_angle\",0.5716611944444444],"];
    [expectedText appendString:@"PARAMETER[\"scale_factor\",0.999895934],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",658377.437],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",3044969.194],"];
    [expectedText appendString:@"PARAMETER[\"X-axis translation\",-133.63,LENGTHUNIT[\"metre\",1]],"];
    [expectedText appendString:@"PARAMETER[\"Y-axis translation\",-157.5,LENGTHUNIT[\"metre\",1]],"];
    [expectedText appendString:@"PARAMETER[\"Z-axis translation\",-158.62,LENGTHUNIT[\"metre\",1]]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"Easting\",east],AXIS[\"Northing\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",2057]]"];
    
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
}

/**
 * Test EPSG 3035
 */
-(void) test3035{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"PROJCRS[\"ETRS89-extended / LAEA Europe\",BASEGEOGCRS[\"ETRS89\","];
    [text appendString:@"ENSEMBLE[\"European Terrestrial Reference System 1989 ensemble\","];
    [text appendString:@"MEMBER[\"European Terrestrial Reference Frame 1989\",ID[\"EPSG\",1178]],"];
    [text appendString:@"MEMBER[\"European Terrestrial Reference Frame 1990\",ID[\"EPSG\",1179]],"];
    [text appendString:@"MEMBER[\"European Terrestrial Reference Frame 1991\",ID[\"EPSG\",1180]],"];
    [text appendString:@"MEMBER[\"European Terrestrial Reference Frame 1992\",ID[\"EPSG\",1181]],"];
    [text appendString:@"MEMBER[\"European Terrestrial Reference Frame 1993\",ID[\"EPSG\",1182]],"];
    [text appendString:@"MEMBER[\"European Terrestrial Reference Frame 1994\",ID[\"EPSG\",1183]],"];
    [text appendString:@"MEMBER[\"European Terrestrial Reference Frame 1996\",ID[\"EPSG\",1184]],"];
    [text appendString:@"MEMBER[\"European Terrestrial Reference Frame 1997\",ID[\"EPSG\",1185]],"];
    [text appendString:@"MEMBER[\"European Terrestrial Reference Frame 2000\",ID[\"EPSG\",1186]],"];
    [text appendString:@"MEMBER[\"European Terrestrial Reference Frame 2005\",ID[\"EPSG\",1204]],"];
    [text appendString:@"MEMBER[\"European Terrestrial Reference Frame 2014\",ID[\"EPSG\",1206]],"];
    [text appendString:@"ELLIPSOID[\"GRS 1980\",6378137,298.257222101,ID[\"EPSG\",7019]],"];
    [text appendString:@"ENSEMBLEACCURACY[0.1],ID[\"EPSG\",6258]],ID[\"EPSG\",4258]],"];
    [text appendString:@"CONVERSION[\"Europe Equal Area 2001\",METHOD[\"Lambert Azimuthal Equal Area\",ID[\"EPSG\",9820]],"];
    [text appendString:@"PARAMETER[\"Latitude of natural origin\",52,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Longitude of natural origin\",10,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"False easting\",4321000,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"PARAMETER[\"False northing\",3210000,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"ID[\"EPSG\",19986]],CS[Cartesian,2,ID[\"EPSG\",4532]],"];
    [text appendString:@"AXIS[\"Northing (Y)\",north],AXIS[\"Easting (X)\",east],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",3035]]"];
    
    CRSObject *crs = [CRSReader read:text withStrict:YES];
    
    NSMutableString *expectedText = text;
    
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"ETRS89 / ETRS-LAEA\",GEOGCS[\"ETRS89\","];
    [text appendString:@"DATUM[\"European_Terrestrial_Reference_System_1989\","];
    [text appendString:@"SPHEROID[\"GRS 1980\",6378137,298.257222101,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"7019\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"6258\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.01745329251994328,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"9122\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"4258\"]],"];
    [text appendString:@"UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],"];
    [text appendString:@"PROJECTION[\"Lambert_Azimuthal_Equal_Area\"],"];
    [text appendString:@"PARAMETER[\"latitude_of_center\",52],"];
    [text appendString:@"PARAMETER[\"longitude_of_center\",10],"];
    [text appendString:@"PARAMETER[\"false_easting\",4321000],"];
    [text appendString:@"PARAMETER[\"false_northing\",3210000],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"3035\"],"];
    [text appendString:@"AXIS[\"X\",EAST],AXIS[\"Y\",NORTH]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"ETRS89 / ETRS-LAEA\",BASEGEOGCRS[\"ETRS89\","];
    [expectedText appendString:@"DATUM[\"European_Terrestrial_Reference_System_1989\","];
    [expectedText appendString:@"ELLIPSOID[\"GRS 1980\",6378137,298.257222101,"];
    [expectedText appendString:@"ID[\"EPSG\",7019]],ID[\"EPSG\",6258]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.01745329251994328,"];
    [expectedText appendString:@"ID[\"EPSG\",9122]],ID[\"EPSG\",4258]],"];
    [expectedText appendString:@"CONVERSION[\"ETRS89 / ETRS-LAEA / Lambert_Azimuthal_Equal_Area\",METHOD[\"Lambert_Azimuthal_Equal_Area\"],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_center\",52],"];
    [expectedText appendString:@"PARAMETER[\"longitude_of_center\",10],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",4321000],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",3210000]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"X\",east],AXIS[\"Y\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",3035]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"ETRS89 / LAEA Europe\",GEOGCRS[\"ETRS89\","];
    [text appendString:@"DATUM[\"European_Terrestrial_Reference_System_1989\","];
    [text appendString:@"SPHEROID[\"GRS 1980\",6378137,298.257222101,"];
    [text appendString:@"ID[\"EPSG\",\"7019\"]],"];
    [text appendString:@"ABRIDGEDTRANSFORMATION[0,0,0,0,0,0,0],"];
    [text appendString:@"ID[\"EPSG\",\"6258\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [text appendString:@"ID[\"EPSG\",\"9122\"]],ID[\"EPSG\",\"4258\"]],"];
    [text appendString:@"PROJECTION[\"Lambert_Azimuthal_Equal_Area\"],"];
    [text appendString:@"PARAMETER[\"latitude_of_center\",52],"];
    [text appendString:@"PARAMETER[\"longitude_of_center\",10],"];
    [text appendString:@"PARAMETER[\"false_easting\",4321000],"];
    [text appendString:@"PARAMETER[\"false_northing\",3210000],"];
    [text appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",\"9001\"]],"];
    [text appendString:@"ID[\"EPSG\",\"3035\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"ETRS89 / LAEA Europe\",BASEGEOGCRS[\"ETRS89\","];
    [expectedText appendString:@"DATUM[\"European_Terrestrial_Reference_System_1989\","];
    [expectedText appendString:@"ELLIPSOID[\"GRS 1980\",6378137,298.257222101,"];
    [expectedText appendString:@"ID[\"EPSG\",7019]],ID[\"EPSG\",6258]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [expectedText appendString:@"ID[\"EPSG\",9122]],ID[\"EPSG\",4258]],"];
    [expectedText appendString:@"CONVERSION[\"ETRS89 / LAEA Europe / Lambert_Azimuthal_Equal_Area\",METHOD[\"Lambert_Azimuthal_Equal_Area\"],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_center\",52],"];
    [expectedText appendString:@"PARAMETER[\"longitude_of_center\",10],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",4321000],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",3210000]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"X\",east],AXIS[\"Y\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [expectedText appendString:@"ID[\"EPSG\",3035]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"ETRS89 / LAEA Europe\",GEOGCRS[\"ETRS89\","];
    [text appendString:@"DATUM[\"European_Terrestrial_Reference_System_1989\","];
    [text appendString:@"SPHEROID[\"GRS 1980\",6378137,298.257222101,"];
    [text appendString:@"ID[\"EPSG\",\"7019\"]],"];
    [text appendString:@"ABRIDGEDTRANSFORMATION[0,0,0,0,0,0,0]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [text appendString:@"ID[\"EPSG\",\"9122\"]],ID[\"EPSG\",\"4258\"]],"];
    [text appendString:@"PROJECTION[\"Lambert_Azimuthal_Equal_Area\"],"];
    [text appendString:@"PARAMETER[\"latitude_of_center\",52],"];
    [text appendString:@"PARAMETER[\"longitude_of_center\",10],"];
    [text appendString:@"PARAMETER[\"false_easting\",4321000],"];
    [text appendString:@"PARAMETER[\"false_northing\",3210000],"];
    [text appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",\"9001\"]],"];
    [text appendString:@"ID[\"EPSG\",\"3035\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"ETRS89 / LAEA Europe\",BASEGEOGCRS[\"ETRS89\","];
    [expectedText appendString:@"DATUM[\"European_Terrestrial_Reference_System_1989\","];
    [expectedText appendString:@"ELLIPSOID[\"GRS 1980\",6378137,298.257222101,"];
    [expectedText appendString:@"ID[\"EPSG\",7019]]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [expectedText appendString:@"ID[\"EPSG\",9122]],ID[\"EPSG\",4258]],"];
    [expectedText appendString:@"CONVERSION[\"ETRS89 / LAEA Europe / Lambert_Azimuthal_Equal_Area\",METHOD[\"Lambert_Azimuthal_Equal_Area\"],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_center\",52],"];
    [expectedText appendString:@"PARAMETER[\"longitude_of_center\",10],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",4321000],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",3210000]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"X\",east],AXIS[\"Y\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [expectedText appendString:@"ID[\"EPSG\",3035]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"ETRS89 / LAEA Europe\",GEOGCRS[\"ETRS89\","];
    [text appendString:@"DATUM[\"European_Terrestrial_Reference_System_1989\","];
    [text appendString:@"SPHEROID[\"GRS 1980\",6378137,298.257222101,"];
    [text appendString:@"ID[\"EPSG\",\"7019\"]],ID[\"EPSG\",\"6258\"],"];
    [text appendString:@"ABRIDGEDTRANSFORMATION[0,0,0,0,0,0,0]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [text appendString:@"ID[\"EPSG\",\"9122\"]],ID[\"EPSG\",\"4258\"]],"];
    [text appendString:@"PROJECTION[\"Lambert_Azimuthal_Equal_Area\"],"];
    [text appendString:@"PARAMETER[\"latitude_of_center\",52],"];
    [text appendString:@"PARAMETER[\"longitude_of_center\",10],"];
    [text appendString:@"PARAMETER[\"false_easting\",4321000],"];
    [text appendString:@"PARAMETER[\"false_northing\",3210000],"];
    [text appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",\"9001\"]],"];
    [text appendString:@"ID[\"EPSG\",\"3035\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"ETRS89 / LAEA Europe\",BASEGEOGCRS[\"ETRS89\","];
    [expectedText appendString:@"DATUM[\"European_Terrestrial_Reference_System_1989\","];
    [expectedText appendString:@"ELLIPSOID[\"GRS 1980\",6378137,298.257222101,"];
    [expectedText appendString:@"ID[\"EPSG\",7019]],ID[\"EPSG\",6258]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [expectedText appendString:@"ID[\"EPSG\",9122]],ID[\"EPSG\",4258]],"];
    [expectedText appendString:@"CONVERSION[\"ETRS89 / LAEA Europe / Lambert_Azimuthal_Equal_Area\",METHOD[\"Lambert_Azimuthal_Equal_Area\"],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_center\",52],"];
    [expectedText appendString:@"PARAMETER[\"longitude_of_center\",10],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",4321000],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",3210000]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"X\",east],AXIS[\"Y\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [expectedText appendString:@"ID[\"EPSG\",3035]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
}

/**
 * Test EPSG 3375
 */
-(void) test3375{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"PROJCRS[\"GDM2000 / Peninsula RSO\",BASEGEOGCRS[\"GDM2000\","];
    [text appendString:@"DATUM[\"Geodetic Datum of Malaysia 2000\","];
    [text appendString:@"ELLIPSOID[\"GRS 1980\",6378137,298.2572221,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [text appendString:@"ID[\"EPSG\",7019]],ID[\"EPSG\",6742]],ID[\"EPSG\",4742]],"];
    [text appendString:@"CONVERSION[\"Peninsular RSO\",METHOD[\"Hotine Oblique Mercator (variant A)\",ID[\"EPSG\",9812]],"];
    [text appendString:@"PARAMETER[\"Latitude of projection centre\",4,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Longitude of projection centre\",102.25,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Azimuth of initial line\",323.025796467,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Angle from Rectified to Skew Grid\",323.130102361,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Scale factor on initial line\",0.99984,SCALEUNIT[\"unity\",1,ID[\"EPSG\",9201]]],"];
    [text appendString:@"PARAMETER[\"False easting\",804671,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"PARAMETER[\"False northing\",0,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],ID[\"EPSG\",19895]],"];
    [text appendString:@"CS[Cartesian,2,ID[\"EPSG\",4400]],AXIS[\"Easting (E)\",east],AXIS[\"Northing (N)\",north],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [text appendString:@"ID[\"EPSG\",3375]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];
    
    NSMutableString *expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"GDM2000 / Peninsula RSO\",GEOGCS[\"GDM2000\","];
    [text appendString:@"DATUM[\"Geodetic_Datum_of_Malaysia_2000\","];
    [text appendString:@"SPHEROID[\"GRS 1980\",6378137,298.257222101,AUTHORITY[\"EPSG\",\"7019\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"6742\"]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.01745329251994328,AUTHORITY[\"EPSG\",\"9122\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"4742\"]],UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],"];
    [text appendString:@"PROJECTION[\"Hotine_Oblique_Mercator\"],"];
    [text appendString:@"PARAMETER[\"latitude_of_center\",4],"];
    [text appendString:@"PARAMETER[\"longitude_of_center\",102.25],"];
    [text appendString:@"PARAMETER[\"azimuth\",323.0257964666666],"];
    [text appendString:@"PARAMETER[\"rectified_grid_angle\",323.1301023611111],"];
    [text appendString:@"PARAMETER[\"scale_factor\",0.99984],"];
    [text appendString:@"PARAMETER[\"false_easting\",804671],"];
    [text appendString:@"PARAMETER[\"false_northing\",0],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"3375\"],AXIS[\"Easting\",EAST],AXIS[\"Northing\",NORTH]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"GDM2000 / Peninsula RSO\",BASEGEOGCRS[\"GDM2000\","];
    [expectedText appendString:@"DATUM[\"Geodetic_Datum_of_Malaysia_2000\","];
    [expectedText appendString:@"ELLIPSOID[\"GRS 1980\",6378137,298.257222101,ID[\"EPSG\",7019]],"];
    [expectedText appendString:@"ID[\"EPSG\",6742]],PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.01745329251994328,ID[\"EPSG\",9122]],ID[\"EPSG\",4742]],"];
    [expectedText appendString:@"CONVERSION[\"GDM2000 / Peninsula RSO / Hotine_Oblique_Mercator\",METHOD[\"Hotine_Oblique_Mercator\"],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_center\",4],"];
    [expectedText appendString:@"PARAMETER[\"longitude_of_center\",102.25],"];
    [expectedText appendString:@"PARAMETER[\"azimuth\",323.0257964666666],"];
    [expectedText appendString:@"PARAMETER[\"rectified_grid_angle\",323.1301023611111],"];
    [expectedText appendString:@"PARAMETER[\"scale_factor\",0.99984],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",804671],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",0]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"Easting\",east],AXIS[\"Northing\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [expectedText appendString:@"ID[\"EPSG\",3375]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
}

/**
 * Test EPSG 3395
 */
-(void) test3395{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"PROJCRS[\"WGS 84 / World Mercator\",BASEGEOGCRS[\"WGS 84\","];
    [text appendString:@"ENSEMBLE[\"World Geodetic System 1984 ensemble\","];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (Transit)\",ID[\"EPSG\",1166]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G730)\",ID[\"EPSG\",1152]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G873)\",ID[\"EPSG\",1153]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1150)\",ID[\"EPSG\",1154]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1674)\",ID[\"EPSG\",1155]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1762)\",ID[\"EPSG\",1156]],"];
    [text appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,ID[\"EPSG\",7030]],"];
    [text appendString:@"ENSEMBLEACCURACY[2],ID[\"EPSG\",6326]],ID[\"EPSG\",4326]],"];
    [text appendString:@"CONVERSION[\"World Mercator\",METHOD[\"Mercator (variant A)\",ID[\"EPSG\",9804]],"];
    [text appendString:@"PARAMETER[\"Latitude of natural origin\",0,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Longitude of natural origin\",0,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Scale factor at natural origin\",1,SCALEUNIT[\"unity\",1,ID[\"EPSG\",9201]]],"];
    [text appendString:@"PARAMETER[\"False easting\",0,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"PARAMETER[\"False northing\",0,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"ID[\"EPSG\",19883]],CS[Cartesian,2,ID[\"EPSG\",4400]],"];
    [text appendString:@"AXIS[\"Easting (E)\",east],AXIS[\"Northing (N)\",north],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",3395]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"WGS 84 / World Mercator\",GEOGCS[\"WGS 84\","];
    [text appendString:@"DATUM[\"WGS_1984\","];
    [text appendString:@"SPHEROID[\"WGS 84\",6378137,298.257223563,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"7030\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"6326\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.01745329251994328,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"9122\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"4326\"]],"];
    [text appendString:@"UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],"];
    [text appendString:@"PROJECTION[\"Mercator_1SP\"],"];
    [text appendString:@"PARAMETER[\"central_meridian\",0],"];
    [text appendString:@"PARAMETER[\"scale_factor\",1],"];
    [text appendString:@"PARAMETER[\"false_easting\",0],"];
    [text appendString:@"PARAMETER[\"false_northing\",0],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"3395\"],"];
    [text appendString:@"AXIS[\"Easting\",EAST],AXIS[\"Northing\",NORTH]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"WGS 84 / World Mercator\",BASEGEOGCRS[\"WGS 84\","];
    [expectedText appendString:@"DATUM[\"WGS_1984\","];
    [expectedText appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,"];
    [expectedText appendString:@"ID[\"EPSG\",7030]],ID[\"EPSG\",6326]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.01745329251994328,"];
    [expectedText appendString:@"ID[\"EPSG\",9122]],ID[\"EPSG\",4326]],"];
    [expectedText appendString:@"CONVERSION[\"WGS 84 / World Mercator / Mercator_1SP\",METHOD[\"Mercator_1SP\"],"];
    [expectedText appendString:@"PARAMETER[\"central_meridian\",0],"];
    [expectedText appendString:@"PARAMETER[\"scale_factor\",1],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",0],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",0]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"Easting\",east],AXIS[\"Northing\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",3395]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"PROJCRS[\"WGS 84 / World Mercator\","];
    [text appendString:@"BASEGEODCRS[\"WGS 84\","];
    [text appendString:@"DATUM[\"World Geodetic System 1984\","];
    [text appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563]]],"];
    [text appendString:@"CONVERSION[\"Mercator\","];
    [text appendString:@"METHOD[\"Mercator (variant A)\",ID[\"EPSG\",\"9804\"]],"];
    [text appendString:@"PARAMETER[\"Latitude of natural origin\",0,"];
    [text appendString:@"ANGLEUNIT[\"degree\",0.0174532925199433]],"];
    [text appendString:@"PARAMETER[\"Longitude of natural origin\",0,"];
    [text appendString:@"ANGLEUNIT[\"degree\",0.0174532925199433]],"];
    [text appendString:@"PARAMETER[\"Scale factor at natural origin\",1,"];
    [text appendString:@"SCALEUNIT[\"unity\",1.0]],"];
    [text appendString:@"PARAMETER[\"False easting\",0,LENGTHUNIT[\"metre\",1.0]],"];
    [text appendString:@"PARAMETER[\"False northing\",0,LENGTHUNIT[\"metre\",1.0]],"];
    [text appendString:@"ID[\"EPSG\",\"19833\"]],CS[Cartesian,2],"];
    [text appendString:@"AXIS[\"Easting (E)\",east,ORDER[1]],"];
    [text appendString:@"AXIS[\"Northing (N)\",north,ORDER[2]],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1.0],ID[\"EPSG\",\"3395\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString stringWithString:[text stringByReplacingOccurrencesOfString:@"\"9804\"" withString:@"9804"]];
    expectedText = [NSMutableString stringWithString:[expectedText stringByReplacingOccurrencesOfString:@"\"19833\"" withString:@"19833"]];
    expectedText = [NSMutableString stringWithString:[expectedText stringByReplacingOccurrencesOfString:@"\"3395\"" withString:@"3395"]];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
}

/**
 * Test EPSG 3855
 */
-(void) test3855{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"VERTCRS[\"EGM2008 height\","];
    [text appendString:@"VDATUM[\"EGM2008 geoid\",ID[\"EPSG\",1027]],"];
    [text appendString:@"CS[vertical,1,ID[\"EPSG\",6499]],"];
    [text appendString:@"AXIS[\"Gravity-related height (H)\",up],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [text appendString:@"ID[\"EPSG\",3855]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"VERT_CS[\"EGM2008 geoid height\","];
    [text appendString:@"VERT_DATUM[\"EGM2008 geoid\",2005,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"1027\"],"];
    [text appendString:@"EXTENSION[\"PROJ4_GRIDS\",\"egm08_25.gtx\"]],"];
    [text appendString:@"UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],"];
    [text appendString:@"AXIS[\"Up\",UP],AUTHORITY[\"EPSG\",\"3855\"]]"];

    CRSCoordinateReferenceSystem *coordinateReferenceSystem = [CRSReader readCoordinateReferenceSystem:text withStrict:YES];
    crs = coordinateReferenceSystem;

    expectedText = [NSMutableString string];
    [expectedText appendString:@"VERTCRS[\"EGM2008 geoid height\","];
    [expectedText appendString:@"VDATUM[\"EGM2008 geoid\",ID[\"EPSG\",1027]],"];
    [expectedText appendString:@"CS[vertical,1],AXIS[\"Up\",up],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [expectedText appendString:@"ID[\"EPSG\",3855]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    [CRSTestUtils assertEqualIntWithValue:2 andValue2:[coordinateReferenceSystem numExtras]];
    [CRSTestUtils assertEqualWithValue:@"2005" andValue2:[coordinateReferenceSystem extraWithName:CRS_WKT_DATUM_TYPE]];
    [CRSTestUtils assertEqualWithValue:@"egm08_25.gtx" andValue2:[coordinateReferenceSystem extraWithName:@"PROJ4_GRIDS"]];

    text = [NSMutableString string];
    [text appendString:@"VERTCRS[\"EGM2008 geoid height\","];
    [text appendString:@"VDATUM[\"EGM2008 geoid\",ANCHOR[\"WGS 84 ellipsoid\"]],"];
    [text appendString:@"CS[vertical,1],"];
    [text appendString:@"AXIS[\"Gravity-related height (H)\",up],LENGTHUNIT[\"metre\",1],"];
    [text appendString:@"ID[\"EPSG\",\"3855\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString stringWithString:[text stringByReplacingOccurrencesOfString:@"\"3855\"" withString:@"3855"]];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
}

/**
 * Test EPSG 3857
 */
-(void) test3857{
    
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

    NSMutableString *expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"WGS 84 / Pseudo-Mercator\",GEOGCS[\"WGS 84\","];
    [text appendString:@"DATUM[\"WGS_1984\","];
    [text appendString:@"SPHEROID[\"WGS 84\",6378137,298.257223563,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"7030\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"6326\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"9122\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"4326\"]],"];
    [text appendString:@"PROJECTION[\"Mercator_1SP\"],"];
    [text appendString:@"PARAMETER[\"central_meridian\",0],"];
    [text appendString:@"PARAMETER[\"scale_factor\",1],"];
    [text appendString:@"PARAMETER[\"false_easting\",0],"];
    [text appendString:@"PARAMETER[\"false_northing\",0],"];
    [text appendString:@"UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],"];
    [text appendString:@"AXIS[\"X\",EAST],AXIS[\"Y\",NORTH],"];
    [text appendString:@"EXTENSION[\"PROJ4\",\"+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs\"],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"3857\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"WGS 84 / Pseudo-Mercator\",BASEGEOGCRS[\"WGS 84\","];
    [expectedText appendString:@"DATUM[\"WGS_1984\","];
    [expectedText appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,ID[\"EPSG\",7030]],"];
    [expectedText appendString:@"ID[\"EPSG\",6326]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [expectedText appendString:@"ID[\"EPSG\",9122]],ID[\"EPSG\",4326]],"];
    [expectedText appendString:@"CONVERSION[\"WGS 84 / Pseudo-Mercator / Mercator_1SP\",METHOD[\"Mercator_1SP\"],"];
    [expectedText appendString:@"PARAMETER[\"central_meridian\",0],"];
    [expectedText appendString:@"PARAMETER[\"scale_factor\",1],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",0],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",0]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"X\",east],AXIS[\"Y\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",3857]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"WGS 84 / Pseudo-Mercator\","];
    [text appendString:@"GEOGCRS[\"WGS 84\",DATUM[\"WGS_1984\","];
    [text appendString:@"SPHEROID[\"WGS 84\",6378137,298.257223563,"];
    [text appendString:@"ID[\"EPSG\",\"7030\"]],ID[\"EPSG\",\"6326\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [text appendString:@"ID[\"EPSG\",\"9122\"]],ID[\"EPSG\",\"4326\"]],"];
    [text appendString:@"PROJECTION[\"Mercator_1SP\"],"];
    [text appendString:@"PARAMETER[\"central_meridian\",0],"];
    [text appendString:@"PARAMETER[\"scale_factor\",1],"];
    [text appendString:@"PARAMETER[\"false_easting\",0],"];
    [text appendString:@"PARAMETER[\"false_northing\",0]"];
    [text appendString:@",UNIT[\"metre\",1,ID[\"EPSG\",\"9001\"]]"];
    [text appendString:@",AXIS[\"X\",EAST],AXIS[\"Y\",NORTH]"];
    [text appendString:@",ID[\"EPSG\",\"3857\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"WGS 84 / Pseudo-Mercator\","];
    [expectedText appendString:@"BASEGEOGCRS[\"WGS 84\",DATUM[\"WGS_1984\","];
    [expectedText appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,"];
    [expectedText appendString:@"ID[\"EPSG\",7030]],ID[\"EPSG\",6326]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [expectedText appendString:@"ID[\"EPSG\",9122]],ID[\"EPSG\",4326]],"];
    [expectedText appendString:@"CONVERSION[\"WGS 84 / Pseudo-Mercator / Mercator_1SP\",METHOD[\"Mercator_1SP\"],"];
    [expectedText appendString:@"PARAMETER[\"central_meridian\",0],"];
    [expectedText appendString:@"PARAMETER[\"scale_factor\",1],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",0],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",0]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"X\",east],AXIS[\"Y\",north]"];
    [expectedText appendString:@",UNIT[\"metre\",1,ID[\"EPSG\",9001]]"];
    [expectedText appendString:@",ID[\"EPSG\",3857]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

}

/**
 * Test EPSG 3978
 */
-(void) test3978{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"PROJCRS[\"NAD83 / Canada Atlas Lambert\",BASEGEOGCRS[\"NAD83\","];
    [text appendString:@"DATUM[\"North American Datum 1983\","];
    [text appendString:@"ELLIPSOID[\"GRS 1980\",6378137,298.257222101,ID[\"EPSG\",7019]],"];
    [text appendString:@"ID[\"EPSG\",6269]],ID[\"EPSG\",4269]],"];
    [text appendString:@"CONVERSION[\"Canada Atlas Lambert\",METHOD[\"Lambert Conic Conformal (2SP)\",ID[\"EPSG\",9802]],"];
    [text appendString:@"PARAMETER[\"Latitude of false origin\",49,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Longitude of false origin\",-95,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Latitude of 1st standard parallel\",49,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Latitude of 2nd standard parallel\",77,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Easting at false origin\",0,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"PARAMETER[\"Northing at false origin\",0,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"ID[\"EPSG\",3977]],CS[Cartesian,2,ID[\"EPSG\",4400]],"];
    [text appendString:@"AXIS[\"Easting (E)\",east],AXIS[\"Northing (N)\",north],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",3978]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"NAD83 / Canada Atlas Lambert\",GEOGCS[\"NAD83\","];
    [text appendString:@"DATUM[\"North_American_Datum_1983\","];
    [text appendString:@"SPHEROID[\"GRS 1980\",6378137,298.257222101,AUTHORITY[\"EPSG\",\"7019\"]],"];
    [text appendString:@"TOWGS84[0,0,0,0,0,0,0],AUTHORITY[\"EPSG\",\"6269\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"9122\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"4269\"]],"];
    [text appendString:@"PROJECTION[\"Lambert_Conformal_Conic_2SP\"],"];
    [text appendString:@"PARAMETER[\"standard_parallel_1\",49],"];
    [text appendString:@"PARAMETER[\"standard_parallel_2\",77],"];
    [text appendString:@"PARAMETER[\"latitude_of_origin\",49],"];
    [text appendString:@"PARAMETER[\"central_meridian\",-95],"];
    [text appendString:@"PARAMETER[\"false_easting\",0],"];
    [text appendString:@"PARAMETER[\"false_northing\",0],"];
    [text appendString:@"UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],"];
    [text appendString:@"AXIS[\"Easting\",EAST],AXIS[\"Northing\",NORTH],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"3978\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"NAD83 / Canada Atlas Lambert\",BASEGEOGCRS[\"NAD83\","];
    [expectedText appendString:@"DATUM[\"North_American_Datum_1983\","];
    [expectedText appendString:@"ELLIPSOID[\"GRS 1980\",6378137,298.257222101,ID[\"EPSG\",7019]],"];
    [expectedText appendString:@"ID[\"EPSG\",6269]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [expectedText appendString:@"ID[\"EPSG\",9122]],ID[\"EPSG\",4269]],"];
    [expectedText appendString:@"CONVERSION[\"NAD83 / Canada Atlas Lambert / Lambert_Conformal_Conic_2SP\",METHOD[\"Lambert_Conformal_Conic_2SP\"],"];
    [expectedText appendString:@"PARAMETER[\"standard_parallel_1\",49],"];
    [expectedText appendString:@"PARAMETER[\"standard_parallel_2\",77],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_origin\",49],"];
    [expectedText appendString:@"PARAMETER[\"central_meridian\",-95],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",0],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",0]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"Easting\",east],AXIS[\"Northing\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [expectedText appendString:@"ID[\"EPSG\",3978]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"NAD83 / Canada Atlas Lambert\",GEOGCRS[\"NAD83\","];
    [text appendString:@"DATUM[\"North_American_Datum_1983\","];
    [text appendString:@"SPHEROID[\"GRS 1980\",6378137,298.257222101,"];
    [text appendString:@"ID[\"EPSG\",\"7019\"]],"];
    [text appendString:@"ABRIDGEDTRANSFORMATION[0,0,0,0,0,0,0],"];
    [text appendString:@"ID[\"EPSG\",\"6269\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",\"9122\"]],"];
    [text appendString:@"ID[\"EPSG\",\"4269\"]],"];
    [text appendString:@"PROJECTION[\"Lambert_Conformal_Conic_2SP\"],"];
    [text appendString:@"PARAMETER[\"standard_parallel_1\",49],"];
    [text appendString:@"PARAMETER[\"standard_parallel_2\",77],"];
    [text appendString:@"PARAMETER[\"latitude_of_origin\",49],"];
    [text appendString:@"PARAMETER[\"central_meridian\",-95],"];
    [text appendString:@"PARAMETER[\"false_easting\",0],"];
    [text appendString:@"PARAMETER[\"false_northing\",0],"];
    [text appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",\"9001\"]],"];
    [text appendString:@"AXIS[\"Easting\",EAST],AXIS[\"Northing\",NORTH],"];
    [text appendString:@"ID[\"EPSG\",\"3978\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"NAD83 / Canada Atlas Lambert\",BASEGEOGCRS[\"NAD83\","];
    [expectedText appendString:@"DATUM[\"North_American_Datum_1983\","];
    [expectedText appendString:@"ELLIPSOID[\"GRS 1980\",6378137,298.257222101,ID[\"EPSG\",7019]],"];
    [expectedText appendString:@"ID[\"EPSG\",6269]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9122]],"];
    [expectedText appendString:@"ID[\"EPSG\",4269]],"];
    [expectedText appendString:@"CONVERSION[\"NAD83 / Canada Atlas Lambert / Lambert_Conformal_Conic_2SP\",METHOD[\"Lambert_Conformal_Conic_2SP\"],"];
    [expectedText appendString:@"PARAMETER[\"standard_parallel_1\",49],"];
    [expectedText appendString:@"PARAMETER[\"standard_parallel_2\",77],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_origin\",49],"];
    [expectedText appendString:@"PARAMETER[\"central_meridian\",-95],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",0],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",0]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"Easting\",east],AXIS[\"Northing\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [expectedText appendString:@"ID[\"EPSG\",3978]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
}

/**
 * Test EPSG 4326
 */
-(void) test4326{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"GEOGCRS[\"WGS 84\",ENSEMBLE[\"World Geodetic System 1984 ensemble\","];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (Transit)\",ID[\"EPSG\",1166]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G730)\",ID[\"EPSG\",1152]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G873)\",ID[\"EPSG\",1153]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1150)\",ID[\"EPSG\",1154]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1674)\",ID[\"EPSG\",1155]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1762)\",ID[\"EPSG\",1156]],"];
    [text appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,ID[\"EPSG\",7030]],"];
    [text appendString:@"ENSEMBLEACCURACY[2],ID[\"EPSG\",6326]],"];
    [text appendString:@"CS[ellipsoidal,2,ID[\"EPSG\",6422]],"];
    [text appendString:@"AXIS[\"Geodetic latitude (Lat)\",north],AXIS[\"Geodetic longitude (Lon)\",east],"];
    [text appendString:@"ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]],"];
    [text appendString:@"ID[\"EPSG\",4326]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"GEOGCS[\"WGS 84\",DATUM[\"WGS_1984\","];
    [text appendString:@"SPHEROID[\"WGS 84\",6378137,298.257223563,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"7030\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"6326\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.01745329251994328,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"9122\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"4326\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"GEOGCRS[\"WGS 84\",DATUM[\"WGS_1984\","];
    [expectedText appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,"];
    [expectedText appendString:@"ID[\"EPSG\",7030]],ID[\"EPSG\",6326]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],"];
    [expectedText appendString:@"AXIS[\"Lon\",east],AXIS[\"Lat\",north],"];
    [expectedText appendString:@"UNIT[\"degree\",0.01745329251994328,"];
    [expectedText appendString:@"ID[\"EPSG\",9122]],ID[\"EPSG\",4326]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"GEOGCS[\"WGS 84\",DATUM[\"WGS_1984\","];
    [text appendString:@"SPHEROID[\"WGS84\",6378137,298.257223563]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"GEOGCRS[\"WGS 84\",DATUM[\"WGS_1984\","];
    [expectedText appendString:@"ELLIPSOID[\"WGS84\",6378137,298.257223563]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"Lon\",east],AXIS[\"Lat\",north],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
}

/**
 * Test EPSG 4979
 */
-(void) test4979{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"GEOGCRS[\"WGS 84\",ENSEMBLE[\"World Geodetic System 1984 ensemble\","];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (Transit)\",ID[\"EPSG\",1166]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G730)\",ID[\"EPSG\",1152]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G873)\",ID[\"EPSG\",1153]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1150)\",ID[\"EPSG\",1154]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1674)\",ID[\"EPSG\",1155]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1762)\",ID[\"EPSG\",1156]],"];
    [text appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,ID[\"EPSG\",7030]],"];
    [text appendString:@"ENSEMBLEACCURACY[2],ID[\"EPSG\",6326]],"];
    [text appendString:@"CS[ellipsoidal,3,ID[\"EPSG\",6423]],"];
    [text appendString:@"AXIS[\"Geodetic latitude (Lat)\",north,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"AXIS[\"Geodetic longitude (Lon)\",east,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"AXIS[\"Ellipsoidal height (h)\",up,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],ID[\"EPSG\",4979]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"GEOGCS[\"WGS 84\","];
    [text appendString:@"DATUM[\"World Geodetic System 1984\","];
    [text appendString:@"SPHEROID[\"WGS 84\",6378137.0,298.257223563,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"7030\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"6326\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0.0,AUTHORITY[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.017453292519943295],"];
    [text appendString:@"AXIS[\"Geodetic latitude\",NORTH],"];
    [text appendString:@"AXIS[\"Geodetic longitude\",EAST],"];
    [text appendString:@"AXIS[\"Ellipsoidal height\",UP],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"4979\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"GEOGCRS[\"WGS 84\","];
    [expectedText appendString:@"DATUM[\"World Geodetic System 1984\","];
    [expectedText appendString:@"ELLIPSOID[\"WGS 84\",6378137.0,298.257223563,"];
    [expectedText appendString:@"ID[\"EPSG\",7030]],ID[\"EPSG\",6326]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0.0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"CS[ellipsoidal,3],AXIS[\"Geodetic latitude\",north],"];
    [expectedText appendString:@"AXIS[\"Geodetic longitude\",east],"];
    [expectedText appendString:@"AXIS[\"Ellipsoidal height\",up],"];
    [expectedText appendString:@"UNIT[\"degree\",0.017453292519943295],"];
    [expectedText appendString:@"ID[\"EPSG\",4979]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"GEODCRS[\"WGS 84\",DATUM[\"World Geodetic System 1984\","];
    [text appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,"];
    [text appendString:@"LENGTHUNIT[\"metre\",1.0]]],CS[ellipsoidal,3],"];
    [text appendString:@"AXIS[\"Geodetic latitude (Lat)\",north,"];
    [text appendString:@"ANGLEUNIT[\"degree\",0.0174532925199433]],"];
    [text appendString:@"AXIS[\"Geodetic longitude (Long)\",east,"];
    [text appendString:@"ANGLEUNIT[\"degree\",0.017453292519943295]],"];
    [text appendString:@"AXIS[\"Ellipsoidal height (h)\",up,"];
    [text appendString:@"LENGTHUNIT[\"metre\",1.0]],ID[\"EPSG\",4979]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

}

/**
 * Test EPSG 5041
 */
-(void) test5041{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"PROJCRS[\"WGS 84 / UPS North (E,N)\",BASEGEOGCRS[\"WGS 84\","];
    [text appendString:@"ENSEMBLE[\"World Geodetic System 1984 ensemble\","];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (Transit)\",ID[\"EPSG\",1166]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G730)\",ID[\"EPSG\",1152]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G873)\",ID[\"EPSG\",1153]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1150)\",ID[\"EPSG\",1154]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1674)\",ID[\"EPSG\",1155]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1762)\",ID[\"EPSG\",1156]],"];
    [text appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,ID[\"EPSG\",7030]],"];
    [text appendString:@"ENSEMBLEACCURACY[2],ID[\"EPSG\",6326]],ID[\"EPSG\",4326]],"];
    [text appendString:@"CONVERSION[\"Universal Polar Stereographic North\","];
    [text appendString:@"METHOD[\"Polar Stereographic (variant A)\",ID[\"EPSG\",9810]],"];
    [text appendString:@"PARAMETER[\"Latitude of natural origin\",90,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Longitude of natural origin\",0,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Scale factor at natural origin\",0.994,SCALEUNIT[\"unity\",1,ID[\"EPSG\",9201]]],"];
    [text appendString:@"PARAMETER[\"False easting\",2000000,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"PARAMETER[\"False northing\",2000000,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"ID[\"EPSG\",16061]],CS[Cartesian,2,ID[\"EPSG\",1026]],"];
    [text appendString:@"AXIS[\"Easting (E)\",South,MERIDIAN[90.0,ANGLEUNIT[\"degree\",0.0174532925199433]]],"];
    [text appendString:@"AXIS[\"Northing (N)\",South,MERIDIAN[180.0,ANGLEUNIT[\"degree\",0.0174532925199433]]],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",5041]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = [NSMutableString stringWithString:[text stringByReplacingOccurrencesOfString:@"South" withString:@"south"]];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"WGS 84 / UPS North (E,N)\","];
    [text appendString:@"GEOGCS[\"WGS 84\",DATUM[\"WGS_1984\","];
    [text appendString:@"SPHEROID[\"WGS 84\",6378137,298.257223563,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"7030\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"6326\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"9122\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"4326\"]],"];
    [text appendString:@"PROJECTION[\"Polar_Stereographic\"],"];
    [text appendString:@"PARAMETER[\"latitude_of_origin\",90],"];
    [text appendString:@"PARAMETER[\"central_meridian\",0],"];
    [text appendString:@"PARAMETER[\"scale_factor\",0.994],"];
    [text appendString:@"PARAMETER[\"false_easting\",2000000],"];
    [text appendString:@"PARAMETER[\"false_northing\",2000000],"];
    [text appendString:@"UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],"];
    [text appendString:@"AXIS[\"Easting\",EAST],AXIS[\"Northing\",NORTH],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"5041\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"WGS 84 / UPS North (E,N)\",BASEGEOGCRS[\"WGS 84\","];
    [expectedText appendString:@"DATUM[\"WGS_1984\","];
    [expectedText appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,"];
    [expectedText appendString:@"ID[\"EPSG\",7030]],ID[\"EPSG\",6326]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9122]],"];
    [expectedText appendString:@"ID[\"EPSG\",4326]],"];
    [expectedText appendString:@"CONVERSION[\"WGS 84 / UPS North (E,N) / Polar_Stereographic\",METHOD[\"Polar_Stereographic\"],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_origin\",90],PARAMETER[\"central_meridian\",0],"];
    [expectedText appendString:@"PARAMETER[\"scale_factor\",0.994],PARAMETER[\"false_easting\",2000000],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",2000000]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"Easting\",east],AXIS[\"Northing\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [expectedText appendString:@"ID[\"EPSG\",5041]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"PROJCRS[\"WGS 84 / UPS North (E,N)\","];
    [text appendString:@"BASEGEODCRS[\"WGS 84\","];
    [text appendString:@"DATUM[\"World Geodetic System 1984\","];
    [text appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,"];
    [text appendString:@"LENGTHUNIT[\"metre\",1]]]],"];
    [text appendString:@"CONVERSION[\"WGS 84 / UPS North (E,N) / Universal Polar Stereographic North\","];
    [text appendString:@"METHOD[\"Polar Stereographic (variant A)\",ID[\"EPSG\",\"9810\"]],"];
    [text appendString:@"PARAMETER[\"Latitude of natural origin\",90,"];
    [text appendString:@"ANGLEUNIT[\"degree\",0.0174532925199433]],"];
    [text appendString:@"PARAMETER[\"Longitude of natural origin\",0,"];
    [text appendString:@"ANGLEUNIT[\"degree\",0.0174532925199433]],"];
    [text appendString:@"PARAMETER[\"Scale factor at natural origin\",0.994,"];
    [text appendString:@"SCALEUNIT[\"unity\",1]],"];
    [text appendString:@"PARAMETER[\"False easting\",2000000,"];
    [text appendString:@"LENGTHUNIT[\"metre\",1]],"];
    [text appendString:@"PARAMETER[\"False northing\",2000000,"];
    [text appendString:@"LENGTHUNIT[\"metre\",1]],ID[\"EPSG\",\"16061\"]],"];
    [text appendString:@"CS[Cartesian,2],AXIS[\"Easting (E)\",south,"];
    [text appendString:@"MERIDIAN[90,ANGLEUNIT[\"degree\",0.0174532925199433]],"];
    [text appendString:@"ORDER[1]],AXIS[\"Northing (N)\",south,"];
    [text appendString:@"MERIDIAN[180,ANGLEUNIT[\"degree\",0.0174532925199433]],"];
    [text appendString:@"ORDER[2]],LENGTHUNIT[\"metre\",1],"];
    [text appendString:@"ID[\"EPSG\",\"5041\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString stringWithString:[text stringByReplacingOccurrencesOfString:@"\"9810\"" withString:@"9810"]];
    expectedText = [NSMutableString stringWithString:[expectedText stringByReplacingOccurrencesOfString:@"\"16061\"" withString:@"16061"]];
    expectedText = [NSMutableString stringWithString:[expectedText stringByReplacingOccurrencesOfString:@"\"5041\"" withString:@"5041"]];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

}

/**
 * Test EPSG 5042
 */
-(void) test5042{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"PROJCRS[\"WGS 84 / UPS South (E,N)\",BASEGEOGCRS[\"WGS 84\","];
    [text appendString:@"ENSEMBLE[\"World Geodetic System 1984 ensemble\","];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (Transit)\",ID[\"EPSG\",1166]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G730)\",ID[\"EPSG\",1152]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G873)\",ID[\"EPSG\",1153]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1150)\",ID[\"EPSG\",1154]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1674)\",ID[\"EPSG\",1155]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1762)\",ID[\"EPSG\",1156]],"];
    [text appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,ID[\"EPSG\",7030]],"];
    [text appendString:@"ENSEMBLEACCURACY[2],ID[\"EPSG\",6326]],ID[\"EPSG\",4326]],"];
    [text appendString:@"CONVERSION[\"Universal Polar Stereographic South\","];
    [text appendString:@"METHOD[\"Polar Stereographic (variant A)\",ID[\"EPSG\",9810]],"];
    [text appendString:@"PARAMETER[\"Latitude of natural origin\",-90,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Longitude of natural origin\",0,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Scale factor at natural origin\",0.994,SCALEUNIT[\"unity\",1,ID[\"EPSG\",9201]]],"];
    [text appendString:@"PARAMETER[\"False easting\",2000000,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"PARAMETER[\"False northing\",2000000,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"ID[\"EPSG\",16161]],CS[Cartesian,2,ID[\"EPSG\",1027]],"];
    [text appendString:@"AXIS[\"Easting (E)\",North,MERIDIAN[90.0,ANGLEUNIT[\"degree\",0.0174532925199433]]],"];
    [text appendString:@"AXIS[\"Northing (N)\",North,MERIDIAN[0.0,ANGLEUNIT[\"degree\",0.0174532925199433]]],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",5042]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = [NSMutableString stringWithString:[text stringByReplacingOccurrencesOfString:@",North" withString:@",north"]];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"WGS 84 / UPS South (E,N)\","];
    [text appendString:@"GEOGCS[\"WGS 84\",DATUM[\"WGS_1984\","];
    [text appendString:@"SPHEROID[\"WGS 84\",6378137,298.257223563,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"7030\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"6326\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"9122\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"4326\"]],"];
    [text appendString:@"PROJECTION[\"Polar_Stereographic\"],"];
    [text appendString:@"PARAMETER[\"latitude_of_origin\",-90],"];
    [text appendString:@"PARAMETER[\"central_meridian\",0],"];
    [text appendString:@"PARAMETER[\"scale_factor\",0.994],"];
    [text appendString:@"PARAMETER[\"false_easting\",2000000],"];
    [text appendString:@"PARAMETER[\"false_northing\",2000000],"];
    [text appendString:@"UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],"];
    [text appendString:@"AXIS[\"Easting\",EAST],AXIS[\"Northing\",NORTH],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"5042\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"WGS 84 / UPS South (E,N)\","];
    [expectedText appendString:@"BASEGEOGCRS[\"WGS 84\",DATUM[\"WGS_1984\","];
    [expectedText appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,"];
    [expectedText appendString:@"ID[\"EPSG\",7030]],ID[\"EPSG\",6326]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [expectedText appendString:@"ID[\"EPSG\",9122]],ID[\"EPSG\",4326]],"];
    [expectedText appendString:@"CONVERSION[\"WGS 84 / UPS South (E,N) / Polar_Stereographic\",METHOD[\"Polar_Stereographic\"],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_origin\",-90],"];
    [expectedText appendString:@"PARAMETER[\"central_meridian\",0],"];
    [expectedText appendString:@"PARAMETER[\"scale_factor\",0.994],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",2000000],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",2000000]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],"];
    [expectedText appendString:@"AXIS[\"Easting\",east],AXIS[\"Northing\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",5042]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"PROJCRS[\"WGS 84 / UPS South (E,N)\","];
    [text appendString:@"BASEGEODCRS[\"WGS 84\","];
    [text appendString:@"DATUM[\"World Geodetic System 1984\","];
    [text appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,"];
    [text appendString:@"LENGTHUNIT[\"metre\",1.0]]]],"];
    [text appendString:@"CONVERSION[\"Universal Polar Stereographic North\","];
    [text appendString:@"METHOD[\"Polar Stereographic (variant A)\",ID[\"EPSG\",\"9810\"]],"];
    [text appendString:@"PARAMETER[\"Latitude of natural origin\",-90,"];
    [text appendString:@"ANGLEUNIT[\"degree\",0.0174532925199433]],"];
    [text appendString:@"PARAMETER[\"Longitude of natural origin\",0,"];
    [text appendString:@"ANGLEUNIT[\"degree\",0.0174532925199433]],"];
    [text appendString:@"PARAMETER[\"Scale factor at natural origin\",0.994,"];
    [text appendString:@"SCALEUNIT[\"unity\",1.0]],"];
    [text appendString:@"PARAMETER[\"False easting\",2000000,"];
    [text appendString:@"LENGTHUNIT[\"metre\",1.0]],"];
    [text appendString:@"PARAMETER[\"False northing\",2000000,"];
    [text appendString:@"LENGTHUNIT[\"metre\",1.0]],ID[\"EPSG\",\"16161\"]],"];
    [text appendString:@"CS[Cartesian,2],AXIS[\"Easting (E)\",north,"];
    [text appendString:@"MERIDIAN[90,ANGLEUNIT[\"degree\",0.0174532925199433]],"];
    [text appendString:@"ORDER[1]],AXIS[\"Northing (N)\",north,"];
    [text appendString:@"MERIDIAN[0,ANGLEUNIT[\"degree\",0.0174532925199433]],"];
    [text appendString:@"ORDER[2]],LENGTHUNIT[\"metre\",1.0],"];
    [text appendString:@"ID[\"EPSG\",\"5042\"]]"];

    crs = [CRSReader read:text withStrict:YES];
    
    expectedText = [NSMutableString stringWithString:[text stringByReplacingOccurrencesOfString:@"\"9810\"" withString:@"9810"]];
    expectedText = [NSMutableString stringWithString:[expectedText stringByReplacingOccurrencesOfString:@"\"16161\"" withString:@"16161"]];
    expectedText = [NSMutableString stringWithString:[expectedText stringByReplacingOccurrencesOfString:@"\"5042\"" withString:@"5042"]];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

}

/**
 * Test EPSG 5714
 */
-(void) test5714{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"VERTCRS[\"MSL height\",VDATUM[\"Mean Sea Level\",ID[\"EPSG\",5100]],"];
    [text appendString:@"CS[vertical,1,ID[\"EPSG\",6499]],"];
    [text appendString:@"AXIS[\"Gravity-related height (H)\",up],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [text appendString:@"ID[\"EPSG\",5714]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"VERT_CS[\"mean sea level height\","];
    [text appendString:@"VERT_DATUM[\"Mean Sea Level\",2005,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"5100\"]],"];
    [text appendString:@"UNIT[\"m\",1.0],AXIS[\"Gravity-related height\",UP],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"5714\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"VERTCRS[\"mean sea level height\","];
    [expectedText appendString:@"VDATUM[\"Mean Sea Level\",ID[\"EPSG\",5100]],"];
    [expectedText appendString:@"CS[vertical,1],AXIS[\"Gravity-related height\",up],"];
    [expectedText appendString:@"UNIT[\"m\",1.0],ID[\"EPSG\",5714]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"VERTCRS[\"MSL height\",VDATUM[\"Mean Sea Level\","];
    [text appendString:@"ANCHOR[\"The average height of the surface of the sea at a tide station for all stages of the tide over a 19-year period, usually determined from hourly height readings measured from a fixed predetermined reference level.\"]],"];
    [text appendString:@"CS[vertical,1],"];
    [text appendString:@"AXIS[\"Gravity-related height (H)\",up],LENGTHUNIT[\"metre\",1.0],"];
    [text appendString:@"ID[\"EPSG\",\"5714\"]]"];

    crs = [CRSReader read:text withStrict:YES];
    
    expectedText = [NSMutableString stringWithString:[text stringByReplacingOccurrencesOfString:@"\"5714\"" withString:@"5714"]];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

}

/**
 * Test EPSG 5715
 */
-(void) test5715{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"VERTCRS[\"MSL depth\",VDATUM[\"Mean Sea Level\",ID[\"EPSG\",5100]],"];
    [text appendString:@"CS[vertical,1,ID[\"EPSG\",6498]],"];
    [text appendString:@"AXIS[\"Depth (D)\",down],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [text appendString:@"ID[\"EPSG\",5715]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"VERT_CS[\"mean sea level depth\","];
    [text appendString:@"VERT_DATUM[\"Mean Sea Level\",2005,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"5100\"]],"];
    [text appendString:@"UNIT[\"m\",1.0],AXIS[\"Gravity-related depth\",DOWN],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"5715\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"VERTCRS[\"mean sea level depth\",VDATUM[\"Mean Sea Level\",ID[\"EPSG\",5100]],"];
    [expectedText appendString:@"CS[vertical,1],AXIS[\"Gravity-related depth\",down],"];
    [expectedText appendString:@"UNIT[\"m\",1.0],ID[\"EPSG\",5715]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"VERTCRS[\"MSL depth\",VDATUM[\"Mean Sea Level\","];
    [text appendString:@"ANCHOR[\"The average height of the surface of the sea at a tide station for all stages of the tide over a 19-year period, usually determined from hourly height readings measured from a fixed predetermined reference level.\"]],"];
    [text appendString:@"CS[vertical,1],"];
    [text appendString:@"AXIS[\"Depth (D)\",down],LENGTHUNIT[\"metre\",1.0],"];
    [text appendString:@"ID[\"EPSG\",\"5715\"]]"];

    crs = [CRSReader read:text withStrict:YES];
    
    expectedText = [NSMutableString stringWithString:[text stringByReplacingOccurrencesOfString:@"\"5715\"" withString:@"5715"]];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

}

/**
 * Test EPSG 5773
 */
-(void) test5773{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"VERTCRS[\"EGM96 height\",VDATUM[\"EGM96 geoid\",ID[\"EPSG\",5171]],"];
    [text appendString:@"CS[vertical,1,ID[\"EPSG\",6499]],"];
    [text appendString:@"AXIS[\"Gravity-related height (H)\",up],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [text appendString:@"ID[\"EPSG\",5773]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"VERT_CS[\"EGM96 geoid\","];
    [text appendString:@"VERT_DATUM[\"EGM96 geoid\",2005,AUTHORITY[\"EPSG\",\"5171\"]],"];
    [text appendString:@"UNIT[\"m\",1.0],AXIS[\"Gravity-related height\",UP],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"5773\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"VERTCRS[\"EGM96 geoid\","];
    [expectedText appendString:@"VDATUM[\"EGM96 geoid\",ID[\"EPSG\",5171]],"];
    [expectedText appendString:@"CS[vertical,1],AXIS[\"Gravity-related height\",up],"];
    [expectedText appendString:@"UNIT[\"m\",1.0],ID[\"EPSG\",5773]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"VERTCRS[\"EGM96 geoid height\","];
    [text appendString:@"VDATUM[\"EGM96 geoid\",ANCHOR[\"WGS 84 ellipsoid\"]],"];
    [text appendString:@"CS[vertical,1],"];
    [text appendString:@"AXIS[\"Gravity-related height (H)\",up],LENGTHUNIT[\"metre\",1.0],"];
    [text appendString:@"ID[\"EPSG\",\"5773\"]]"];

    crs = [CRSReader read:text withStrict:YES];
    
    expectedText = [NSMutableString stringWithString:[text stringByReplacingOccurrencesOfString:@"\"5773\"" withString:@"5773"]];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

}

/**
 * Test EPSG 7405
 */
-(void) test7405{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"COMPOUNDCRS[\"OSGB36 / British National Grid + ODN height\","];
    [text appendString:@"PROJCRS[\"OSGB36 / British National Grid\",BASEGEOGCRS[\"OSGB36\","];
    [text appendString:@"DATUM[\"Ordnance Survey of Great Britain 1936\","];
    [text appendString:@"ELLIPSOID[\"Airy 1830\",6377563.396,299.3249646,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [text appendString:@"ID[\"EPSG\",7001]],ID[\"EPSG\",6277]],ID[\"EPSG\",4277]],"];
    [text appendString:@"CONVERSION[\"British National Grid\",METHOD[\"Transverse Mercator\",ID[\"EPSG\",9807]],"];
    [text appendString:@"PARAMETER[\"Latitude of natural origin\",49,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Longitude of natural origin\",-2,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Scale factor at natural origin\",0.999601272,SCALEUNIT[\"unity\",1,ID[\"EPSG\",9201]]],"];
    [text appendString:@"PARAMETER[\"False easting\",400000,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"PARAMETER[\"False northing\",-100000,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],ID[\"EPSG\",19916]],"];
    [text appendString:@"CS[Cartesian,2,ID[\"EPSG\",4400]],"];
    [text appendString:@"AXIS[\"Easting (E)\",east],AXIS[\"Northing (N)\",north],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",27700]],"];
    [text appendString:@"VERTCRS[\"ODN height\",VDATUM[\"Ordnance Datum Newlyn\",ID[\"EPSG\",5101]],"];
    [text appendString:@"CS[vertical,1,ID[\"EPSG\",6499]],"];
    [text appendString:@"AXIS[\"Gravity-related height (H)\",up],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",5701]],"];
    [text appendString:@"ID[\"EPSG\",7405]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"COMPD_CS[\"OSGB 1936 / British National Grid + ODN height\","];
    [text appendString:@"PROJCS[\"OSGB 1936 / British National Grid\",GEOGCS[\"OSGB 1936\","];
    [text appendString:@"DATUM[\"OSGB_1936\","];
    [text appendString:@"SPHEROID[\"Airy 1830\",6377563.396,299.3249646,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"7001\"]],"];
    [text appendString:@"TOWGS84[446.448,-125.157,542.06,0.15,0.247,0.842,-20.489],AUTHORITY[\"EPSG\",\"6277\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"9122\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"4277\"]],"];
    [text appendString:@"PROJECTION[\"Transverse_Mercator\"],"];
    [text appendString:@"PARAMETER[\"latitude_of_origin\",49],"];
    [text appendString:@"PARAMETER[\"central_meridian\",-2],"];
    [text appendString:@"PARAMETER[\"scale_factor\",0.9996012717],"];
    [text appendString:@"PARAMETER[\"false_easting\",400000],"];
    [text appendString:@"PARAMETER[\"false_northing\",-100000],"];
    [text appendString:@"UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],"];
    [text appendString:@"AXIS[\"Easting\",EAST],AXIS[\"Northing\",NORTH],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"27700\"]],"];
    [text appendString:@"VERT_CS[\"ODN height\",VERT_DATUM[\"Ordnance Datum Newlyn\",2005,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"5101\"]],"];
    [text appendString:@"UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],"];
    [text appendString:@"AXIS[\"Up\",UP],AUTHORITY[\"EPSG\",\"5701\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"7405\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"COMPOUNDCRS[\"OSGB 1936 / British National Grid + ODN height\","];
    [expectedText appendString:@"PROJCRS[\"OSGB 1936 / British National Grid\",BASEGEOGCRS[\"OSGB 1936\","];
    [expectedText appendString:@"DATUM[\"OSGB_1936\","];
    [expectedText appendString:@"ELLIPSOID[\"Airy 1830\",6377563.396,299.3249646,"];
    [expectedText appendString:@"ID[\"EPSG\",7001]],ID[\"EPSG\",6277]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433,"];
    [expectedText appendString:@"ID[\"EPSG\",9122]],ID[\"EPSG\",4277]],"];
    [expectedText appendString:@"CONVERSION[\"OSGB 1936 / British National Grid / Transverse_Mercator\",METHOD[\"Transverse_Mercator\"],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_origin\",49],"];
    [expectedText appendString:@"PARAMETER[\"central_meridian\",-2],"];
    [expectedText appendString:@"PARAMETER[\"scale_factor\",0.9996012717],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",400000],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",-100000],"];
    [expectedText appendString:@"PARAMETER[\"X-axis translation\",446.448,LENGTHUNIT[\"metre\",1]],"];
    [expectedText appendString:@"PARAMETER[\"Y-axis translation\",-125.157,LENGTHUNIT[\"metre\",1]],"];
    [expectedText appendString:@"PARAMETER[\"Z-axis translation\",542.06,LENGTHUNIT[\"metre\",1]],"];
    [expectedText appendString:@"PARAMETER[\"X-axis rotation\",0.15,ANGLEUNIT[\"arc-second\",4.8481368111E-06]],"];
    [expectedText appendString:@"PARAMETER[\"Y-axis rotation\",0.247,ANGLEUNIT[\"arc-second\",4.8481368111E-06]],"];
    [expectedText appendString:@"PARAMETER[\"Z-axis rotation\",0.842,ANGLEUNIT[\"arc-second\",4.8481368111E-06]],"];
    [expectedText appendString:@"PARAMETER[\"Scale difference\",-20.489,SCALEUNIT[\"parts per million\",1E-06]]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"Easting\",east],AXIS[\"Northing\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",27700]],"];
    [expectedText appendString:@"VERTCRS[\"ODN height\",VDATUM[\"Ordnance Datum Newlyn\","];
    [expectedText appendString:@"ID[\"EPSG\",5101]],"];
    [expectedText appendString:@"CS[vertical,1],AXIS[\"Up\",up],UNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",5701]],"];
    [expectedText appendString:@"ID[\"EPSG\",7405]]"];
    
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

}

/**
 * Test EPSG 9801
 */
-(void) test9801{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"PROJCS[\"Lambert_Conformal_Conic (1SP)\","];
    [text appendString:@"GEODCRS[\"GCS_North_American_1983\","];
    [text appendString:@"DATUM[\"North_American_Datum_1983\","];
    [text appendString:@"SPHEROID[\"GRS_1980\",6371000,0]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0],"];
    [text appendString:@"UNIT[\"Degree\",0.017453292519943295]],"];
    [text appendString:@"PROJECTION[\"Lambert_Conformal_Conic_1SP\"],"];
    [text appendString:@"PARAMETER[\"latitude_of_origin\",25],"];
    [text appendString:@"PARAMETER[\"central_meridian\",-95],"];
    [text appendString:@"PARAMETER[\"scale_factor\",1],"];
    [text appendString:@"PARAMETER[\"false_easting\",0],"];
    [text appendString:@"PARAMETER[\"false_northing\",0],"];
    [text appendString:@"PARAMETER[\"standard_parallel_1\",25],"];
    [text appendString:@"UNIT[\"Meter\",1],AUTHORITY[\"EPSG\",\"9801\"]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"Lambert_Conformal_Conic (1SP)\","];
    [expectedText appendString:@"BASEGEODCRS[\"GCS_North_American_1983\","];
    [expectedText appendString:@"DATUM[\"North_American_Datum_1983\","];
    [expectedText appendString:@"ELLIPSOID[\"GRS_1980\",6371000,0]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0],"];
    [expectedText appendString:@"UNIT[\"Degree\",0.017453292519943295]],"];
    [expectedText appendString:@"CONVERSION[\"Lambert_Conformal_Conic (1SP) / Lambert_Conformal_Conic_1SP\",METHOD[\"Lambert_Conformal_Conic_1SP\"],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_origin\",25],"];
    [expectedText appendString:@"PARAMETER[\"central_meridian\",-95],"];
    [expectedText appendString:@"PARAMETER[\"scale_factor\",1],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",0],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",0],"];
    [expectedText appendString:@"PARAMETER[\"standard_parallel_1\",25]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"X\",east],AXIS[\"Y\",north],"];
    [expectedText appendString:@"UNIT[\"Meter\",1],ID[\"EPSG\",9801]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
}

/**
 * Test EPSG 9802
 */
-(void) test9802{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"PROJCS[\"Lambert Conic Conformal (2SP)\","];
    [text appendString:@"GEODCRS[\"GCS_North_American_1983\","];
    [text appendString:@"DATUM[\"North_American_Datum_1983\","];
    [text appendString:@"SPHEROID[\"GRS_1980\",6378160,298.2539162964695]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433]],"];
    [text appendString:@"PROJECTION[\"Lambert_Conformal_Conic_2SP\"],"];
    [text appendString:@"PARAMETER[\"standard_parallel_1\",30],"];
    [text appendString:@"PARAMETER[\"standard_parallel_2\",60],"];
    [text appendString:@"PARAMETER[\"latitude_of_origin\",30],"];
    [text appendString:@"PARAMETER[\"central_meridian\",126],"];
    [text appendString:@"PARAMETER[\"false_easting\",0],"];
    [text appendString:@"PARAMETER[\"false_northing\",0],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"9802\"]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"Lambert Conic Conformal (2SP)\","];
    [expectedText appendString:@"BASEGEODCRS[\"GCS_North_American_1983\","];
    [expectedText appendString:@"DATUM[\"North_American_Datum_1983\","];
    [expectedText appendString:@"ELLIPSOID[\"GRS_1980\",6378160,298.2539162964695]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433]],"];
    [expectedText appendString:@"CONVERSION[\"Lambert Conic Conformal (2SP)\",METHOD[\"Lambert_Conformal_Conic_2SP\"],"];
    [expectedText appendString:@"PARAMETER[\"standard_parallel_1\",30],"];
    [expectedText appendString:@"PARAMETER[\"standard_parallel_2\",60],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_origin\",30],"];
    [expectedText appendString:@"PARAMETER[\"central_meridian\",126],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",0],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",0]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"X\",east],AXIS[\"Y\",north],"];
    [expectedText appendString:@"ID[\"EPSG\",9802]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
}

/**
 * Test EPSG 32660
 */
-(void) test32660{
    
    NSMutableString *text = [NSMutableString string];
    [text appendString:@"PROJCRS[\"WGS 84 / UTM zone 60N\",BASEGEOGCRS[\"WGS 84\","];
    [text appendString:@"ENSEMBLE[\"World Geodetic System 1984 ensemble\","];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (Transit)\",ID[\"EPSG\",1166]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G730)\",ID[\"EPSG\",1152]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G873)\",ID[\"EPSG\",1153]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1150)\",ID[\"EPSG\",1154]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1674)\",ID[\"EPSG\",1155]],"];
    [text appendString:@"MEMBER[\"World Geodetic System 1984 (G1762)\",ID[\"EPSG\",1156]],"];
    [text appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,ID[\"EPSG\",7030]],"];
    [text appendString:@"ENSEMBLEACCURACY[2],ID[\"EPSG\",6326]],ID[\"EPSG\",4326]],"];
    [text appendString:@"CONVERSION[\"UTM zone 60N\",METHOD[\"Transverse Mercator\",ID[\"EPSG\",9807]],"];
    [text appendString:@"PARAMETER[\"Latitude of natural origin\",0,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Longitude of natural origin\",177,ANGLEUNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9102]]],"];
    [text appendString:@"PARAMETER[\"Scale factor at natural origin\",0.9996,SCALEUNIT[\"unity\",1,ID[\"EPSG\",9201]]],"];
    [text appendString:@"PARAMETER[\"False easting\",500000,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],"];
    [text appendString:@"PARAMETER[\"False northing\",0,LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]]],ID[\"EPSG\",16060]],"];
    [text appendString:@"CS[Cartesian,2,ID[\"EPSG\",4400]],AXIS[\"Easting (E)\",east],AXIS[\"Northing (N)\",north],"];
    [text appendString:@"LENGTHUNIT[\"metre\",1,ID[\"EPSG\",9001]],ID[\"EPSG\",32660]]"];

    CRSObject *crs = [CRSReader read:text withStrict:YES];

    NSMutableString *expectedText = text;

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"WGS 84 / UTM zone 60N\",GEOGCS[\"WGS 84\","];
    [text appendString:@"DATUM[\"WGS_1984\","];
    [text appendString:@"SPHEROID[\"WGS 84\",6378137,298.257223563,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"7030\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"6326\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.01745329251994328,"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"9122\"]],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"4326\"]],"];
    [text appendString:@"UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],"];
    [text appendString:@"PROJECTION[\"Transverse_Mercator\"],"];
    [text appendString:@"PARAMETER[\"latitude_of_origin\",0],"];
    [text appendString:@"PARAMETER[\"central_meridian\",177],"];
    [text appendString:@"PARAMETER[\"scale_factor\",0.9996],"];
    [text appendString:@"PARAMETER[\"false_easting\",500000],"];
    [text appendString:@"PARAMETER[\"false_northing\",0],"];
    [text appendString:@"AUTHORITY[\"EPSG\",\"32660\"],"];
    [text appendString:@"AXIS[\"Easting\",EAST],AXIS[\"Northing\",NORTH]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"WGS 84 / UTM zone 60N\",BASEGEOGCRS[\"WGS 84\","];
    [expectedText appendString:@"DATUM[\"WGS_1984\","];
    [expectedText appendString:@"ELLIPSOID[\"WGS 84\",6378137,298.257223563,"];
    [expectedText appendString:@"ID[\"EPSG\",7030]],ID[\"EPSG\",6326]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.01745329251994328,"];
    [expectedText appendString:@"ID[\"EPSG\",9122]],ID[\"EPSG\",4326]],"];
    [expectedText appendString:@"CONVERSION[\"WGS 84 / UTM zone 60N / Transverse_Mercator\",METHOD[\"Transverse_Mercator\"],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_origin\",0],"];
    [expectedText appendString:@"PARAMETER[\"central_meridian\",177],"];
    [expectedText appendString:@"PARAMETER[\"scale_factor\",0.9996],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",500000],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",0]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"Easting\",east],AXIS[\"Northing\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [expectedText appendString:@"ID[\"EPSG\",32660]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];

    text = [NSMutableString string];
    [text appendString:@"PROJCS[\"WGS 84 / UTM zone 60N\",GEOGCRS[\"WGS 84\","];
    [text appendString:@"DATUM[\"WGS_1984\","];
    [text appendString:@"SPHEROID[\"WGS84\",6378137,298.257223563,"];
    [text appendString:@"ID[\"EPSG\",\"7030\"]],ID[\"EPSG\",\"6326\"]],"];
    [text appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",\"8901\"]],"];
    [text appendString:@"UNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",\"9122\"]],"];
    [text appendString:@"ID[\"EPSG\",\"4326\"]],"];
    [text appendString:@"PROJECTION[\"Transverse_Mercator\"],"];
    [text appendString:@"PARAMETER[\"latitude_of_origin\",0],"];
    [text appendString:@"PARAMETER[\"central_meridian\",177],"];
    [text appendString:@"PARAMETER[\"scale_factor\",0.9996],"];
    [text appendString:@"PARAMETER[\"false_easting\",500000],"];
    [text appendString:@"PARAMETER[\"false_northing\",0],"];
    [text appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",\"9001\"]],"];
    [text appendString:@"AXIS[\"Easting\",EAST],AXIS[\"Northing\",NORTH],"];
    [text appendString:@"ID[\"EPSG\",\"32660\"]]"];

    crs = [CRSReader read:text withStrict:YES];

    expectedText = [NSMutableString string];
    [expectedText appendString:@"PROJCRS[\"WGS 84 / UTM zone 60N\",BASEGEOGCRS[\"WGS 84\","];
    [expectedText appendString:@"DATUM[\"WGS_1984\","];
    [expectedText appendString:@"ELLIPSOID[\"WGS84\",6378137,298.257223563,"];
    [expectedText appendString:@"ID[\"EPSG\",7030]],ID[\"EPSG\",6326]],"];
    [expectedText appendString:@"PRIMEM[\"Greenwich\",0,ID[\"EPSG\",8901]],"];
    [expectedText appendString:@"UNIT[\"degree\",0.0174532925199433,ID[\"EPSG\",9122]],"];
    [expectedText appendString:@"ID[\"EPSG\",4326]],"];
    [expectedText appendString:@"CONVERSION[\"WGS 84 / UTM zone 60N / Transverse_Mercator\",METHOD[\"Transverse_Mercator\"],"];
    [expectedText appendString:@"PARAMETER[\"latitude_of_origin\",0],"];
    [expectedText appendString:@"PARAMETER[\"central_meridian\",177],"];
    [expectedText appendString:@"PARAMETER[\"scale_factor\",0.9996],"];
    [expectedText appendString:@"PARAMETER[\"false_easting\",500000],"];
    [expectedText appendString:@"PARAMETER[\"false_northing\",0]],"];
    [expectedText appendString:@"CS[ellipsoidal,2],AXIS[\"Easting\",east],AXIS[\"Northing\",north],"];
    [expectedText appendString:@"UNIT[\"metre\",1,ID[\"EPSG\",9001]],"];
    [expectedText appendString:@"ID[\"EPSG\",32660]]"];

    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[crs description]];
    [CRSTestUtils assertEqualWithValue:expectedText andValue2:[CRSWriter write:crs]];
    [CRSTestUtils assertEqualWithValue:[CRSTextUtils pretty:expectedText] andValue2:[CRSWriter writePretty:crs]];
    
}

@end
