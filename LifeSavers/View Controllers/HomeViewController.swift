//
//  HomeViewController.swift
//  LifeSavers
//
//  Created by user167523 on 7/7/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var homeVC_hello_lbl: UILabel!
    @IBOutlet weak var homeVC_fillQ_btn: UIButton!
    @IBOutlet weak var homeVC_profile_btn: UIButton!
    @IBOutlet weak var homeVC_activePositions_btn: UIButton!
    @IBOutlet weak var homeVC_donationHistory_btn: UIButton!
    
    
    //set name at helloLabel
    func setNameFromAuth (){
        let userAuthID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("users").document(userAuthID!).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    let documentData = document!.data()
                    let optionalName = documentData?["firstName"]
                    //let optionalPhone = documentData?["phone"]
                    let name = optionalName!
                    self.homeVC_hello_lbl.text = "היי \(String(describing: name))!"
                }
            }
            else{
                print("error")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        styleButtons()
        setNameFromAuth()
        
    }
    
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        do{
            navigationController?.popToRootViewController(animated: true)
            try Auth.auth().signOut()
            
        }
        catch{
            print("already logged out")
        }
        
    }
    
    
    @IBAction func activePositionsClicked(_ sender: Any) {
        let activePositionsVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.activePositionsViewController) as? ActivePositionsViewController
        navigationController?.pushViewController(activePositionsVC!, animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fillQClicked(_ sender: Any) {
        let quastianireVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.quastianireViewController) as? QuastianireViewController1
        navigationController?.pushViewController(quastianireVC!, animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func myProfileClicked(_ sender: Any) {
        let myProfileVC = storyboard?.instantiateViewController(identifier: Const.Storyboard.myProfileViewController) as? MyProfileViewController
        navigationController?.pushViewController(myProfileVC!, animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    func styleButtons(){
        homeVC_fillQ_btn.layer.cornerRadius = 28.0
        homeVC_fillQ_btn.layer.borderColor = UIColor.systemRed.cgColor
        homeVC_fillQ_btn.layer.borderWidth = 3
        homeVC_fillQ_btn.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0.8, alpha: 1)
        /*homeVC_fillQ_btn.setImage(UIImage(named: "contact-form"), for: .normal)
         homeVC_fillQ_btn.imageView?.contentMode = .scaleAspectFit
         alignImageAndTitleVertically(button: homeVC_fillQ_btn)*/
        let imageSize:CGSize = CGSize(width: 10, height: 10)
        
        homeVC_fillQ_btn.frame = CGRect(x: 200, y: 200, width: 70, height: 70)
        homeVC_fillQ_btn.setImage(UIImage(named: "contact-form"), for: UIControl.State.normal)
        
        homeVC_fillQ_btn.imageEdgeInsets = UIEdgeInsets(
            top: (homeVC_fillQ_btn.frame.size.height - imageSize.height) / 2,
            left: (homeVC_fillQ_btn.frame.size.width - imageSize.width) / 2,
            bottom: (homeVC_fillQ_btn.frame.size.height - imageSize.height) / 2,
            right: (homeVC_fillQ_btn.frame.size.width - imageSize.width) / 2)
        
        //self.view.addSubview(button)
        
    }
    
    func alignImageAndTitleVertically(button: UIButton,padding: CGFloat = 6.0) {
        let spacing: CGFloat = 6.0
        
        let imageSize = button.imageView!.frame.size
        
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
        
        let titleSize = button.titleLabel!.frame.size
        
        button.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
        
    }
    
    
}
