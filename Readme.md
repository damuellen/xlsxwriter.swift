# xlsxwriter.swift

xlsxwriter.swift: A wrapper in Swift around Libxlsxwriter for creating Excel XLSX files.

## The libxlsxwriter library

Libxlsxwriter is a C library that can be used to write text, numbers, formulas
and hyperlinks to multiple worksheets in an Excel 2007+ XLSX file.

It supports features such as:

- 100% compatible Excel XLSX files.
- Full Excel formatting.
- Merged cells.
- Defined names.
- Autofilters.
- Charts.
- Data validation and drop down lists.
- Conditional formatting.
- Worksheet PNG/JPEG images.
- Cell comments.
- Support for adding Macros.
- Memory optimization mode for writing large files.
- Source code available on [GitHub](https://github.com/jmcnamara/libxlsxwriter).
- FreeBSD license.
- ANSI C.
- Works with GCC, Clang, Xcode, MSVC 2015, ICC, TCC, MinGW, MingGW-w64/32.
- Works on Linux, FreeBSD, OpenBSD, OS X, iOS and Windows. Also works on MSYS/MSYS2 and Cygwin.
- Compiles for 32 and 64 bit.
- Compiles and works on big and little endian systems.
- The only dependency is on `zlib`.

Here is an example using Swift:


```Swift


    // Create a new workbook and add a worksheet.
    var wb = Workbook(name: "demo.xlsx")
    defer { wb.close() }
    let ws = wb.addWorksheet()

    // Add a format.
    let format = wb.addFormat()

    // Set the bold property for the format 
    format.set_bold()

    // Write some simple text. 
    ws.write(.string("Hello"), (0, 0))
  
    // Text with formatting.
    ws.write(.string("World"), (0, 0), format: format)


```
