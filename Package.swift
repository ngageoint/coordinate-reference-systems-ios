// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "CoordinateReferenceSystems",
    platforms: [
        .iOS(.v13), .macOS(.v12)
    ],
    products: [
        .library(
            name: "CoordinateReferenceSystems",
            targets: ["CoordinateReferenceSystems"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CoordinateReferenceSystems",
            dependencies: [
            ],
            path: "crs-ios",
            exclude: [
            ],
            publicHeadersPath: "include"
        ),
        .testTarget(
            name: "CoordinateReferenceSystemsTests",
            dependencies: [
                "CoordinateReferenceSystems",
            ],
            path: "crs-iosTests",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("common"),
                .headerSearchPath("util/proj"),
                .headerSearchPath("wkt"),
            ]
        ),
        .testTarget(
            name: "CoordinateReferenceSystemsTests-Swift",
            dependencies: [
                "CoordinateReferenceSystems",
            ],
            path: "crs-iosTests-swift",
            sources: ["."]
        ),
    ]
)
