//
//  Extenstions.swift
//  LifeSavers
//
//  Created by user196697 on 5/16/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit

extension UIButton {
    func customBtnSignUp() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.backgroundColor = UIColor.red
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 8
    }
    func customBtnSignIn() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.backgroundColor = UIColor.systemTeal
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowColor = UIColor.systemTeal.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 8
        
    }
}
