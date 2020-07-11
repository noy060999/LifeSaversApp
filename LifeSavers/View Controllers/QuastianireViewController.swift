//
//  QuastianireViewController.swift
//  LifeSavers
//
//  Created by user167523 on 7/7/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import UIKit

class QuastianireViewController: UIViewController {
    
    
    @IBOutlet weak var ans1SegmentedControl: UISegmentedControl!
    @IBOutlet weak var ans2SegmentedControl: UISegmentedControl!
    @IBOutlet weak var ans3SegmentedControl: UISegmentedControl!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var ans4SegmentedControl: UISegmentedControl!
    @IBOutlet weak var ans5SegmentedControl: UISegmentedControl!
    @IBOutlet weak var ans6SegmentedControl: UISegmentedControl!
    @IBOutlet weak var ans7SegmentedControl: UISegmentedControl!
    @IBOutlet weak var ans8SegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    var answers :[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerLabel.alpha = 0
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
      //  _ = navigationController?.popViewController(animated: true)

    }
    
    
    @IBAction func sendClicked(_ sender: Any) {
        
        answers = takeAnswersFromSegmentedControllers()
        let finalDecide = decideIfTheUserCanDonateBlood(answers: answers)
        if finalDecide{
            answerLabel.alpha = 1
            answerLabel.text = "You can donate blood!"
        }
        else{
            answerLabel.alpha = 1
            answerLabel.textColor = UIColor.red
            answerLabel.text = "Sorry, You can't donate blood right now."
        }
    }
    
    func decideIfTheUserCanDonateBlood(answers: [Int])->Bool{
        for ans in answers{
            if ans == 1{
                return false
            }
        }
        return true
    }
    
    func takeAnswersFromSegmentedControllers()->[Int]{
        let ans1 = ans1SegmentedControl.selectedSegmentIndex
        let ans2 = ans2SegmentedControl.selectedSegmentIndex
        let ans3 = ans3SegmentedControl.selectedSegmentIndex
        let ans4 = ans4SegmentedControl.selectedSegmentIndex
        let ans5 = ans5SegmentedControl.selectedSegmentIndex
        let ans6 = ans6SegmentedControl.selectedSegmentIndex
        let ans7 = ans7SegmentedControl.selectedSegmentIndex
        let ans8 = ans8SegmentedControl.selectedSegmentIndex
        
        var ansArray = [Int]()
        ansArray.append(ans1)
        ansArray.append(ans2)
        ansArray.append(ans3)
        ansArray.append(ans4)
        ansArray.append(ans5)
        ansArray.append(ans6)
        ansArray.append(ans7)
        ansArray.append(ans8)
        return ansArray
    }
    
}
