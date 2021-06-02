//
//  FirebaseService.swift
//  LifeSavers
//
//  Created by user196697 on 6/2/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit
import Firebase

class FirebaseService {
    static var allDonations : [String] = []
    static var allDoantionsStr : [String] = []
    static var allDatesStr : [String] = []
    
    static func getName(uid: String, completion: @escaping (_ name: String) -> Void){
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    let documentData = document!.data()
                    let optionalName = documentData?["firstName"]
                    let name = optionalName!
                    completion(name as! String)
                }
            }
            else{
                completion("error")
                
            }
        }
    }
    
    static func getLastDonation (_ completion: @escaping (_ result: String) -> Void) {
        let uid = (Auth.auth().currentUser?.uid)!
        var lastDonation = ""
        getDatesArr(userAuthID: uid) { allDatesStr in
            if (allDatesStr.count > 0) {
                lastDonation = allDatesStr[allDatesStr.count-1]
                print("last in getLastDonation :"+lastDonation)
                completion(lastDonation)
            }
            else {
                completion("")
            }
        }
    }
    
    static func getDonationsArr (userAuthID : String, _ completion: @escaping (_ arr: [String]) -> Void){
        let db = Firestore.firestore()
        self.allDoantionsStr.removeAll()
        db.collection("users").document(userAuthID).getDocument { (document, error) in
            if let document = document {
                self.allDonations = document["donations"] as? Array ?? []
                for donate in self.allDonations {
                    let cityDate = donate.split(separator: ",")
                    let cityPart = cityDate[0].split(separator: ":")
                    let city = cityPart[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    let datePart = cityDate[1].split(separator: ":")
                    let date = datePart[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    let hebrewStr = "עיר: " + city + " " + "תאריך: " + date
                    self.allDoantionsStr.append(hebrewStr)
                }
                
            }
            completion(self.allDoantionsStr)
        }
    }
    
    static func getDatesArr (userAuthID : String, _ completion: @escaping (_ arr: [String]) -> Void){
        let db = Firestore.firestore()
        db.collection("users").document(userAuthID).getDocument { (document, error) in
            if let document = document {
                self.allDonations = document["donations"] as? Array ?? []
                for donate in self.allDonations {
                    let cityDate = donate.split(separator: ",")
                    let datePart = cityDate[1].split(separator: ":")
                    let date = datePart[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    print("date inside get:"+date)
                    self.allDatesStr.append(date)
                }
            }
            completion(self.allDatesStr)
        }
    }
    static func loginUser(userEmail: String, userPassword: String, rememberMe: Bool, completion: @escaping (_ result: String, _ err: Bool) -> Void){
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (result, error) in
            if error != nil {
                // Couldn't sign in
                completion(error!.localizedDescription, true)
            }
            else {
                let userAuthID = Auth.auth().currentUser?.uid
                let db = Firestore.firestore()
                db.collection("users").document(userAuthID!).getDocument { (document, error) in
                    if error == nil{
                        if document != nil && document!.exists{
                            db.collection("users").document(userAuthID!).updateData(["rememberMe": rememberMe as Any])
                        }
                        completion("success", false)
                    }
                    else{
                        completion(error!.localizedDescription, true)
                        print("error")
                    }
                }
            }
        }
    }
    static func sendPasswordReset(userEmail: String, completion: @escaping (_ res: String, _ error: Bool) -> Void){
        Auth.auth().sendPasswordReset(withEmail: userEmail) {(error) in
            if error != nil{
                completion(error!.localizedDescription, true)
                print(error!)
            }
            else {
                let msg = "הקישור לאיפוס הסיסמה נשלח בהצלחה"
                completion(msg, false)
                print("success sending email")
            }
        }
    }
    
    static func updateUserData(userAuthId: String, dataArr: [String: String]){
        let db = Firestore.firestore()
        let name = dataArr["name"]
        let familyName = dataArr["familyN"]
        let phone = dataArr["phone"]
        let gender = dataArr["gender"]
        let id = dataArr["id"]
        let birthD = dataArr["birthD"]
        let bloodT = dataArr["bloodType"]
        db.collection("users").document(userAuthId).updateData(["firstName": name as Any, "familyName":familyName as Any, "id": id as Any, "phone": phone as Any, "gender": gender as Any, "bloodType": bloodT as Any, "birthDate": birthD as Any] )
    }
    
    static func getUserParameters(userAuthId: String,_ completion: @escaping (_ arr: [String: String], _ err: Bool) -> Void){
        let db = Firestore.firestore()
        db.collection("users").document(userAuthId).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    let documentData = document!.data()
                    let name = (documentData?["firstName"])!
                    let phone = (documentData?["phone"])!
                    let id = (documentData?["id"])!
                    let birthdate = (documentData?["birthDate"])!
                    let gender = (documentData?["gender"])!
                    let bloodType = (documentData?["bloodType"])!
                    let familyName = (documentData?["familyName"])!
                    
                    let data = ["name": name as! String, "phone":phone as! String, "id": id as! String, "birthD": birthdate as! String, "gender": gender as! String, "bloodT": bloodType as! String, "familyN": familyName as! String]
                    
                    completion(data, false)
                }
            }
            else{
                let data = ["err":error!.localizedDescription]
                completion(data, true)
                print("error")
            }
        }
    }}


