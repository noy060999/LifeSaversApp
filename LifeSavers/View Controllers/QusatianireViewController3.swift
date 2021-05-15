//
//  QusatianireViewController3.swift
//  LifeSavers
//
//  Created by user196697 on 5/13/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit
class QusatianireViewController3: UIViewController {
    
    @IBOutlet weak var errLbl: UILabel!
    @IBOutlet weak var goBack: UIButton!
    @IBOutlet weak var date_q3: UITextView!
    @IBOutlet weak var q2Segmented_q3: UISegmentedControl!
    
    @IBOutlet weak var donatedBlood_segmented: UISegmentedControl!
    @IBOutlet weak var q3Segmented_q3: UISegmentedControl!
    @IBOutlet weak var reasonForQ3_txt_q3: UITextView!
    @IBOutlet weak var q4Segmented_q3: UISegmentedControl!
    @IBOutlet weak var reasonForQ4_txt_q3: UITextView!
    @IBOutlet weak var q5Segmented_q3: UISegmentedControl!
    @IBOutlet weak var q6Segmented_q3: UISegmentedControl!
    @IBOutlet weak var reasonForQ7_txt_q3: UITextView!
    @IBOutlet weak var q7Segmented_q3: UISegmentedControl!
    @IBOutlet weak var q8Segmented_q3: UISegmentedControl!
    @IBOutlet weak var q9Segmented_q3: UISegmentedControl!
    @IBOutlet weak var q10Segmented_q3: UISegmentedControl!
    @IBOutlet weak var q11Segmented_q3: UISegmentedControl!
    
    @IBOutlet weak var reasonForQ11_txt_q3: UITextView!
    @IBOutlet weak var q12Segmented_q3: UISegmentedControl!
    
    
    @IBOutlet weak var goto4Btn: UIButton!
    
    @IBOutlet weak var goto2Btn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setFieldsStyles()
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        date_q3.text = formatter.string(from: now)
        //to dismiss keyboard when tapping the screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
    }
    
    func setFieldsStyles (){
        errLbl.alpha = 0
        date_q3.backgroundColor = UIColor.systemTeal
        reasonForQ3_txt_q3.layer.borderColor = UIColor.systemGray3.cgColor
        reasonForQ3_txt_q3.layer.borderWidth = 1
        reasonForQ4_txt_q3.layer.borderColor = UIColor.systemGray3.cgColor
        reasonForQ4_txt_q3.layer.borderWidth = 1
        reasonForQ7_txt_q3.layer.borderColor = UIColor.systemGray3.cgColor
        reasonForQ7_txt_q3.layer.borderWidth = 1
        reasonForQ11_txt_q3.layer.borderColor = UIColor.systemGray3.cgColor
        reasonForQ11_txt_q3.layer.borderWidth = 1
        
    }
    
    
    @IBAction func goto4Action(_ sender: Any) {
        let msg = getUserAnswersFromPage3()
        var popUpWindow: PopUpWindow!
        if (msg == ""){
            errLbl.alpha = 0;
            let quastianirePage4VC = storyboard?.instantiateViewController(identifier: Const.Storyboard.quastianireViewController4) as? QusatianireViewController4
            navigationController?.pushViewController(quastianirePage4VC!, animated: true)
        }
        else {
            if (msg != "can't donate") {
                showErr(msg: msg)
            }
            else {
                showErr(msg: "לצערנו, אינך יכול לתרום דם כרגע.")
                popUpWindow = PopUpWindow(title: "הודעה לתורם", text: "לצערנו, אינך יכול לתרום דם כרגע.", buttontext: "אישור")
                self.present(popUpWindow, animated: true, completion: nil)
            }
        }
          }
    
    
    @IBAction func goto2Action(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func goBackAction(_ sender: Any) {
        let homePageVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.homeViewController) as? HomeViewController
        navigationController?.pushViewController(homePageVC!, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func showErr(msg: String){
        errLbl.alpha = 1
        errLbl.textColor = UIColor.red
        errLbl.text = msg
    }
    
    func getUserAnswersFromPage3() -> String{
        let ans2 = q2Segmented_q3.selectedSegmentIndex;
        let donated = donatedBlood_segmented.selectedSegmentIndex;
        let ans3 = q3Segmented_q3.selectedSegmentIndex;
        let ans4 = q4Segmented_q3.selectedSegmentIndex;
        let ans5 = q5Segmented_q3.selectedSegmentIndex;
        let ans6 = q6Segmented_q3.selectedSegmentIndex;
        let ans7 = q7Segmented_q3.selectedSegmentIndex;
        let ans8 = q8Segmented_q3.selectedSegmentIndex;
        let ans9 = q9Segmented_q3.selectedSegmentIndex;
        let ans10 = q10Segmented_q3.selectedSegmentIndex;
        let ans11 = q11Segmented_q3.selectedSegmentIndex;
        let ans12 = q12Segmented_q3.selectedSegmentIndex;
        
        let reasonQ3 = reasonForQ3_txt_q3.text;
        let reasonQ4 = reasonForQ4_txt_q3.text;
        let reasonQ7 = reasonForQ7_txt_q3.text;
        let reasonQ11 = reasonForQ11_txt_q3.text;
        
        if (ans2 == 1 && donated == 0 && ans3 == 0 && ans4 == 0 && ans5 == 0 && ans6 == 0 && ans7 == 0 && ans8 == 0
                && ans9 == 0 && ans10 == 0 && ans11 == 0 && ans12 == 0){
            return ""
        }
        let err = "בבקשה מלא את השדה הרלוונטי."
        var cantDonate = false
        var decide = true
        
        if (ans2 == 0 || donated == 1 || ans5 == 1 || ans6 == 1 || ans8 == 1 || ans9 == 1 || ans10 == 1 || ans12 == 1){
            decide = false
            cantDonate = true
        }
        if (ans3 == 1 && reasonQ3 == ""){
            reasonForQ3_txt_q3.textColor = UIColor.red
            reasonForQ3_txt_q3.text = "בבקשה כתוב את הסיבה שבגללה קיבלת עירוי דם"
            decide = false
        }
        
        if (ans4 == 1 && reasonQ4 == ""){
            reasonForQ4_txt_q3.textColor = UIColor.red
            reasonForQ4_txt_q3.text = "בבקשה פרט את התרופות שהינך נוטל"
            decide = false
        }
        
        if (ans7 == 1 && reasonQ7 == ""){
            reasonForQ7_txt_q3.textColor = UIColor.red
            reasonForQ7_txt_q3.text = "בבקשה פרט את החיסונים שקיבלת בחודש האחרון"
            decide = false

        }
        
        if (ans11 == 1 && reasonQ11 == ""){
            reasonForQ11_txt_q3.textColor = UIColor.red
            reasonForQ11_txt_q3.text = "בבקשה ציין את סוג הצהבת שחלית בה"
            decide = false
            
        }
        
        if (decide == false && cantDonate == false){
            return err
        }
        if (cantDonate == true){
            return "can't donate"
        }
        return ""
    }
    
    
    
    
}
