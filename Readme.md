# xlsxwriter.swift

xlsxwriter.swift is a powerful Swift wrapper around Libxlsxwriter, enabling the creation of Excel XLSX files with ease. This library allows developers to generate sophisticated Excel files with various formatting options, text, numbers, formulas, hyperlinks, and much more.

## Getting Started

Before using xlsxwriter.swift, you need to install the Libxlsxwriter C library on your system. Please refer to the [Getting Started](https://libxlsxwriter.github.io/getting_started.html) guide for instructions.

Alternatively, you can use the SPM branch, which compiles the library along with the Swift Package Manager.

### Swift Package Manager

The Swift Package Manager is a convenient tool for managing Swift code distribution. To use xlsxwriter.swift with SPM:

1. Add the following line to your `Package.swift` file in the `dependencies` array:

```swift
dependencies: [
    .package(url: "https://github.com/damuellen/xlsxwriter.swift", branch: "main")
]
```

or, if you want to use the SPM branch:

```swift
dependencies: [
    .package(url: "https://github.com/damuellen/xlsxwriter.swift", branch: "SPM")
]
```

2. Build your project using Swift Package Manager.

For *nix systems:

```sh
$ swift build
```

For Windows:

```sh
$ swift build -Xswiftc -LC:/vcpkg/installed/x64-windows/lib/ -Xcc -IC:/vcpkg/installed/x64-windows/include/
```

*Please note: You need to install the libxlsxwriter C library first; it is not included in the build.*

## Usage

With xlsxwriter.swift, creating Excel XLSX files is straightforward and efficient. The example below demonstrates how to create a new workbook, add a worksheet, and write some data with formatting:

```Swift
import xlsxwriter

// Create a new workbook and add a worksheet.
var wb = Workbook(name: "demo.xlsx")
defer { wb.close() }
let ws = wb.addWorksheet()

// Add a format.
let format = wb.addFormat()

// Set the bold property for the format
format.bold()

// Write some simple text.
ws.write(.string("Hello"), [0, 0])

// Text with formatting.
ws.write(.string("World"), [0, 1], format: format)
```

## About Libxlsxwriter

Libxlsxwriter is a powerful C library that allows developers to write text, numbers, formulas, hyperlinks, and more to multiple worksheets in an Excel 2007+ XLSX file. Some of its key features include compatibility with Excel XLSX files, full Excel formatting support, merged cells, defined names, charts, data validation, and more.

The library is released under the FreeBSD license and works on various platforms, including Linux, FreeBSD, OpenBSD, macOS, iOS, and Windows. It has minimal dependencies and offers high performance even with large files.

The source code for Libxlsxwriter is available on [GitHub](https://github.com/jmcnamara/libxlsxwriter), making it a flexible and reliable choice for creating Excel XLSX files programmatically.

With xlsxwriter.swift, developers can harness the power of Libxlsxwriter in a Swift environment, enabling seamless integration of Excel file generation into their Swift applications.
