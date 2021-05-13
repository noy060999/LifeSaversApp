//
//  QusatianireViewController4.swift
//  LifeSavers
//
//  Created by user196697 on 5/13/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit
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
    
    @IBOutlet weak var gotoPage3Btn: UIButton!
    
    
    @IBOutlet weak var sendAnswersBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //to dismiss keyboard when tapping the screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func gotoPage3Action(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func getUserAnswersPage4 () -> String{
        let ans1 = q11_segmented_q4.selectedSegmentIndex;
        let ans2 = q12_segmented_q4.selectedSegmentIndex;
        let ans3 = q13_segmented_q4.selectedSegmentIndex;
        let ans4 = q14_segmented_q4.selectedSegmentIndex;
        let ans5 = q15_segmented_q4.selectedSegmentIndex;
        let ans6 = q16_segmented_q4.selectedSegmentIndex;
        let ans7 = q17_segmented_q4.selectedSegmentIndex;
        let ans8 = q18_segmented_q4.selectedSegmentIndex;
        let ans9 = q19_segmented_q4.selectedSegmentIndex;
        let ans10 = q20_segmented_q4.selectedSegmentIndex;
        let ans11 = q21_segmented_q4.selectedSegmentIndex;
        let ans12 = q22_segmented_q4.selectedSegmentIndex;
        
        if (ans1 == 0 && ans2 == 0 && ans3 == 0 && ans4 == 0 && ans5 == 0 && ans6 == 0
                && ans7 == 0 && ans8 == 0 && ans9 == 0 && ans10 == 0 && ans11 == 0 && ans12 == 0){
            return "OK"
        }
        
        return "OK"
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        let answer = getUserAnswersPage4()
        var popUpWindow: PopUpWindow!
        
        
        if (answer == "OK"){
            popUpWindow = PopUpWindow(title: "סיום שאלון", text: "ברכות, הינך יכול לתרום דם!", buttontext: "אישור")
            self.present(popUpWindow, animated: true, completion: nil)
        }
    }
    
}
