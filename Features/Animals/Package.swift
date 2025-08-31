// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Animals",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Animals",
            targets: ["Animals"]
        ),
    ],
    dependencies: [
        .package(path: "/../DesignSystem"),
        .package(path: "/../Networking"),
        .package(path: "/../Utils"),
        .package(url: "https://github.com/hmlongco/Factory.git", exact: "2.5.3")
    ],
    targets: [
        .target(
            name: "Animals",
            dependencies: [
                "AnimalsDomain",
                "AnimalsData",
                "DesignSystem",
                .product(name: "Factory", package: "Factory"),
                "Utils"
            ]
        ),
        .target(
            name: "AnimalsData",
            dependencies: [
                "AnimalsDomain",
                .product(name: "Factory", package: "Factory"),
                "Networking"
            ]
        ),
        .target(
            name: "AnimalsDomain"
        ),
        .testTarget(
            name: "AnimalsTests",
            dependencies: ["Animals"]
        ),
    ]
)
