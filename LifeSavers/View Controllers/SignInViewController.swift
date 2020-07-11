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
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var signInVC_email_edt: UITextField!
    @IBOutlet weak var signInVC_password_edt: UITextField!
    @IBOutlet weak var signInVC_signIn_btn: UIButton!
    
    var userEmail: String = ""
    var userPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
        errorLabel.alpha = 0
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if signInVC_email_edt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            signInVC_password_edt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields."
        }
        return nil
    }
    
    func gotoHome (){
        let homeViewController = storyboard?.instantiateViewController(identifier: Const.Storyboard.homeViewController) as? HomeViewController
        
//        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
//        UserDefaults.standard.synchronize()
//        navigationController?.pushViewController(homeViewController!, animated: true)
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func getParameters(){
        userEmail = signInVC_email_edt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        userPassword = signInVC_password_edt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
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
                    self.gotoHome()
                }
            }
        }
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
