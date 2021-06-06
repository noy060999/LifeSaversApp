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
import MessageUI

class ReportsGenViewControllerDate: UIViewController, ChartViewDelegate, MFMailComposeViewControllerDelegate{
    
    
    @IBOutlet weak var sendMailBtn: UIButton!
    
    
    var pieChart = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
        sendMailBtn.customBtnSignIn()
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
    
    
    @IBAction func sendMailAction(_ sender: Any) {
        //for testing only.
        /*FirebaseService.getEmailBody(category: "date") { msg in
            if (msg != ""){
                print(msg)
            }
            else {
            }
        }*/
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            var body = ""
            mail.mailComposeDelegate = self
            var recip : [String] = []
            recip.append((Auth.auth().currentUser?.email)!)
            mail.setToRecipients(recip)
            FirebaseService.getEmailBody(category: "date") { msg in
                if (msg != ""){
                    print(msg)
                    body = msg
                    mail.setMessageBody("<p>"+body+"</p>", isHTML: true)
                }
                else {
                    mail.setMessageBody("<p>No Data.</p>", isHTML: true)
                }
                mail.setSubject("תרומות דם לפי תאריך")
                self.present(mail, animated: true)
            }
            
        } else {
            print("cannot send email!")
        }
    }
    
}
