// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
      name: "MBKBasic",
      platforms: [
            .iOS(.v16)
      ],
      products: [
            .library(
                  name: "MBKBasic",
                  targets: ["MBKBasic"]),
      ],
      dependencies: [
        .package(url: "https://github.com/MartinBKock/mbkError.git", branch: "develop")
      ],
      targets: [
            .target(
                  name: "MBKBasic",
                  dependencies: [.product(name: "MBKError", package: "MBKError")]),
            .testTarget(
                  name: "MBKBasicTests",
                  dependencies: ["MBKBasic"]),
      ]
)
