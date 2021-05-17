//
//  PopUpWindow.swift
//  LifeSavers
//
//  Created by user196697 on 5/8/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit

private class PopUpWindowView: UIView {
    
    let popupView = UIView(frame: CGRect.zero)
    let popupTitle = UILabel(frame: CGRect.zero)
    let popupText = UILabel(frame: CGRect.zero)
    let popupButton = UIButton(frame: CGRect.zero)
    let txtView = UITextView(frame: CGRect.zero)
    var isDissmissed = false
    
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
        popupTitle.backgroundColor = UIColor.red
        popupTitle.layer.masksToBounds = true
        popupTitle.adjustsFontSizeToFitWidth = true
        popupTitle.clipsToBounds = true
        popupTitle.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        popupTitle.numberOfLines = 1
        popupTitle.textAlignment = .center
        
        // Popup Text
        popupText.textColor = UIColor.black
        popupText.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        popupText.numberOfLines = 0
        popupText.textAlignment = .center
        
        // Popup Button
        popupButton.setTitleColor(UIColor.white, for: .normal)
        popupButton.titleLabel?.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        popupButton.backgroundColor = UIColor.red
        
        
        popupView.addSubview(popupTitle)
        popupView.addSubview(popupText)
        popupView.addSubview(popupButton)
        popupView.addSubview(txtView)
        
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
        
        
        // PopupText constraints
        popupText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupText.heightAnchor.constraint(greaterThanOrEqualToConstant: 67),
            popupText.topAnchor.constraint(equalTo: popupTitle.bottomAnchor, constant: 8),
            popupText.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15),
            popupText.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
            popupText.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -8)
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

class PopUpWindow: UIViewController {

    private let popUpWindowView = PopUpWindowView()
    
    init(title: String, text: String, buttontext: String) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        popUpWindowView.isDissmissed = false
        popUpWindowView.popupTitle.text = title
        popUpWindowView.popupText.text = text
        popUpWindowView.popupButton.setTitle(buttontext, for: .normal)
        if (buttontext == "אישור"){
            print("going home")
            popUpWindowView.popupButton.addTarget(self, action: #selector(moveToHome), for: .touchUpInside)
        }
        else {
            print("dismiss")
            popUpWindowView.popupButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        }
      
        // ...
        
        view = popUpWindowView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func isDismissed(){
        popUpWindowView.isDissmissed = true
    }
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func moveToHome (){
        self.dismissView()
        self.isDismissed()
        //need to figure how to go back to homepage
        print("inside movetohome")
    }

}
