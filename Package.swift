// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
      name: "MBKBasic",
      platforms: [
            .iOS(.v15)
      ],
      products: [
            .library(
                  name: "MBKBasic",
                  targets: ["MBKBasic"]),
      ],
      dependencies: [],
      targets: [
            .target(
                  name: "MBKBasic",
                  dependencies: []), 
            .testTarget(
                  name: "MBKBasicTests",
                  dependencies: ["MBKBasic"]),
      ]
)
