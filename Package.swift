// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Cosmos",
    products: [
        .library(name: "Cosmos", targets: ["Cosmos"]),
    ],
    targets: [
        .target(name: "Cosmos", 
                path: "./Cosmos",
                resources: [.copy("Resources/PrivacyInfo.xcprivacy")]),
        .testTarget(name: "CosmosTests", dependencies: ["Cosmos"], path: "./CosmosTests"),
    ]
)
