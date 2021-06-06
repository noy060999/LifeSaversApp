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
        signInVC_signIn_btn.customBtnSignIn()
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
    
    func goToAdminVC () {
        let adminViewController = storyboard?.instantiateViewController(identifier: Const.Storyboard.adminViewController) as? AdminViewController
        navigationController?.pushViewController(adminViewController!, animated: true)
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
            FirebaseService.sendPasswordReset(userEmail: userEmail) { resultMsg, error in
                if (error){
                    self.showError(resultMsg)
                }
                else {
                    self.errorLabel.alpha = 1
                    self.errorLabel.text = resultMsg
                    self.errorLabel.textColor = UIColor.systemBlue
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
            FirebaseService.loginUser(userEmail: userEmail, userPassword: userPassword, rememberMe: userRememberMe) { msg, err in
                if (err){
                    self.showError(msg)
                }
                else {
                    if (self.userEmail == "noy.admin@gmail.com"){
                        self.goToAdminVC()
                    }else{
                        self.gotoHome()
                    }
                }
            }
        }
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
