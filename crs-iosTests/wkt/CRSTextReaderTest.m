//
//  CRSTextReaderTest.m
//  crs-iosTests
//
//  Created by Brian Osborn on 8/5/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSTextReaderTest.h"
#import "CRSTestUtils.h"
@import CoordinateReferenceSystems;

@implementation CRSTextReaderTest

/**
 * Test double quote
 */
-(void) testDoubleQuote{
    
    CRSTextReader *textReader = [CRSTextReader createWithText:@"\"Datum origin is 30°25'20\"\"N, 130°25'20\"\"E.\""];
    NSString *text = [textReader readExpectedToken];
    [CRSTestUtils assertEqualWithValue:@"Datum origin is 30°25'20\"N, 130°25'20\"E." andValue2:text];
    
}

@end
