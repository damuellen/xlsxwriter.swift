import XCTest
@testable import xlsxwriter

final class xlsxwriterTests: XCTestCase {
  func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    XCTAssertEqual("", "Hello, World!")
      
    
    var wb = Workbook(name: "demo.xlsx")
    //defer { wb.close() }
    let format = wb.addFormat()
    let ws = wb.addWorksheet()
    //let ws2 = wb.addWorksheet()
    format.set_bold()
    format.set_border(style: .Double)
    format.set(alignment: .Right)
    ws.write(.string("Number"), "A1".cell)
    ws.write(.string("Batch 1"), "B1".cell)
    ws.write(.string("Batch 2"), "C1".cell)
    let data = (1...100).map {
      [Double($0), Double.random(in: 10...100), Double.random(in: 20...50)]
    }
    data.enumerated().forEach { (row) in
      ws.write(row.element, row: row.offset + 1)
    }
    ws.set_default(row_height: 20)
    let cs = wb.addChartsheet()
    let c = wb.add(chart: .Line)
    let s = c.add(series: "=Sheet1!$B$2:$B$100")
    let s2 = c.add(series: "=Sheet1!$C$2:$C$100")
    s2.set(name: "=Sheet1!$C$1")
    s.set(smooth: true)
    c.set(x_axis: "Test number")
    c.set(y_axis: "Sample length (mm)")
    c.set(style: 4)
    cs.set(chart: c)
    cs.set_paper(type: .A3)
    cs.set_zoom(scale: 150)
    cs.activate()
  }

  static var allTests = [
    ("testExample", testExample),
  ]
}
