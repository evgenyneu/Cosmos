// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Cosmos",
    products: [
        .library(name: "Cosmos", targets: ["Cosmos"]),
    ],
    targets: [
        .target(name: "Cosmos", path: "./Cosmos"),
        .testTarget(name: "CosmosTests", dependencies: ["Cosmos"], path: "./CosmosTests"),
    ]
)
