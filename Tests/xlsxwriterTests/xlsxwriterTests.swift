import XCTest

@testable import xlsxwriter

final class xlsxwriterTests: XCTestCase {
  func testExample() {
    // Create a new workbook
    let wb = Workbook(name: "demo3.xlsx")
    // defer { wb.close() }

    // Add a format.
    let f =
      wb
      .addFormat()
      .bold()
      .border(style: .thin)
      .align(horizontal: .center)
      .align(vertical: .center)

    // Add a format.
    let f2 = wb.addFormat().center()

    // Add a worksheet.
    let ws =
      wb
      .addWorksheet()
      .tab(color: .blue)
      .set_default(row_height: 25)
      .column("A:C", width: 30)
      .gridline(screen: false)

    // Create random data
    let data = (1...100).map {
      [Double($0), Double.random(in: 10...100), Double.random(in: 20...50)]
    }
    ws.table(
      range: "A1:C101", name: "bal",
      header: [("Number", f), ("Batch 1", f), ("Batch 2", f)]
    )
    // Write data to add to plot on the chart.
    data.enumerated().forEach {
      ws.write($0.element, row: $0.offset + 1, format: f2)
    }

    // Create a new Chart
    let chart =
      wb
      .addChart(type: .line)
      .set(x_axis: "Test number")
      .set(y_axis: "Sample length (mm)")
      .set(style: 4)

    chart  // In simplest case we add one or more data series.
      .addSeries()
      .values(sheet: ws, range: "$B$2:$B$101")
      .name(sheet: ws, cell: "B1")
      .trendline(type: .log)
      .trendline_equation()

    chart
      .addSeries(values: "=Sheet1!$C$2:$C$101", name: "=Sheet1!$C$1")
      .set(smooth: true)

    wb.addChartsheet(name: "Second")
      .paper(type: .A3)
      .zoom(scale: 150)
      .activate()
      .set(chart: chart)  // Insert the chart into the chartsheet.
  }

  static var allTests = [
    ("testExample", testExample)
  ]
}
