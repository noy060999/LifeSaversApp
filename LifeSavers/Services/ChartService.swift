//
//  ChartService.swift
//  LifeSavers
//
//  Created by user196697 on 6/6/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit
import Charts

class ChartService{
    static func genChart(pieChart: PieChartView, chartCategory: String){
        var entries = [PieChartDataEntry]()
        FirebaseService.getFullDonationsFromAllUsers() { fullDonations in
            for don in fullDonations {
                print(don.description)
            }
            if (!fullDonations.isEmpty){
                FirebaseService.getArrByCategory(category: chartCategory, donations: fullDonations) { donationsByCategory in
                    if (donationsByCategory != []){
                        //print(donationsByCategory)
                        FirebaseService.countByCategories(fullDonationsByCategory: donationsByCategory) {countsDict in
                            //print("count in count by catergories : ")
                            //print(countsDict.values)
                            for (key, value) in countsDict {
                                let entry = PieChartDataEntry(value: Double(value),label: key)
                                entries.append(entry)
                            }
                            //print(entries)
                            let set = PieChartDataSet(entries: entries)
                            set.label = chartCategory
                            set.colors = ChartColorTemplates.joyful()
                            set.entryLabelColor = UIColor.black
                            let data = PieChartData(dataSet: set)
                            data.setValueTextColor(UIColor.black)
                            pieChart.data = data
                        }
                    }
                }
            }
        }
    }
    
    static func adjustChartFrame(pieChart: PieChartView, superView: UIView){
        pieChart.frame = CGRect(x: 0, y: 0, width: superView.frame.size.width, height: superView.frame.size.width)
        pieChart.center = superView.center
    }
}
