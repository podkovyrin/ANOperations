// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ANOperations",
    platforms: [
        .iOS(.v10),
        .watchOS(.v2),
        .tvOS(.v10),
        .macOS(.v10_12),
    ],
    products: [
        .library(
            name: "ANOperations",
            targets: ["ANOperations"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ANOperations",
            dependencies: []),
        .testTarget(
            name: "ANOperationsTests",
            dependencies: ["ANOperations"]),
    ]
)
