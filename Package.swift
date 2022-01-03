// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "xlsxwriter.swift",
  products: [.library(name: "xlsxwriter", targets: ["xlsxwriter"])],
  targets: [
    .systemLibrary(name: "Cxlsxwriter", pkgConfig: "xlsxwriter"),
    .target(name: "xlsxwriter", dependencies: ["Cxlsxwriter"]),
    .testTarget(name: "xlsxwriterTests", dependencies: ["xlsxwriter"]),
  ])