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
    
    //outlets define
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var phoneLBL: UILabel!
    @IBOutlet weak var bloodTypeLBL: UILabel!
    @IBOutlet weak var idLBL: UILabel!
    @IBOutlet weak var birthdateLBL: UILabel!
    @IBOutlet weak var cityLBL: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var finishEditBtn: UIButton!
    @IBOutlet weak var editProfileBtn: UIButton!
    
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var bloodTypeTxt: UITextField!
    @IBOutlet weak var birthdateTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    //get user parameters from the db by userId
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
                    
                    //init textFields
                    self.nameTxt.text = "\(String(describing: name))"
                    self.phoneTxt.text = "\(String(describing: phone))"
                    self.idText.text = "\(String(describing: id))"
                    self.bloodTypeTxt.text = "\(String(describing: bloodType))"
                    self.birthdateTxt.text = "\(String(describing: birthdate))"
                    self.cityTxt.text = "\(String(describing: defaultCity))"
                }
            }
            else{
                print("error")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLbl.alpha = 0
        finishEditBtn.alpha = 0
        getUserParameters()
        
        //dismiss keyboard when tapping the screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func editProfileClicked(_ sender: Any) {
        finishEditBtn.alpha = 1
        editProfileBtn.alpha = 0
        nameTxt.isEnabled = true
        idText.isEnabled = true
        phoneTxt.isEnabled = true
        bloodTypeTxt.isEnabled = true
        birthdateTxt.isEnabled = true
        cityTxt.isEnabled = true
        
        
    }
    
    
    @IBAction func finishEditingClicked(_ sender: Any) {
        let uid = (Auth.auth().currentUser?.uid)!
        let error = validateFields()
        if error == nil{
            errorLbl.alpha = 0
            let newName = nameTxt.text
            let newID = idText.text
            let newPhone = phoneTxt.text
            let newCity = cityTxt.text
            let newBloodType = bloodTypeTxt.text
            let newBirthDate = birthdateTxt.text
            
            let db = Firestore.firestore()
            db.collection("users").document(uid).updateData(["name": newName as Any, "id": newID as Any, "phone": newPhone as Any, "defaultCity": newCity as Any, "bloodType": newBloodType as Any, "birthDate": newBirthDate as Any] )
            editProfileBtn.alpha = 1
            finishEditBtn.alpha = 0
            makeAllTextFieldsDisabled()

        }
        else{
            errorLbl.alpha = 1
            errorLbl.text = error
        }
        
        
    }
    
    func makeAllTextFieldsDisabled(){
        nameTxt.isEnabled = false
        idText.isEnabled = false
        cityTxt.isEnabled = false
        phoneTxt.isEnabled = false
        bloodTypeTxt.isEnabled = false
        birthdateTxt.isEnabled = false
    }
    
    func isBirthdateValid (_ birthdate: String)-> Bool{
        let birthDateTest = NSPredicate(format: "SELF MATCHES %@", "^([0]?[1-9]|[1|2][0-9]|[3][0|1])[./-]([0]?[1-9]|[1][0-2])[./-]([0-9]{4}|[0-9]{2})$")
        return birthDateTest.evaluate(with: birthdate)
    }
    //check all fileds are filled properly
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if  nameTxt.text == "" ||
            idText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            cityTxt.text == "" ||
            phoneTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            bloodTypeTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            birthdateTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        if isBirthdateValid(birthdateTxt.text!) == false{
            return "Please type a valid birthdate in this format: dd-mm-yyyy"
        }
        if idText.text?.count != 9{
            return "ID must contain 9 digits."
        }
        
        if bloodTypeTxt.text != "A-" && bloodTypeTxt.text != "A+" && bloodTypeTxt.text != "O-" && bloodTypeTxt.text != "O+" && bloodTypeTxt.text != "B-" && bloodTypeTxt.text != "B+" && bloodTypeTxt.text != "AB+" && bloodTypeTxt.text != "AB-" && bloodTypeTxt.text != "don't know" {
            return "invalid blood type. if you don't know your blood type, please type in : don't know. "
        }
    
        return nil
    }
}






