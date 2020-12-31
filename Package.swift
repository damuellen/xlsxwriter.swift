// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "xlsxwriter.swift",
  products: [
    .library(name: "xlsxwriter", targets: ["xlsxwriter"]),
  ],
  dependencies: [
    .package(name: "CMinizip", url: "https://github.com/damuellen/CMinizip.swift.git", .branch("master"))
  ],
  targets: [
    .target(
      name: "xlsxwriter", dependencies: ["Cxlsxwriter"]),
    .target(
      name: "Cxlsxwriter", dependencies: ["Cmd5", "Ctmpfileplus", "CMinizip"]),
    .target(
      name: "Cmd5"),
    .target(
      name: "Ctmpfileplus"),
    .testTarget(
      name: "xlsxwriterTests", dependencies: ["xlsxwriter"]
    )
  ]
)
