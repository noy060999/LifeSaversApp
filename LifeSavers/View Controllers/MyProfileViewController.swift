//
//  MyProfileViewController.swift
//  LifeSavers
//
//  Created by user167523 on 7/7/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import UIKit
import Firebase

class MyProfileViewController: UIViewController {

    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var phoneLBL: UILabel!
    @IBOutlet weak var bloodTypeLBL: UILabel!
    @IBOutlet weak var idLBL: UILabel!
    @IBOutlet weak var birthdateLBL: UILabel!
    @IBOutlet weak var cityLBL: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    func getUserParameters(){
        let userAuthID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("users").document(userAuthID!).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    let documentData = document!.data()
                    let name = (documentData?["name"])!
                    let phone = (documentData?["phone"])!
                    let id = (documentData?["id"])!
                    let birthdate = (documentData?["birthDate"])!
                    let defaultCity = (documentData?["defaultCity"])!
                    let bloodType = (documentData?["bloodType"])!

                    self.nameLBL.text = "Name: \(String(describing: name))"
                    self.phoneLBL.text = "Phone: \(String(describing: phone))"
                    self.idLBL.text = "ID: \(String(describing: id))"
                    self.bloodTypeLBL.text = "BloodType: \(String(describing: bloodType))"
                    self.birthdateLBL.text = "Birth Date: \(String(describing: birthdate))"
                    self.cityLBL.text = "Default City: \(String(describing: defaultCity))"
                }
            }
            else{
                print("error")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserParameters()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       // _ = navigationController?.popViewController(animated: true)

    }
}
