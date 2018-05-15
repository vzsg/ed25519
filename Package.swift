// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "Ed25519",
    products: [
        .library(name: "Ed25519", targets: ["Ed25519"]),
    ],
    targets: [
        .target(
            name: "Ed25519",
            dependencies: ["CEd25519"]
        ),
        .target(
            name: "CEd25519",
            dependencies: []
        )
    ],
    swiftLanguageVersions: [4]
)
