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
    @IBOutlet weak var q3Segmented_q3: UISegmentedControl!
    @IBOutlet weak var reasonForQ3_txt_q3: UITextView!
    @IBOutlet weak var q4Segmented_q3: UISegmentedControl!
    @IBOutlet weak var reasonForQ4_txt_q3: UITextView!
    @IBOutlet weak var q5Segmented_q3: UISegmentedControl!
    @IBOutlet weak var reasonForQ5_txt_q3: UITextView!
    @IBOutlet weak var q6Segmented_q3: UISegmentedControl!
    @IBOutlet weak var reasonForQ6_txt_q3: UITextView!
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
        errLbl.alpha = 0
        date_q3.backgroundColor = UIColor.systemTeal
        reasonForQ3_txt_q3.backgroundColor = UIColor.systemGray5
        reasonForQ4_txt_q3.backgroundColor = UIColor.systemGray5
        reasonForQ5_txt_q3.backgroundColor = UIColor.systemGray5
        reasonForQ6_txt_q3.backgroundColor = UIColor.systemGray5
        reasonForQ11_txt_q3.backgroundColor = UIColor.systemGray5
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        date_q3.text = formatter.string(from: now)
        //to dismiss keyboard when tapping the screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
    }
    
    
    @IBAction func goto4Action(_ sender: Any) {
        let msg = getUserAnswersFromPage3()
        if (msg == ""){
            errLbl.alpha = 0;
            let quastianirePage4VC = storyboard?.instantiateViewController(identifier: Const.Storyboard.quastianireViewController4) as? QusatianireViewController4
            navigationController?.pushViewController(quastianirePage4VC!, animated: true)
        }
        else {
            showErr(msg: msg)
        }
          }
    
    
    @IBAction func goto2Action(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func goBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    func showErr(msg: String){
        errLbl.alpha = 1
        errLbl.textColor = UIColor.red
        errLbl.text = msg
    }
    
    func getUserAnswersFromPage3() -> String{
        let ans2 = q2Segmented_q3.selectedSegmentIndex;
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
        let reasonQ5 = reasonForQ5_txt_q3.text;
        let reasonQ6 = reasonForQ6_txt_q3.text;
        let reasonQ11 = reasonForQ11_txt_q3.text;
        
        if (ans2 == 1 && ans3 == 0 && ans4 == 0 && ans5 == 0 && ans6 == 0 && ans7 == 0 && ans8 == 0
                && ans9 == 0 && ans10 == 0 && ans11 == 0 && ans12 == 0){
            return ""
        }
        let err = "בבקשה מלא את השדה הרלוונטי."
        let cantDonate = "סליחה, לצערנו, אינך יכול לתרום דם כרגע."
        var decide = true
        
        if (ans2 == 0){
            return cantDonate;
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
        
        if (ans5 == 1 && reasonQ5 == ""){
            reasonForQ5_txt_q3.textColor = UIColor.red
            reasonForQ5_txt_q3.text = "בבקשה פרט את התרופות שהינך נוטל"
            decide = false
        }
        if (ans6 == 1 && reasonQ6 == ""){
            reasonForQ6_txt_q3.textColor = UIColor.red
            reasonForQ6_txt_q3.text = "בבקשה פרט את החיסונים שקיבלת בחודש האחרון"
            decide = false

        }
        
        if (ans11 == 1 && reasonQ11 == ""){
            reasonForQ11_txt_q3.textColor = UIColor.red
            reasonForQ11_txt_q3.text = "בבקשה ציין את סוג הצהבת שחלית בה"
            decide = false
            
        }
        
        if (decide == false){
            return err
        }
        return ""
    }
    
    
    
    
}
