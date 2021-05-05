//
//  SignInViewController.swift
//  LifeSavers
//
//  Created by user167523 on 7/7/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
    
    //outlets define
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var signInVC_email_edt: UITextField!
    @IBOutlet weak var signInVC_password_edt: UITextField!
    @IBOutlet weak var signInVC_signIn_btn: UIButton!
    @IBOutlet weak var forgotPassword_btn: UIButton!
    var userEmail: String = ""
    var userPassword: String = ""
    var userRememberMe: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //to dismiss keyboard when tapping the screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        //dismiss errorLabel
        errorLabel.alpha = 0
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    //check all fields are field properly
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if signInVC_email_edt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            signInVC_password_edt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "בבקשה מלא את כל השדות"
        }
        return nil
    }
    
    //move to next VC
    func gotoHome (){
        let homeViewController = storyboard?.instantiateViewController(identifier: Const.Storyboard.homeViewController) as? HomeViewController
        navigationController?.pushViewController(homeViewController!, animated: true)
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    //get user parameters from text fields
    func getParameters(){
        userEmail = signInVC_email_edt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        userPassword = signInVC_password_edt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        userRememberMe = rememberMeSwitch.isOn
    }
    
    
    @IBAction func forgotPassword(_ sender: Any) {
        getParameters()
        if userEmail == ""{
            let error = "הכנס אימייל כדי לשלוח קישור לאיפוס סיסמה"
            showError(error)
        }
        else {
            errorLabel.text = ""
            Auth.auth().sendPasswordReset(withEmail: userEmail) {(error) in
                if error != nil{
                    self.showError(error!.localizedDescription)
                    print(error!)
                }
                else {
                    let msg = "הקישור לאיפוס הסיסמה נשלח בהצלחה"
                    self.errorLabel.textColor = UIColor(named: "blue")
                    self.showError(msg)
                    print("success sending email")
                }
            }
        }
        
    }
    
    @IBAction func enterHomePage(_ sender: Any) {
        let error = validateFields()
        if error != nil{
            showError(error!)
        }
            
        else{
            getParameters()
            Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (result, error) in
                
                if error != nil {
                    // Couldn't sign in
                    self.showError(error!.localizedDescription)
                }
                else {
                    let userAuthID = Auth.auth().currentUser?.uid
                    let db = Firestore.firestore()
                    db.collection("users").document(userAuthID!).getDocument { (document, error) in
                        if error == nil{
                            if document != nil && document!.exists{
                                db.collection("users").document(userAuthID!).updateData(["rememberMe": self.userRememberMe as Any])
                            }
                        }
                        else{
                            print("error")
                        }
                    }
                    self.gotoHome()
                }
            }
        }
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
