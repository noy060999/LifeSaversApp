//
//  ReportsGenViewControllerGender.swift
//  LifeSavers
//
//  Created by user196697 on 6/6/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit
import Charts

class ReportsGenViewControllerGender: UIViewController, ChartViewDelegate {
    var pieChart = PieChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        ChartService.adjustChartFrame(pieChart: pieChart, superView: view)
        view.addSubview(pieChart)
        let category = "gender"
        
        ChartService.genChart(pieChart: pieChart, chartCategory: category)
    }
}
