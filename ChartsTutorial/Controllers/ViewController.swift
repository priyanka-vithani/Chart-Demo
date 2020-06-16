//
//  ViewController.swift
//  ChartsTutorial
//
//  Created by Apple on 16/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var btnLineChart: UIButton!
    @IBOutlet weak var btnPieChart: UIButton!
    @IBOutlet weak var btnBarChart: UIButton!
    
    var xPoint : [String] = []
    var yPoint : [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api_call()
    }
    @IBAction func btnLineChart_clk(_ sender: UIButton) {
        
        let vc = loadVC(strStoryboardId: main, strVCId: vc_lineChart) as! LineChartVC
        
        vc.XPionts = xPoint
        vc.YPoints = yPoint
        
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
        
    }
    @IBAction func btnPieChart_clk(_ sender: UIButton) {
        let vc = loadVC(strStoryboardId: main, strVCId: vc_pieChart) as! PieChartVC
        vc.XPionts = xPoint
        vc.YPoints = yPoint
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBarChart_clk(_ sender: UIButton) {
        let vc = loadVC(strStoryboardId: main, strVCId: vc_barchart) as! BarchartVC
        vc.XPionts = xPoint
        vc.YPoints = yPoint
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
    
}
extension ViewController{
    func api_call(){
        let url = "https://canvasjs.com/services/data/datapoints.php?xstart=1&ystart=10&length=10&type=json"
        HttpRequestManager.sharedInstance.getRequest(endpointurl: url, service: "", parameters: [:], keyname: "", message: "", showLoader: true) { (err, arr, dict) in
            if err != nil{
                hideHUD()
                return
            }else{
                if arr != nil{
                    if arr!.count > 0{
                        print(arr!)
                        
                        let resp = JSON(arr!).array
                        let data = resp![0]
                        print(data)
                        
                        
                        
                        if let arrData = convertStringToArray(str: data.stringValue) as? [NSArray] {
                            for i in arrData{
                                self.xPoint.append("\(i[0])")
                                self.yPoint.append(i[1] as! Double)
                                
                            }
                        }
                        print(self.xPoint)
                        print(self.yPoint)
                        
                        hideHUD()
                        
                        
                    }else{
                        hideHUD()
                        print(arr!.count)
                    }
                }else{
                    
                    hideHUD()
                    
                }
            }
        }
    }
}
