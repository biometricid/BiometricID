// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "BiometricidSDK",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "BiometricidSDK",
            targets: ["BiometricidSDK"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "BiometricidSDK",
            url: "https://github.com/biometricid/BiometricID/releases/download/1.0.0/BiometricidSDK.xcframework.zip",
            checksum: "6418835c1567691feb878ca9fe5cf3cd36f17530d21174b009497f95f2370bba"
        ),
    ]
)
