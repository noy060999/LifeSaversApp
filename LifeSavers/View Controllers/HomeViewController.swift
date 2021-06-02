//
//  HomeViewController.swift
//  LifeSavers
//
//  Created by user167523 on 7/7/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class HomeViewController: UIViewController {
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var homeVC_hello_lbl: UILabel!
    @IBOutlet weak var homeVC_fillQ_btn: UIButton!
    @IBOutlet weak var homeVC_profile_btn: UIButton!
    @IBOutlet weak var homeVC_activePositions_btn: UIButton!
    @IBOutlet weak var homeVC_donationHistory_btn: UIButton!
    
    var allDonations : [String] = []
    var allDoantionsStr : [String] = []
    var startDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNameFromAuth()
        //set notifications
        //let uid = Auth.auth().currentUser!.uid
        //getDonationsArr(userAuthID: uid)
        addNotification()
    }
    
    
    
    
    @IBAction func gotoDonationHistory(_ sender: Any) {
        let donationHistoryVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.donationHistoryViewController) as? DonationHistoryViewController
        navigationController?.pushViewController(donationHistoryVC!, animated: true)
        
    }
    
    
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        do{
            navigationController?.popToRootViewController(animated: true)
            try Auth.auth().signOut()
            
        }
        catch{
            print("already logged out")
        }
        
    }
    
    
    @IBAction func activePositionsClicked(_ sender: Any) {
        let activePositionsVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.activePositionsViewController) as? ActivePositionsViewController
        navigationController?.pushViewController(activePositionsVC!, animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fillQClicked(_ sender: Any) {
        let quastianireVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.quastianireViewController) as? QuastianireViewController1
        navigationController?.pushViewController(quastianireVC!, animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func myProfileClicked(_ sender: Any) {
        let myProfileVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.myProfileViewController) as? MyProfileViewController
        navigationController?.pushViewController(myProfileVC!, animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    //set name at helloLabel
    func setNameFromAuth (){
        let userAuthID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("users").document(userAuthID!).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    let documentData = document!.data()
                    let optionalName = documentData?["firstName"]
                    //let optionalPhone = documentData?["phone"]
                    let name = optionalName!
                    self.homeVC_hello_lbl.text = "היי \(String(describing: name))!"
                }
            }
            else{
                print("error")
            }
        }
    }
    
    func getLastDonation (_ completion: @escaping (_ result: String) -> Void) {
        let uid = (Auth.auth().currentUser?.uid)!
        var lastDonation = ""
        getDonationsArr(userAuthID: uid) { allDoantionsStr in
            if (allDoantionsStr.count > 0) {
                lastDonation = allDoantionsStr[allDoantionsStr.count-1]
                print("last in getLastDonation :"+lastDonation)
                completion(lastDonation)
            }
            else {
                completion("")
            }
        }
    }
    
    func getDonationsArr (userAuthID : String, _ completion: @escaping (_ arr: [String]) -> Void){
        let db = Firestore.firestore()
        db.collection("users").document(userAuthID).getDocument { (document, error) in
            if let document = document {
                self.allDonations = document["donations"] as? Array ?? []
                for donate in self.allDonations {
                    let cityDate = donate.split(separator: ",")
                    let datePart = cityDate[1].split(separator: ":")
                    let date = datePart[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    //let hebrewStr = "עיר: " + city + " " + "תאריך: " + date
                    print("date inside get:"+date)
                    self.allDoantionsStr.append(date)
                }
            }
            completion(self.allDoantionsStr)
        }
    }
    func addNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if (granted){
                print("granted")
                self.registerNotification()
            }
            else {
                print("denied")
            }
        }
        
    }
    
    func registerNotification(){
        //register notifications
        let uid = (Auth.auth().currentUser?.uid)!
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        content.title = "זמן לתרום דם!"
        content.body = "עברו 3 חודשים מתרומת הדם האחרונה שלך, הגיע הזמן לתרום שוב!"
        var dateDonated = ""
        getLastDonation { res in
            print("completions: "+res)
            dateDonated = res
            print("last donation - in registerNotify: " + dateDonated)
            if (dateDonated != ""){
                self.startDate = dateDonated
                //print("self.startDate:"+self.startDate)
                let someDateTime = formatter.date(from:self.startDate)
                //print(someDateTime)
                let startDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: someDateTime!)
                var dateComponents = DateComponents()
                dateComponents.day = startDateComponents.day
                dateComponents.year = self.getYearByDate(dateComponents: startDateComponents)
                dateComponents.month = self.getMonthByDate(dateComponents: startDateComponents)
                print(dateComponents)
                //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
                print(trigger)
                let id = UUID().uuidString
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                //print(request)
                center.add(request) { error in
                    if ((error) != nil){
                        print("error" + error!.localizedDescription)
                    }
                    else {
                        print("notification added! ..")
                    }
                }
            }
            else {
                print("No Donations detected.")
                //self.startDate = formatter.string(from: Date())
            }        }
        
        
    }
    
    func getMonthByDate(dateComponents: DateComponents) -> Int{
        if (dateComponents.month == 10){
            return 1
        }
        if (dateComponents.month == 11){
            return 2
        }
        if (dateComponents.month == 12){
            return 3
        }
        else {
            return dateComponents.month! + 3
        }
    }
    
    func getYearByDate(dateComponents: DateComponents) -> Int{
        if (dateComponents.month! > 9){
            return dateComponents.year! + 1
        }
        else {
            return dateComponents.year!
        }
    }
    
}


