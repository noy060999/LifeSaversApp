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
    
    func setNameFromAuth (){ //copy also to profile VC
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
    
    func gotoMainscreen() {
        let mainViewController = storyboard?.instantiateViewController(identifier: Const.Storyboard.mainViewController) as? ViewController
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //appDel.window.rootViewController = mainViewController
        //view.window?.rootViewController = mainViewController

        //view.window?.makeKeyAndVisible()
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        do{
            //doesn't go over to the main screen (main view controller)
            navigationController?.popViewController(animated: true)
            try Auth.auth().signOut()
        
        }
        catch{
            print("already logged out")
        }
        
    }
    
    
    

    
    
    
}
