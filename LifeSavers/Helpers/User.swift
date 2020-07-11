//
//  User.swift
//  LifeSavers
//
//  Created by user167523 on 7/7/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import Foundation

class User{
    private var _name: String? = nil
    private var _id: String? = nil
    private var _phone: String? = nil
    private var _password: String? = nil
    private var _defaultCity: String? = nil
    private var _birthDate: String? = nil
    private var _bloodType: String = "don't know"
    private var _email: String = "aaa@gmail.com"
    
    init(_name: String, _id: String, _phone: String, _password: String, _defaultCity: String, _birthDate: String, _bloodType: String, _email: String) {
        
        self.name = _name
        self.id = _id
        self.phone = _phone
        self.password = _password
        self.defaultCity = _defaultCity
        self.birthDate = _birthDate
        self.bloodType = _bloodType
        self.email = _email
    }
    var name: String{
        set{
            _name = newValue
        }
        get{
            return _name ?? "User"
        }
    }
    var id: String{
        set{
            _id = newValue
        }
        get{
            return _id ?? "000000000"
        }
    }
    var phone: String{
        set{
            _phone = newValue
        }
        get{
            return _phone ?? "0000000000"
        }
    }
    var password: String{
        set{
            _password = newValue
        }
        get{
            return _password ?? "123456"
        }
    }
    var email: String{
        set{
            _email = newValue
        }
        get{
            return _email
        }
    }
    var defaultCity: String{
        set{
            _defaultCity = newValue
        }
        get{
            return _defaultCity ?? "Tel Aviv"
        }
    }
    var birthDate: String{
        set{
            _birthDate = newValue
        }
        get{
            return _birthDate ?? "0000"
        }
    }
    
    var bloodType: String{
        set{
            _bloodType = newValue
        }
        get{
            return _bloodType
        }
    }
}

