// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Ed25519",
    targets: [
        Target(name: "Ed25519", dependencies: ["CEd25519"])
    ]
)
