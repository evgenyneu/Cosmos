// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Cosmos",
    platforms: [
        .iOS(.v8),
        .tvOS(.v9),
    ],
    products: [
        .library(name: "Cosmos", targets: ["Cosmos"]),
    ],
    targets: [
        .target(name: "Cosmos", path: "./Cosmos"),
        .testTarget(name: "CosmosTests", dependencies: ["Cosmos"], path: "./CosmosTests"),
    ],
    swiftLanguageVersions: [
        .v4_2,
        .v5,
    ]
)
