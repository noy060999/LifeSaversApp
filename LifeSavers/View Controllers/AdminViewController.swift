//
//  AdminViewController.swift
//  LifeSavers
//
//  Created by user196697 on 6/6/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit
import Firebase

class AdminViewController: UIViewController {
    
    @IBOutlet weak var gotoReportsBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    @IBAction func gotoReportsAction(_ sender: Any) {
        let tabBarVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.tabBarController) as? UITabBarController
        navigationController?.pushViewController(tabBarVC!, animated: true)
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        do{
            navigationController?.popToRootViewController(animated: true)
            try Auth.auth().signOut()
            
        }
        catch{
            print("already logged out")
        }
    }
    
}
