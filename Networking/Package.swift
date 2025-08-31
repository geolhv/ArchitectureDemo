// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory.git", exact: "2.5.3")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "Factory", package: "Factory")
            ]
        )
    ]
)
