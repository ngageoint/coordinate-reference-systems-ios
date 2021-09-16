# Coordinate Reference Systems iOS

#### Coordinate Reference Systems Lib ####

The Coordinate Reference Systems Library was developed at the [National Geospatial-Intelligence Agency (NGA)](http://www.nga.mil/) in collaboration with [BIT Systems](https://www.caci.com/bit-systems/). The government has "unlimited rights" and is releasing this software to increase the impact of government investments by providing developers with the opportunity to take things in new directions. The software use, modification, and distribution rights are stipulated within the [MIT license](http://choosealicense.com/licenses/mit/).

### Pull Requests ###
If you'd like to contribute to this project, please make a pull request. We'll review the pull request and discuss the changes. All pull request contributions to this project will be released under the MIT license.

Software source code previously released under an open source license and then modified by NGA staff is considered a "joint work" (see 17 USC § 101); it is partially copyrighted, partially public domain, and as a whole is protected by the copyrights of the non-government authors and must be released according to the terms of the original open source license.

### About ###

[Coordinate Reference Systems](http://ngageoint.github.io/coordinate-reference-systems-ios/) is an iOS library implementation of OGC's 'Geographic information — Well-known text representation of coordinate reference systems' ([18-010r7](http://docs.opengeospatial.org/is/18-010r7/18-010r7.html)) specification.

For projection conversions between coordinates, see [Projections](https://ngageoint.github.io/projections-ios/).

### Usage ###

View the latest [Appledoc](http://ngageoint.github.io/coordinate-reference-systems-ios/docs/api/)

```objectivec

// NSString *wkt = ...

CRSObject *crs = [CRSReader read:wkt];

enum CRSType type = crs.type;
enum CRSCategoryType category = crs.categoryType;

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

```

#### PROJ ####

```objectivec

// NSString *wkt = ...

CRSObject *crs = [CRSReader read:wkt];

CRSProjParams *projParamsFromCRS = [CRSProjParser paramsFromCRS:crs];
NSString *projTextFromCRS = [CRSProjParser paramsTextFromCRS:crs];
CRSProjParams *projParamsFromWKT = [CRSProjParser paramsFromText:wkt];
NSString *projTextFromWKT = [CRSProjParser paramsTextFromText:wkt];

```

### Build ###

[![Build & Test](https://github.com/ngageoint/coordinate-reference-systems-ios/workflows/Build%20&%20Test/badge.svg)](https://github.com/ngageoint/coordinate-reference-systems-ios/actions/workflows/build-test.yml)

Build this repository using Xcode and/or CocoaPods:

    pod repo update
    pod install

Open crs-ios.xcworkspace in Xcode or build from command line:

    xcodebuild -workspace 'crs-ios.xcworkspace' -scheme crs-ios build

Run tests from Xcode or from command line:

    xcodebuild test -workspace 'crs-ios.xcworkspace' -scheme crs-ios -destination 'platform=iOS Simulator,name=iPhone 12'

### Include Library ###

Include this repository by specifying it in a Podfile using a supported option.

Pull from [CocoaPods](https://cocoapods.org/pods/crs-ios):

    pod 'crs-ios', '~> 1.0.0'

Pull from GitHub:

    pod 'crs-ios', :git => 'https://github.com/ngageoint/coordinate-reference-systems-ios.git', :branch => 'master'
    pod 'crs-ios', :git => 'https://github.com/ngageoint/coordinate-reference-systems-ios.git', :tag => '1.0.0'

Include as local project:

    pod 'crs-ios', :path => '../coordinate-reference-systems-ios'

### Swift ###

To use from Swift, import the crs-ios bridging header from the Swift project's bridging header

    #import "crs-ios-Bridging-Header.h"

```swift

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

```

#### PROJ ####

```swift

// var wkt: String = ...

let crs : CRSObject = CRSReader.read(wkt)

let projParamsFromCRS : CRSProjParams = CRSProjParser.params(fromCRS: crs)
let projTextFromCRS : String = CRSProjParser.paramsText(fromCRS: crs)
let projParamsFromWKT : CRSProjParams = CRSProjParser.params(fromText: wkt)
let projTextFromWKT : String = CRSProjParser.paramsText(fromText: wkt)

```
