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
    
    
    var ref: DatabaseReference!
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
    var users = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
        errorLabel.alpha = 0
        
        
    }
    func getParameters(){
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
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
    
    
    func gotoHome (){
        let homeViewController = storyboard?.instantiateViewController(identifier: Const.Storyboard.homeViewController) as? HomeViewController
        //navigationController?.pushViewController(homeViewController!, animated: true)

        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
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
        
        if isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
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
