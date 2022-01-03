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
  .target(name: "xlsxwriter", dependencies: ["Cxlsxwriter"]), 
  .testTarget(name: "xlsxwriterTests", dependencies: ["xlsxwriter"]),
]
#endif

#if os(Linux)
let dependencies: [PackageDescription.Package.Dependency] = [
  .package(name: "Cxlsxwriter", url: "https://github.com/damuellen/Cxlsxwriter.git", .branch("linux"))
]
#elseif os(macOS)
let dependencies: [PackageDescription.Package.Dependency] = [
  .package(name: "Cxlsxwriter", url: "https://github.com/damuellen/Cxlsxwriter.git", .branch("mac"))
]
#else
let dependencies: [PackageDescription.Package.Dependency] = []
#endif

let package = Package(
  name: "xlsxwriter.swift",
  products: [
    .library(name: "xlsxwriter", targets: ["xlsxwriter"]),
  ], 
  dependencies: dependencies,
  targets: targets
)
