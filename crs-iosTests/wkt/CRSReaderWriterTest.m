//
//  CRSReaderWriterTest.m
//  crs-iosTests
//
//  Created by Brian Osborn on 8/5/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSReaderWriterTest.h"
#import "CRSTestUtils.h"
#import "CRSReader.h"
#import "CRSWriter.h"

@implementation CRSReaderWriterTest

/**
 * Test scope
 */
-(void) testScope{
    
    NSString *text = @"SCOPE[\"Large scale topographic mapping and cadastre.\"]";
    CRSReader *reader = [CRSReader createWithText:text];
    NSString *scope = [reader readScope];
    [CRSTestUtils assertNotNil:scope];
    [CRSTestUtils assertEqualWithValue:@"Large scale topographic mapping and cadastre." andValue2:scope];
    CRSWriter *writer = [CRSWriter create];
    [writer writeScope:scope];
    [CRSTestUtils assertEqualWithValue:text andValue2:[writer description]];
    
}

/**
 * Test area description
 */
-(void) testAreaDescription{
    
    NSString *text = @"AREA[\"Netherlands offshore.\"]";
    CRSReader *reader = [CRSReader createWithText:text];
    NSString *areaDescription = [reader readAreaDescription];
    [CRSTestUtils assertNotNil:areaDescription];
    [CRSTestUtils assertEqualWithValue:@"Netherlands offshore." andValue2:areaDescription];
    CRSWriter *writer = [CRSWriter create];
    [writer writeAreaDescription:areaDescription];
    [CRSTestUtils assertEqualWithValue:text andValue2:[writer description]];
    
}

/**
 * Test geographic bounding box
 */
-(void) testGeographicBoundingBox{
    
    NSString *text = @"BBOX[51.43,2.54,55.77,6.40]";
    CRSReader *reader = [CRSReader createWithText:text];
    CRSGeographicBoundingBox *boundingBox = [reader readGeographicBoundingBox];
    [CRSTestUtils assertNotNil:boundingBox];
    [CRSTestUtils assertEqualDoubleWithValue:51.43 andValue2:boundingBox.lowerLeftLatitude];
    [CRSTestUtils assertEqualDoubleWithValue:2.54 andValue2:boundingBox.lowerLeftLongitude];
    [CRSTestUtils assertEqualDoubleWithValue:55.77 andValue2:boundingBox.upperRightLatitude];
    [CRSTestUtils assertEqualDoubleWithValue:6.40 andValue2:boundingBox.upperRightLongitude];
    [CRSTestUtils assertEqualWithValue:[text stringByReplacingOccurrencesOfString:@".40" withString:@".4"]
                             andValue2:[boundingBox description]];
    
    text = @"BBOX[-55.95,160.60,-25.88,-171.20]";
    reader = [CRSReader createWithText:text];
    boundingBox = [reader readGeographicBoundingBox];
    [CRSTestUtils assertNotNil:boundingBox];
    [CRSTestUtils assertEqualDoubleWithValue:-55.95 andValue2:boundingBox.lowerLeftLatitude];
    [CRSTestUtils assertEqualDoubleWithValue:160.60 andValue2:boundingBox.lowerLeftLongitude];
    [CRSTestUtils assertEqualDoubleWithValue:-25.88 andValue2:boundingBox.upperRightLatitude];
    [CRSTestUtils assertEqualDoubleWithValue:-171.20 andValue2:boundingBox.upperRightLongitude];
    [CRSTestUtils assertEqualWithValue:[[text stringByReplacingOccurrencesOfString:@".60" withString:@".6"]
                                        stringByReplacingOccurrencesOfString:@".20" withString:@".2"]
                             andValue2:[boundingBox description]];
    
}

@end
