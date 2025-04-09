# Change Log
All notable changes to this project will be documented in this file.
Adheres to [Semantic Versioning](http://semver.org/).

---

## 2.0.0 (6-3-2025)

* Swift Package Manager support exposes public headers and restructures code for SPM format.
* Renamed framework from crs-ios to CoordinateReferenceSystems in SPM (dashes break SPM bundle resources)
* Updated to use `NS_ENUM` for C `enum` for Swift/Objective-C interoperability
* Updated tests (Objective-C based and Swift based tests)
* Removed Cocoapods (deprecated)
* Updated build instructions and github workflows

## [1.0.5](https://github.com/ngageoint/coordinate-reference-systems-ios/releases/tag/1.0.5) (11-07-2023)

* Module definition

## [1.0.4](https://github.com/ngageoint/coordinate-reference-systems-ios/releases/tag/1.0.4) (01-09-2023)

* Imports cleanup and simplification

## [1.0.3](https://github.com/ngageoint/coordinate-reference-systems-ios/releases/tag/1.0.3) (05-04-2022)

* Non projected ETRS89 GeoDatum fix (EPSG:4258)

## [1.0.2](https://github.com/ngageoint/coordinate-reference-systems-ios/releases/tag/1.0.2) (02-09-2022)

* ETRS89 Geo Datums enumeration
* Additional included names in Ellipsoids
* Ellipsoids saved reciprocal flattening value
* Prime Meridians name capitalizations
* Prime Meridians offset from greenwich in degrees

## [1.0.1](https://github.com/ngageoint/coordinate-reference-systems-ios/releases/tag/1.0.1) (10-14-2021)

* Adjustment to OSGB36 datum name and transform
* Projection parsing parameter and unit checking improvements

## [1.0.0](https://github.com/ngageoint/coordinate-reference-systems-ios/releases/tag/1.0.0) (09-16-2021)

* Initial Release
