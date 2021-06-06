//
//  QuastianireViewController2.swift
//  LifeSavers
//
//  Created by user196697 on 5/13/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit
class QusatianireViewController2: UIViewController {
    
    @IBOutlet weak var stage2Q1_segmented: UISegmentedControl!
    @IBOutlet weak var stage2Q2_segmented: UISegmentedControl!
    @IBOutlet weak var stage2Q3_segmented: UISegmentedControl!
    
    
    @IBOutlet weak var backBtnPage2: UIButton!
    @IBOutlet weak var gotoPage3Btn: UIButton!
    @IBOutlet weak var gotoPage1Btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //to dismiss keyboard when tapping the screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
    }
    
    
    
    
    @IBAction func gotoPage3Action(_ sender: Any) {
        let donationCanBeUsed = getUserAnswers()
        let quastianirePage3VC = storyboard?.instantiateViewController(identifier: Const.Storyboard.quastianireViewController3) as? QusatianireViewController3
        navigationController?.pushViewController(quastianirePage3VC!, animated: true)
        
        
        
    }
    @IBAction func gotoPage1Action(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func goBackPage2Action(_ sender: Any) {
        let homePageVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.homeViewController) as? HomeViewController
        navigationController?.pushViewController(homePageVC!, animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func getUserAnswers () -> Bool{
        let ans1 = stage2Q1_segmented.selectedSegmentIndex;
        let ans2 = stage2Q2_segmented.selectedSegmentIndex;
        let ans3 = stage2Q3_segmented.selectedSegmentIndex;
        
        
        if (ans1 == 1 || ans2 == 1 || ans3 == 1){
            return false
        }
        
        return true
    }
}
