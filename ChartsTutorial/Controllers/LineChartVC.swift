//
//  LineChartVC.swift
//  ChartsTutorial
//
//  Created by Apple on 16/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Charts
import SwiftyJSON
class LineChartVC: UIViewController {
    @IBOutlet weak var VWLinechart: LineChartView!
    var XPionts : [String] = []
    var YPoints : [Double] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.customizeChart(dataPoints: self.XPionts, values: self.YPoints)
        
        
    }
    
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        VWLinechart.data = lineChartData
    }
    
   
}
extension LineChartVC{
    
}
