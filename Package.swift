// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "xlsxwriter.swift",
  products: [
    .library(name: "xlsxwriter", targets: ["xlsxwriter"]),
  ],
  dependencies: [
    .package(name: "CMinizip", url: "https://github.com/sinoru/CMinizip.swift.git", from: "2.9.1")
  ],
  targets: [
    .target(
      name: "xlsxwriter", dependencies: ["Cxlsxwriter"]),
    .target(
      name: "Cxlsxwriter", dependencies: ["Cmd5", "Ctmpfileplus","CMinizip"]),
    .target(
      name: "Cmd5"),
    .target(
      name: "Ctmpfileplus"),
    .testTarget(
      name: "xlsxwriterTests", dependencies: ["xlsxwriter"]
    )
  ]
)
