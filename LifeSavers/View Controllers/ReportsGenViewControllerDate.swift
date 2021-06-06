//
//  ReportsGenViewController.swift
//  LifeSavers
//
//  Created by user196697 on 6/6/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit
import Charts
import Firebase

//city, gender, bloodType, date
class ReportsGenViewControllerDate: UIViewController, ChartViewDelegate{
    
    
    var pieChart = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        ChartService.adjustChartFrame(pieChart: pieChart, superView: view)
        view.addSubview(pieChart)
        let category = "date"
        
        ChartService.genChart(pieChart: pieChart, chartCategory: category)
    }
    
    @IBAction func goHomeBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
