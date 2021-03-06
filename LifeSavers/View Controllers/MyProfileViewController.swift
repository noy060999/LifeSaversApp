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
    
    @IBOutlet weak var familyNameTxt: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var genderTxt: UITextField!
    @IBOutlet weak var finishEditBtn: UIButton!
    @IBOutlet weak var editProfileBtn: UIButton!
    
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var bloodTypeTxt: UITextField!
    @IBOutlet weak var birthdateTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    //get user parameters from the db by userId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLbl.alpha = 0
        finishEditBtn.alpha = 0
        let uid = (Auth.auth().currentUser?.uid)!
        FirebaseService.getUserParameters(userAuthId: uid) { dataArray, err in
            if (err){
                self.errorLbl.alpha = 1
                self.errorLbl.text = dataArray["err"]
            }
            else {
                //init textFields
                self.nameTxt.text = "\(String(describing: dataArray["name"]!))"
                self.phoneTxt.text = "\(String(describing: dataArray["phone"]!))"
                self.idText.text = "\(String(describing: dataArray["id"]!))"
                self.bloodTypeTxt.text = "\(String(describing: dataArray["bloodT"]!))"
                self.birthdateTxt.text = "\(String(describing: dataArray["birthD"]!))"
                self.genderTxt.text = "\(String(describing: dataArray["gender"]!))"
                self.familyNameTxt.text = "\(String(describing: dataArray["familyN"]!))"
                
            }
        }
        
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
        genderTxt.isEnabled = true
        familyNameTxt.isEnabled = true
    }
    
    
    
    @IBAction func finishEditingClicked(_ sender: Any) {
        let uid = (Auth.auth().currentUser?.uid)!
        let error = validateFields()
        if error == nil{
            errorLbl.alpha = 0
            let newName = nameTxt.text
            let newID = idText.text
            let newPhone = phoneTxt.text
            let newGender = genderTxt.text
            let newBloodType = bloodTypeTxt.text
            let newBirthDate = birthdateTxt.text
            let newFamilyName = familyNameTxt.text
            let dataArray = ["name": newName!, "familyN": newFamilyName!,"id": newID!, "phone": newPhone!, "gender": newGender!, "bloodType": newBloodType!,"birthD": newBirthDate!]
            FirebaseService.updateUserData(userAuthId: uid, dataArr: dataArray)
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
        genderTxt.isEnabled = false
        phoneTxt.isEnabled = false
        bloodTypeTxt.isEnabled = false
        birthdateTxt.isEnabled = false
        familyNameTxt.isEnabled = false
    }
    
    func isBirthdateValid (_ birthdate: String)-> Bool{
        let birthDateTest = NSPredicate(format: "SELF MATCHES %@", "^([0]?[1-9]|[1|2][0-9]|[3][0|1])[./-]([0]?[1-9]|[1][0-2])[./-]([0-9]{4}|[0-9]{2})$")
        return birthDateTest.evaluate(with: birthdate)
    }
    //check all fileds are filled properly
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if  nameTxt.text == "" ||
            familyNameTxt.text == "" ||
            idText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            genderTxt.text == "" ||
            phoneTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            bloodTypeTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            birthdateTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "בבקשה מלא את כל השדות"
        }
        if isBirthdateValid(birthdateTxt.text!) == false{
            return "הקלד בבקשה תאריך לידה בפורמט: dd-mm-yyyy"
        }
        if idText.text?.count != 9{
            return "מספר תעודת זהות אינו תקין"
        }
        
        if bloodTypeTxt.text != "A-" && bloodTypeTxt.text != "A+" && bloodTypeTxt.text != "O-" && bloodTypeTxt.text != "O+" && bloodTypeTxt.text != "B-" && bloodTypeTxt.text != "B+" && bloodTypeTxt.text != "AB+" && bloodTypeTxt.text != "AB-" && bloodTypeTxt.text != "לא ידוע" {
            return "סוג דם אינו תקין. אם אינך יודע את סוג הדם שלך, הקלד: לא ידוע"
        }
    
        return nil
    }
}






