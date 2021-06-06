//
//  Donation.swift
//  LifeSavers
//
//  Created by user196697 on 6/6/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit

class Donation{
    private var _city: String = ""
    var city: String {
        set {
            _city = newValue
        }
        get {
           return _city
        }
    }
    private var _date: Date
    var date: Date {
        set{
            _date = newValue
        }
        get{
            return _date
        }
    }
    private var _gender: String = ""
    var gender: String {
        set{
            _gender = newValue
        }
        get{
            return _gender
        }
    }
    private var _bloodType: String = ""
    var bloodType : String {
        set{
            _bloodType = newValue
        }
        get{
            return _bloodType
        }
    }
    
    init (city: String, bloodT: String, gender: String, date: Date){
        self._city = city
        self._bloodType = bloodT
        self._date = date
        self._gender = gender
    }
    
    public var description: String { return "Donation: \(city) , \(date) , \(gender) , \(bloodType)" }
}
