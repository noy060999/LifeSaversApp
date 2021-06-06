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
class ReportsGenViewController: UIViewController, ChartViewDelegate{
    
    var pieChart = PieChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        
        var entries = [PieChartDataEntry]()
        FirebaseService.getFullDonationsFromAllUsers() { fullDonations in
            for don in fullDonations {
                print(don.description)
            }
            if (!fullDonations.isEmpty){
                FirebaseService.getArrByCategory(category: "gender", donations: fullDonations) { donationsByCategory in
                    if (donationsByCategory != []){
                        print(donationsByCategory)
                        FirebaseService.countByCategories(fullDonationsByCategory: donationsByCategory) {countsDict in
                            print("count in count by catergories : ")
                            print(countsDict.values)
                            var i = 0
                            for (_, value) in countsDict {
                                entries.append(PieChartDataEntry(value: Double(value), data: Double(i)))
                                i+=1
                            }
                            print(entries)
                            let set = PieChartDataSet(entries: entries)
                            set.colors = ChartColorTemplates.joyful()
                            let data = PieChartData(dataSet: set)
                            self.pieChart.data = data
                        }
                    }
                }
            }
        }
        
        
    }
    
}
