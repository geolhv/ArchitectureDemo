// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Utils",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Utils",
            targets: ["Utils"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/nalexn/ViewInspector.git", exact: "0.10.1")
    ],
    targets: [
        .target(
            name: "Utils"
        ),
        .testTarget(
            name: "UtilsTests",
            dependencies: ["Utils", "ViewInspector"]
        ),
    ]
)
