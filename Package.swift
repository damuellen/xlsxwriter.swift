// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "xlsxwriter.swift",
    products: [
        .library(name: "xlsxwriter", targets: ["xlsxwriter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jmcnamara/libxlsxwriter", .branchItem("main")),
    ],
    targets: [
        .target(
            name: "xlsxwriter",
            dependencies: ["libxlsxwriter"]
        ),
        .testTarget(name: "xlsxwriterTests", dependencies: ["xlsxwriter"]),
    ]
)
