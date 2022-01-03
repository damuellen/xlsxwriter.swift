// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Windows)
let targets: [PackageDescription.Target] = [
  .target(name: "xlsxwriter", dependencies: ["Cxlsxwriter"], linkerSettings: [.linkedLibrary("zlibstatic.lib")]), 
  .target(name: "Cxlsxwriter", dependencies: ["Cmd5", "Ctmpfileplus", "Cminizip"]),
  .target(name: "Cminizip"),
  .target(name: "Ctmpfileplus"),
  .target(name: "Cmd5")
]
targets.filter { $0.name.hasPrefix("C") }.forEach { $0.cxxSettings = [.define("_CRT_SECURE_NO_WARNINGS")] }
#else
let targets: [PackageDescription.Target] = [
  .systemLibrary(name: "Cxlsxwriter", pkgConfig: "xlsxwriter"),
  .target(name: "xlsxwriter", dependencies: ["Cxlsxwriter"]),
  .testTarget(name: "xlsxwriterTests", dependencies: ["xlsxwriter"]),
]
#endif

let package = Package(
  name: "xlsxwriter.swift",
  products: [
    .library(name: "xlsxwriter", targets: ["xlsxwriter"]),
  ],
  targets: targets
)
