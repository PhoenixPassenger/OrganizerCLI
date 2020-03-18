// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OrganizerCLI",
    dependencies: [
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", from: "1.2.0"),
        .package(url: "https://github.com/kylef/Commander.git", from: "0.9.1"),
    ],
    targets: [

        .target(
            name: "OrganizerCLI",
            dependencies: ["ColorizeSwift","Commander"]),
        .testTarget(
            name: "HelloTOrganizerCLItests",
            dependencies: ["ColorizeSwift","Commander"]),
    ]
)
