//
//  AddDoantePopup.swift
//  LifeSavers
//
//  Created by user196697 on 5/17/21.
//  Copyright © 2021 NoyD. All rights reserved.
//


import UIKit
import Firebase

private class AddDonatePopup: UIView {
    
    let popupView = UIView(frame: CGRect.zero)
    let popupTitle = UILabel(frame: CGRect.zero)
    let popupButton = UIButton(frame: CGRect.zero)
    let txtField = UITextField(frame: CGRect.zero)
    let txtFieldDate = UIDatePicker(frame: CGRect.zero)
    let dateLabel = UILabel(frame: CGRect.zero)
    let closeButton = UIButton(frame: CGRect.zero)
    
    let BorderWidth: CGFloat = 2.0
    
    init() {
        super.init(frame: CGRect.zero)
        // Semi-transparent background
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        // Popup Background
        popupView.backgroundColor = UIColor.white
        popupView.layer.borderWidth = BorderWidth
        popupView.layer.masksToBounds = true
        popupView.layer.borderColor = UIColor.white.cgColor
        
        // Popup Title
        popupTitle.textColor = UIColor.white
        popupTitle.backgroundColor = UIColor.systemTeal
        popupTitle.layer.masksToBounds = true
        popupTitle.adjustsFontSizeToFitWidth = true
        popupTitle.clipsToBounds = true
        popupTitle.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        popupTitle.numberOfLines = 1
        popupTitle.textAlignment = .center
        
        
        //close button
        let closeImg = UIImage(named: "cancel.png")
        closeButton.setImage(closeImg, for: .normal)
        
            
        // Popup TextField
        txtField.textColor = UIColor.black
        txtField.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        txtField.textAlignment = .center
        txtField.layer.borderWidth = 0.5
        txtField.layer.borderColor = UIColor.black.cgColor
        txtField.layer.cornerRadius = 12.0
        txtField.placeholder = "עיר"
        
        //date label
        dateLabel.text = "תאריך:"
        dateLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        dateLabel.textColor = UIColor.systemGray
        dateLabel.textAlignment = .right
        
        //date
        txtFieldDate.datePickerMode = UIDatePicker.Mode.date
        
    
        // Popup Button
        popupButton.setTitleColor(UIColor.white, for: .normal)
        popupButton.titleLabel?.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        popupButton.backgroundColor = UIColor.systemTeal
        
        
        popupView.addSubview(popupTitle)
        popupView.addSubview(closeButton)
        popupView.addSubview(txtField)
        popupView.addSubview(dateLabel)
        popupView.addSubview(txtFieldDate)
        popupView.addSubview(popupButton)
        
        // Add the popupView(box) in the PopUpWindowView (semi-transparent background)
        addSubview(popupView)
        
        
        // PopupView constraints
        popupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupView.widthAnchor.constraint(equalToConstant: 300),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        
        // PopupTitle constraints
        popupTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupTitle.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
            popupTitle.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
            popupTitle.topAnchor.constraint(equalTo: popupView.topAnchor, constant: BorderWidth),
            popupTitle.heightAnchor.constraint(equalToConstant: 55)
            ])
        
        // closeButton constraints
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 8),
            //closeButton.trailingAnchor.constraint(equalTo: popupTitle.trailingAnchor, constant: 0),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            closeButton.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 8),
            closeButton.heightAnchor.constraint(equalToConstant: 25)
            ])
        
        
        
        
        
        // PopupText constraints
        txtField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            txtField.heightAnchor.constraint(greaterThanOrEqualToConstant: 35),
            txtField.topAnchor.constraint(equalTo: popupTitle.bottomAnchor, constant: 8),
            txtField.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15),
            txtField.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
            txtField.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -43)
            ])
        
        //date label
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 35),
            dateLabel.topAnchor.constraint(equalTo: txtField.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
            dateLabel.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -10)
            ])
        
        // dateText constraints
        txtFieldDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            txtFieldDate.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            txtFieldDate.topAnchor.constraint(equalTo: txtField.bottomAnchor, constant: 8),
            txtFieldDate.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15),
            txtFieldDate.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
            txtFieldDate.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -8)
            ])
        
        

        
        // PopupButton constraints
        popupButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupButton.heightAnchor.constraint(equalToConstant: 44),
            popupButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
            popupButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
            popupButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -BorderWidth)
            ])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AddDonatePopupVC: UIViewController {

    private let popUpWindowView = AddDonatePopup()
    
    init(title: String, buttontext: String) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        popUpWindowView.popupTitle.text = title
        popUpWindowView.txtField.placeholder = "עיר"
        //popUpWindowView.txtField.text = text
        popUpWindowView.popupButton.setTitle(buttontext, for: .normal)
        popUpWindowView.popupButton.addTarget(self, action: #selector(addDonateToUser), for: .touchUpInside)
        popUpWindowView.closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)

      
        // ...
        
        view = popUpWindowView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addDonateToUser() {
        let uid = (Auth.auth().currentUser?.uid)!
        let donateDate = popUpWindowView.txtFieldDate.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateStr = dateFormatter.string(from: donateDate)
        let donateCity = popUpWindowView.txtField.text!

        getDonationsArr(userAuthID: uid) { res in
            var donationArray = [String]()
            /*print("after calling the function:")
            print(res)*/
            if (res != nil){
                donationArray = res! as [String]
                if (donateCity != "" && donateCity != "הזן עיר"){
                    let donateFullStr = "city: " + donateCity + ", date: " + dateStr
                    donationArray.append(donateFullStr)
                    print("after adding")
                    print(donationArray)
                    let db = Firestore.firestore()
                    db.collection("users").document(uid).updateData(["donations": donationArray] )
                    self.dismissView()
                }
                else {
                    self.popUpWindowView.txtField.text = "הזן עיר"
                }
                
            }
        }
    }
    
    func getDonationsArr (userAuthID : String, completion:@escaping(([String]?) -> ())){
        let db = Firestore.firestore()
        //var donationArr = Array<Any>()
        var donate_array = Array<String>()
        db.collection("users").document(userAuthID).getDocument { (document, error) in
            if let document = document {
                donate_array = document["donations"] as? Array ?? []
                print ("inside")
                print(donate_array)
                completion(donate_array)
            }
            else {
                completion(nil)
            }
            
        }
        
    }
    
    @objc func moveToHome (){
        self.dismissView()
        //need to figure how to go back to homepage
        print("inside movetohome")
    }

}
