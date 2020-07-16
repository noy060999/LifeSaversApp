//
//  SignUpViewController.swift
//  LifeSavers
//
//  Created by user167523 on 7/7/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
        
    //outlets define
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signupVC_email_edt: UITextField!
    @IBOutlet weak var signUpVC_name_edt: UITextField!
    @IBOutlet weak var signUpVC_id_edt: UITextField!
    @IBOutlet weak var signUpVC_phone_edt: UITextField!
    @IBOutlet weak var signUpVC_city_edt: UITextField!
    @IBOutlet weak var signUpVC_password_edt: UITextField!
    @IBOutlet weak var signUpVC_birthdate_lbl: UILabel!
    @IBOutlet weak var signUpVC_datePicker: UIDatePicker!
    @IBOutlet weak var signUpVC_bloodType_lbl: UILabel!
    @IBOutlet weak var signUpVC_bloodType_segments: UISegmentedControl!
    @IBOutlet weak var signUpVC_signUp_btn: UIButton!
    
    
    var userName: String = ""
    var userID: String = ""
    var userPhone: String = ""
    var userPassword: String = ""
    var userDefaultCity: String = ""
    var userEmail: String = ""
    var userBirthdate: Date = Date()
    var userBirthdateString: String = ""
    var userBloodTypeIndex: Int = 0
    var userBloodType: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dismiss keyboard when tapping the screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        //dismiss errorLabel
        errorLabel.alpha = 0
        
        
    }
    
    
    //get user parameters from text fields
    func getParameters(){
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        userBirthdateString = df.string(from: signUpVC_datePicker.date).trimmingCharacters(in: .whitespacesAndNewlines)
        userName = signUpVC_name_edt.text!
        userID = signUpVC_id_edt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        userPhone = signUpVC_phone_edt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        userPassword = signUpVC_password_edt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        userDefaultCity = signUpVC_city_edt.text!
        userBloodTypeIndex = signUpVC_bloodType_segments.selectedSegmentIndex
        
        userBloodType = checkBloodType(bloodTypeIndex: userBloodTypeIndex).trimmingCharacters(in: .whitespacesAndNewlines)
        userEmail = signupVC_email_edt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    //figure blood type from the index that detected by the segmented control
    func checkBloodType(bloodTypeIndex: Int)-> String{
        switch (bloodTypeIndex){
        case 0:
            return "don't know"
        case 1:
            return "O-"
        case 2:
            return "O+"
        case 3:
            return "A-"
        case 4:
            return "A+"
        case 5:
            return "B-"
        case 6:
            return "B+"
        case 7:
            return "AB-"
        case 8:
            return "AB+"
        default:
            return "don't know"
        }
    }
    
    //move to the next VC
    func gotoHome (){
        let homeViewController = storyboard?.instantiateViewController(identifier: Const.Storyboard.homeViewController) as? HomeViewController
        navigationController?.pushViewController(homeViewController!, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    //check password validation
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid(_ email: String) -> Bool{
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$")
        return emailTest.evaluate(with: email)
    }
    
    //check all fileds are filled properly
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if signUpVC_name_edt.text == "" ||
            signUpVC_id_edt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            signUpVC_password_edt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            signUpVC_city_edt.text == "" ||
            signUpVC_phone_edt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            signupVC_email_edt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields."
        }
        
        
        // Check if the password is secure
        let cleanedPassword = signUpVC_password_edt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = signupVC_email_edt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        if isEmailValid(cleanedEmail) == false{
            return "Please type an email in valid format."
        }
        if signUpVC_id_edt.text?.count != 9{
            return "ID must contain 9 digits."
        }
        return nil
    }
    
    
    @IBAction func enterHomePageFromSU(_ sender: Any) {
        let error = validateFields()
        if error != nil{
            showError(error!)
        }
            
        else{
            getParameters()
            Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (result, err) in
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
                    docRef.setData(["name":self.userName, "id":self.userID,  "phone":self.userPhone, "defaultCity":self.userDefaultCity, "birthDate": self.userBirthdateString,"bloodType": self.userBloodType])
                    
                    self.gotoHome()
                }
            }
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
        
    }
}

