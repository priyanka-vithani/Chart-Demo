//
//  BarchartVC.swift
//  ChartsTutorial
//
//  Created by Apple on 16/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Charts
class BarchartVC: UIViewController {
    @IBOutlet weak var vwBarChart: BarChartView!
    var XPionts : [String] = []
    var YPoints : [Double] = []
    override func viewDidLoad() {
        super.viewDidLoad()

           vwBarChart.animate(yAxisDuration: 2.0)
           vwBarChart.pinchZoomEnabled = false
        vwBarChart.drawBarShadowEnabled = false
           vwBarChart.drawBordersEnabled = false
           vwBarChart.doubleTapToZoomEnabled = false
           vwBarChart.drawGridBackgroundEnabled = true
           vwBarChart.chartDescription?.text = "Bar Chart View"
           
           setChart(dataPoints: XPionts, values: YPoints)
    }
    

    func setChart(dataPoints: [String], values: [Double]) {
      vwBarChart.noDataText = "You need to provide data for the chart."
      
      var dataEntries: [BarChartDataEntry] = []
      
      for i in 0..<dataPoints.count {
        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
        dataEntries.append(dataEntry)
      }
      
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
      let chartData = BarChartData(dataSet: chartDataSet)
      vwBarChart.data = chartData
    }

}
