//
//  DonationHistoryViewController.swift
//  LifeSavers
//
//  Created by user196697 on 5/17/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit
import Firebase
class DonationHistoryViewController : UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let cellReuseID = "cell"
    
    @IBOutlet weak var goBackBtn: UIButton!
    @IBOutlet weak var donationTable: UITableView!
    @IBOutlet weak var addDonateBtn: UIButton!
    
    @IBOutlet weak var refreshInfoBtn: UIButton!
    
    
    var allDonations : [String] = []
    var allDoantionsStr : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        donationTable.delegate = self
        donationTable.dataSource = self
        
        addDonateBtn.customBtnSignIn()
        let uid = (Auth.auth().currentUser?.uid)!
        getDonationsArr(userAuthID: uid)
        
        
    }
    
    
    //table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allDoantionsStr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = donationTable.dequeueReusableCell(withIdentifier: cellReuseID) ?? UITableViewCell(style: .default, reuseIdentifier: "cell") as UITableViewCell
        cell.textLabel?.text = self.allDoantionsStr[indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func getDonationsArr (userAuthID : String){
        let db = Firestore.firestore()
        db.collection("users").document(userAuthID).getDocument { (document, error) in
            if let document = document {
                self.allDonations = document["donations"] as? Array ?? []
                for donate in self.allDonations {
                    let cityDate = donate.split(separator: ",")
                    let cityPart = cityDate[0].split(separator: ":")
                    let city = cityPart[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    let datePart = cityDate[1].split(separator: ":")
                    let date = datePart[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    let hebrewStr = "עיר: " + city + " " + "תאריך: " + date
                    self.allDoantionsStr.append(hebrewStr)
                }
                print ("inside")
                print(self.allDoantionsStr)
                self.donationTable.reloadData()
                if (self.allDoantionsStr.count == 0){
                    var popupWindow : PopUpWindow!
                    popupWindow = PopUpWindow(title: "אין נתונים להצגה", text: "המערכת לא מצאה תרומות קודמות להצגה", buttontext: "אישור")
                    self.present(popupWindow, animated: true, completion: nil)
                }
            }
        }
        
    }
    @IBAction func addDonationAction(_ sender: Any) {
        var addDonatePopUpWindow: AddDonatePopupVC!
        addDonatePopUpWindow = AddDonatePopupVC(title: "הוספת תרומה", buttontext: "הוסף")
        self.present(addDonatePopUpWindow, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func refreshAction(_ sender: Any) {
        let uid = Auth.auth().currentUser?.uid
        self.allDoantionsStr.removeAll()
        getDonationsArr(userAuthID: uid!)
    }
    
    @IBAction func goToHomeAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}


