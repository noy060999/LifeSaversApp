//
//  QusatianireViewController4.swift
//  LifeSavers
//
//  Created by user196697 on 5/13/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit
import PencilKit

class QusatianireViewController4: UIViewController {
    @IBOutlet weak var goBack: UIButton!

    @IBOutlet weak var q11_segmented_q4: UISegmentedControl!
    @IBOutlet weak var q12_segmented_q4: UISegmentedControl!
    @IBOutlet weak var q13_segmented_q4: UISegmentedControl!
    @IBOutlet weak var q14_segmented_q4: UISegmentedControl!
    @IBOutlet weak var q15_segmented_q4: UISegmentedControl!
    @IBOutlet weak var q16_segmented_q4: UISegmentedControl!
    @IBOutlet weak var q17_segmented_q4: UISegmentedControl!
    @IBOutlet weak var q18_segmented_q4: UISegmentedControl!
    @IBOutlet weak var q19_segmented_q4: UISegmentedControl!
    @IBOutlet weak var q20_segmented_q4: UISegmentedControl!
    @IBOutlet weak var q21_segmented_q4: UISegmentedControl!
    @IBOutlet weak var q22_segmented_q4: UISegmentedControl!
    
    @IBOutlet weak var reasonForQ13_q4: UITextView!
    @IBOutlet weak var reasonForQ17_q4: UITextView!
    @IBOutlet weak var reasonForQ18_q4: UITextView!
    @IBOutlet weak var reasonForQ20_q4: UITextView!
    @IBOutlet weak var gotoPage3Btn: UIButton!
    
    
    @IBOutlet weak var sendAnswersBtn: UIButton!
    
    @IBOutlet weak var errLbl: UILabel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setFieldsStyles()
        //to dismiss keyboard when tapping the screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        let homePageVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.homeViewController) as? HomeViewController
        navigationController?.pushViewController(homePageVC!, animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func gotoPage3Action(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func getUserAnswersPage4 () -> String{
        let ans11 = q11_segmented_q4.selectedSegmentIndex;
        let ans12 = q12_segmented_q4.selectedSegmentIndex;
        let ans13 = q13_segmented_q4.selectedSegmentIndex;
        let ans14 = q14_segmented_q4.selectedSegmentIndex;
        let ans15 = q15_segmented_q4.selectedSegmentIndex;
        let ans16 = q16_segmented_q4.selectedSegmentIndex;
        let ans17 = q17_segmented_q4.selectedSegmentIndex;
        let ans18 = q18_segmented_q4.selectedSegmentIndex;
        let ans19 = q19_segmented_q4.selectedSegmentIndex;
        let ans20 = q20_segmented_q4.selectedSegmentIndex;
        let ans21 = q21_segmented_q4.selectedSegmentIndex;
        let ans22 = q22_segmented_q4.selectedSegmentIndex;
        
        let reason13 = reasonForQ13_q4.text
        let reason17 = reasonForQ17_q4.text
        let reason18 = reasonForQ18_q4.text
        let reason20 = reasonForQ20_q4.text
        
        
        let err = "בבקשה מלא את השדה הרלוונטי."
        let cantDonate = "סליחה, לצערנו, אינך יכול לתרום דם כרגע."
        var decide = true
        
        if (ans11 == 0 && ans12 == 0 && ans13 == 0 && ans14 == 0 && ans15 == 0 && ans16 == 0
                && ans17 == 0 && ans18 == 0 && ans19 == 0 && ans20 == 0 && ans21 == 0 && ans22 == 0){
            reasonForQ13_q4.text = ""
            reasonForQ17_q4.text = ""
            reasonForQ18_q4.text = ""
            reasonForQ20_q4.text = ""
            setFieldsStyles()
            return "OK"
        }
        
         if (ans11 == 1 || ans12 == 1 || ans14 == 1 || ans15 == 1 || ans16 == 1 || ans19 == 1 || ans21 == 1
                || ans22 == 1) {
            return cantDonate
         }
        
        if (ans13 == 1 && reason13 == ""){
            reasonForQ13_q4.textColor = UIColor.red
            reasonForQ13_q4.text = "בבקשה פרט את הארצות ששהית בהן."
            decide = false
            
        }
        if (ans17 == 1 && reason17 == ""){
            reasonForQ17_q4.textColor = UIColor.red
            reasonForQ17_q4.text = "בבקשה פרט את הניתוחים שעברת."
            decide = false
            
        }
        if (ans18 == 1 && reason18 == ""){
            reasonForQ18_q4.textColor = UIColor.red
            reasonForQ18_q4.text = "בבקשה פרט את הבעיות הבריאותיות שלך."
            decide = false
            
        }
        if (ans20 == 1 && reason20 == ""){
            reasonForQ20_q4.textColor = UIColor.red
            reasonForQ20_q4.text = "בבקשה פרט את המדינות ששהית בהן."
            decide = false
        }
        
        if (decide == false){
            return err
        }
        return "OK"
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        let answer = getUserAnswersPage4()
        var popUpWindow: PopUpWindow!
        
        
        if (answer == "OK"){
            popUpWindow = PopUpWindow(title: "סיום שאלון", text: "ברכות, הינך יכול לתרום דם!", buttontext: "אישור")
            self.present(popUpWindow, animated: true, completion: nil)
            //need to do that only when the button clicked
            //moveToHome()
        }
        else {
            showErr(msg: answer)
            popUpWindow = PopUpWindow(title: "סיום שאלון", text: "לצערנו, אינך יכול לתרום דם כרגע.", buttontext: "אישור")
            self.present(popUpWindow, animated: true, completion: nil)
        }
    }
    func showErr (msg: String) {
        errLbl.alpha = 1
        errLbl.textColor = UIColor.red
        errLbl.text = msg
    }
    
    
    func setFieldsStyles (){
        errLbl.alpha = 0
        reasonForQ13_q4.layer.borderColor = UIColor.systemGray3.cgColor
        reasonForQ13_q4.layer.borderWidth = 1
        reasonForQ17_q4.layer.borderColor = UIColor.systemGray3.cgColor
        reasonForQ17_q4.layer.borderWidth = 1
        reasonForQ18_q4.layer.borderColor = UIColor.systemGray3.cgColor
        reasonForQ18_q4.layer.borderWidth = 1
        reasonForQ20_q4.layer.borderColor = UIColor.systemGray3.cgColor
        reasonForQ20_q4.layer.borderWidth = 1
    }
    
    
    func moveToHome(){
        let homePageVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.homeViewController) as? HomeViewController
        navigationController?.pushViewController(homePageVC!, animated: true)
        print("inside movetohome")
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
