//
//  Location.swift
//  LifeSavers
//
//  Created by user167523 on 7/10/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import Foundation
import MapKit

class Location {
    private var _location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    private var _city: String = ""
    private var _address: String = ""
    private var _startTime: String = ""
    private var _endTime: String = ""
    private var _locationString = ""
    init (){
        
    }
    init (_location: CLLocationCoordinate2D, _city: String, _address: String, _startTime: String, _endTime: String){
        
        self.location = _location
        self.city = _city
        self.address = _address
        self.startTime = _startTime
        self.endTime = _endTime
    }
    var location: CLLocationCoordinate2D{
        set{
           _location = newValue
        }
        get {
            return _location ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        }
    }
    var city: String{
        set{
            _city = newValue
        }
        get{
            return _city
        }
    }
    var address: String{
        set{
            _address = newValue
        }
        get{
            return _address
        }
    }
    var startTime: String{
        set{
            _startTime = newValue
        }
        get{
            return _startTime
        }
    }
    var endTime: String{
        set{
            _endTime = newValue
        }
        get{
            return _endTime
        }
    }
    
    var locationString: String{
        set{
            _locationString = newValue
        }
        get{
            return _locationString
        }
    }
}
