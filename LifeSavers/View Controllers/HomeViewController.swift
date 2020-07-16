//
//  HomeViewController.swift
//  LifeSavers
//
//  Created by user167523 on 7/7/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var homeVC_hello_lbl: UILabel!
    @IBOutlet weak var homeVC_fillQ_btn: UIButton!
    @IBOutlet weak var homeVC_profile_btn: UIButton!
    @IBOutlet weak var homeVC_activePositions_btn: UIButton!
    
    //set name at helloLabel
    func setNameFromAuth (){
        let userAuthID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("users").document(userAuthID!).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    let documentData = document!.data()
                    let optionalName = documentData?["name"]
                    //let optionalPhone = documentData?["phone"]
                    let name = optionalName!
                    self.homeVC_hello_lbl.text = "Hello \(String(describing: name))!"
                }
            }
            else{
                print("error")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNameFromAuth()
        
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fillQClicked(_ sender: Any) {
        let quastianireVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.quastianireViewController) as? QuastianireViewController
        navigationController?.pushViewController(quastianireVC!, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func myProfileClicked(_ sender: Any) {
        let myProfileVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.myProfileViewController) as? MyProfileViewController
        navigationController?.pushViewController(myProfileVC!, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
