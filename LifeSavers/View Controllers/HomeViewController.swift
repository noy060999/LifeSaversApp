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
        let uid = (Auth.auth().currentUser?.uid)!
        //set notifications
        MyNotificationService.askPermissions { granted in
            if (granted == 1){
                self.getLastDonation { result in
                    MyNotificationService.registerNotification(userAuthId: uid, lastDonation: result)
                }
            }
            if (granted == -1){
                print("permission denied..")
            }
        }
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
}


