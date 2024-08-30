// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "ExpandableText",
		platforms: [
			.iOS(.v15),
			.macOS(.v10_15),
			.watchOS(.v8),
			.tvOS(.v15),
			.visionOS(.v1)
		],
    products: [
        .library(
            name: "ExpandableText",
            targets: ["ExpandableText"]),
    ],
    targets: [
        .target(
            name: "ExpandableText"),
        .testTarget(
            name: "ExpandableTextTests",
            dependencies: ["ExpandableText"]),
    ]
)
