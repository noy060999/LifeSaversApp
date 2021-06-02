//
//  MyNotificationService.swift
//  LifeSavers
//
//  Created by user196697 on 6/2/21.
//  Copyright © 2021 NoyD. All rights reserved.
//

import UIKit
import UserNotifications

class MyNotificationService {
    
    static func askPermissions(_ completion: @escaping (_ permission: Int) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if (granted){
                print("granted")
                completion(1)
                //self.registerNotification()
            }
            else {
                print("denied")
                completion(-1)
            }
        }
    }
    
    static func addNotification(){
        
    }
    
    static func registerNotification(userAuthId: String, lastDonation: String) {
        var startDate = ""
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        content.title = "זמן לתרום דם!"
        content.body = "עברו 3 חודשים מתרומת הדם האחרונה שלך, הגיע הזמן לתרום שוב!"
        var dateDonated = ""
        //getLastDonation { res in
        print("completions: "+lastDonation)
        dateDonated = lastDonation
        print("last donation - in registerNotify: " + dateDonated)
        if (dateDonated != ""){
            startDate = dateDonated
            //print("self.startDate:"+self.startDate)
            let someDateTime = formatter.date(from:startDate)
            //print(someDateTime)
            let startDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: someDateTime!)
            var dateComponents = DateComponents()
            dateComponents.day = startDateComponents.day
            dateComponents.year = getYearByDate(dateComponents: startDateComponents)
            dateComponents.month = getMonthByDate(dateComponents: startDateComponents)
            print(dateComponents)
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
            print(trigger)
            let id = UUID().uuidString
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            //print(request)
            center.add(request) { error in
                if ((error) != nil){
                    print("error" + error!.localizedDescription)
                }
                else {
                    print("notification added! ..")
                }
            }
        }
        else {
            print("No Donations detected.")
            //self.startDate = formatter.string(from: Date())
        }
    }
    
    static func getMonthByDate(dateComponents: DateComponents) -> Int{
        if (dateComponents.month == 10){
            return 1
        }
        if (dateComponents.month == 11){
            return 2
        }
        if (dateComponents.month == 12){
            return 3
        }
        else {
            return dateComponents.month! + 3
        }
    }
    
    static func getYearByDate(dateComponents: DateComponents) -> Int{
        if (dateComponents.month! > 9){
            return dateComponents.year! + 1
        }
        else {
            return dateComponents.year!
        }
    }    //}
}
