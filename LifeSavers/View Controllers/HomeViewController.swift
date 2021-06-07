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
    @IBOutlet weak var homeVC_fillQ_btn: UIButton!
    @IBOutlet weak var homeVC_profile_btn: UIButton!
    @IBOutlet weak var homeVC_activePositions_btn: UIButton!
    @IBOutlet weak var homeVC_donationHistory_btn: UIButton!
    
    
    var startDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = (Auth.auth().currentUser?.uid)!
        
        
        //set user notifications
        MyNotificationService.askPermissions { granted in
            if (granted == 1){
                FirebaseService.getLastDonation { result in
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
    
}


