// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "xlsxwriter.swift",
  products: [
    .library(name: "xlsxwriter", targets: ["xlsxwriter"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "xlsxwriter", dependencies: ["Cxlsxwriter"]),
    .target(
      name: "Cxlsxwriter",
      dependencies: ["Cmd5", "Ctmpfileplus", "Cminizip"]),
    .target(
      name: "Cmd5"),
    .target(
      name: "Cminizip"),
    .target(
      name: "Ctmpfileplus"),
    .testTarget(
      name: "xlsxwriterTests", dependencies: ["xlsxwriter"]
    )
  ]
)

if let xlsxwriter = package.targets.first(where: { $0.name == "Cxlsxwriter" }) {
#if os(Windows)
  xlsxwriter.linkerSettings = [
    .linkedLibrary("C:/Library/Zlib/x64/Zlib.lib")
  ]  
  xlsxwriter.cxxSettings = [.define("_CRT_SECURE_NO_WARNINGS")]
#else 
    xlsxwriter.linkerSettings = [
    .linkedLibrary("z")
  ]    
#endif
}
