// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Animals",
    platforms: [.iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Animals",
            targets: ["Animals"]),
    ],
    dependencies: [
        .package(path: "/../DesignSystem"),
        .package(path: "/../Networking"),
        .package(path: "/../Utils")
    ],
    targets: [
        .target(
            name: "Animals",
            dependencies: [
                "DesignSystem",
                "Networking",
                "Utils"
            ]
        ),
        .testTarget(
            name: "AnimalsTests",
            dependencies: ["Animals"]
        ),
    ]
)
