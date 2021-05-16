//
//  QuastianireViewController.swift
//  LifeSavers
//
//  Created by user167523 on 7/7/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import UIKit
import Firebase


class QuastianireViewController1: UIViewController {
    
    //outlets define
    
    @IBOutlet weak var errLbl: UILabel!
    @IBOutlet weak var familyName_q: UITextField!
    @IBOutlet weak var firstName_q: UITextField!
    @IBOutlet weak var weight_q: UITextField!
    @IBOutlet weak var id_q: UITextField!
    @IBOutlet weak var gender_q: UITextField!
    @IBOutlet weak var birthdate_q: UITextField!
    @IBOutlet weak var age_q: UITextField!
    @IBOutlet weak var prevName_q: UITextField!
    @IBOutlet weak var streetNum_q: UITextField!
    @IBOutlet weak var postCode_q: UITextField!
    @IBOutlet weak var city_q: UITextField!
    @IBOutlet weak var homePhone_q: UITextField!
    @IBOutlet weak var mobilePhone_q: UITextField!
    @IBOutlet weak var email_q: UITextField!
    @IBOutlet weak var birthCountry_q: UITextField!
    @IBOutlet weak var momBirthcountry_q: UITextField!
    @IBOutlet weak var dadBirthcountry_q: UITextField!
    @IBOutlet weak var counryArrivedYear_q: UITextField!
    @IBOutlet weak var nameOfPatient: UITextField!
    @IBOutlet weak var reminedToDonate_segmented_q: UISegmentedControl!
    
    @IBOutlet weak var agreementToSearching_segmented_q: UISegmentedControl!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var moveToPage2Btn: UIButton!
    //all answers
    var answers :[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errLbl.alpha = 0
        //to dismiss keyboard when tapping the screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        setFieldsFromDB()
        setFieldsToDisable()
        //dismiss answerLabel
        //answerLabel.alpha = 0
        var popUpWindow: PopUpWindow!
        popUpWindow = PopUpWindow(title: "מידע לפני תרומה", text: "אנו מודים לך על נכונותך לתרום דם. תרומת דם מצילה חיי אדם ועשויה לעזור למספר חולים ,אם מצב בריאותך תקין. כל מנות הדם עוברות בדיקות קפדניות בבנק הדם, כדי לשלול נוכחות נגיפים ,אולם לא תמיד ניתן לזהות נגיפים מסוימים, כמו: איידס או דלקת כבד בשלב מוקדם של ההדבקה . אם נחשפת לנגיפים בדרך כלשהי , דמך עלול להעביר מחלות ולפגוע בחולים שיקבלו את המנה . לפי הנחיות משרד הבריאות , הנך נדרש/ת להשיב על השאלות בשאלון זה . חשוב שהמידע שתמסור/י בו, יהיה אמין כדי להגן על בריאותך ועל בריאות מקבלי המנה . אי מילוי שאלון  זה לא יאפשר לנו להתרים אותך . על המידע שתמסור/י , כמו גם על תוצאות הבדיקות שיבוצעו במנה, חל חיסיון מלא והם לא יועברו לגורם אחר, אלא אם העברה זו נדרשת על פי דין, ו/או במקרה של צורך רפואי. אם ברצונך לבדוק חשיפה לאיידס , פנה/י לאחד המרכזים הרפואיים בהם מתבצעות בדיקות איידס , לוועד למלחמה באיידס, או לרופא המשפחה , ואלתתרום/י דם . בכל שלב תוכל/י ליידע את בנק הדם, על רצונך להפסיק את התרומה ,להורות שלא יעשה שימוש במנה שתרמת, או לעדכן על כל שינוי במצב בריאותך , גם לאחר התרומה. לידיעתך, תהליך תרומת דם מלא אורך כ-30דקות. תהליך תרומת מרכיבי דם בשיטת אפרזיס, אורך כשעתיים וחצי. מומלץ לאכול משהו קל ולשתות לפני תרומת דם ומרכיביו. לפני תרומת הדם חובה להציג תעודה מזהה, הכוללת מספר תעודת זהות ותמונה. לכל תורם בגיל 18-17 נדרשים גם: אישור הורים או אפוטרופוס חוקי. לתורם מעל גיל 60 נדרש אישור רפואי בעת תרומה ראשונה,ולכל תורם מעל גיל 65 נדרש אישור רפואי אחת לשנה.", buttontext: "אני מסכים")
        self.present(popUpWindow, animated: true, completion: nil)
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    @IBAction func goToPage2Action(_ sender: Any) {
        let err = getUserInformationFromVC()
        var popUpWindow: PopUpWindow!
        if (err != ""){
            if (err == "invalid age"){
                popUpWindow = PopUpWindow(title: "הודעה לתורם", text: "לצערנו, אינך יכול לתרום דם כרגע.", buttontext: "אישור")
                self.present(popUpWindow, animated: true, completion: nil)
            }
            if (err == "weight too low"){
                popUpWindow = PopUpWindow(title: "הודעה לתורם", text: "לצערנו, אינך יכול לתרום דם כרגע.", buttontext: "אישור")
                self.present(popUpWindow, animated: true, completion: nil)
            }else {
                showErr(msg: err)
            }
        }
        else if (err == ""){
            errLbl.alpha = 0
            let quastianirePage2VC = storyboard?.instantiateViewController(identifier: Const.Storyboard.quastianireViewController2) as? QusatianireViewController2
            navigationController?.pushViewController(quastianirePage2VC!, animated: true)
            
        }
        
        //self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //check all answers and return the decide
    func decideIfTheUserCanDonateBlood(answers: [Int])->Bool{
        for ans in answers{
            if ans == 1{
                return false
            }
        }
        return true
    }
    
    func setFieldsFromDB(){
        let userAuthID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("users").document(userAuthID!).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    let documentData = document!.data()
                    let firstName = documentData?["firstName"]!
                    let familyName = documentData?["familyName"]!
                    let gender = documentData?["gender"]!
                    let birthDate = documentData?["birthDate"]!
                    let id = documentData?["id"]!
                    let mobilePhone = documentData?["phone"]!
                    let email = Auth.auth().currentUser?.email
                    
                    self.familyName_q.text = familyName as? String;
                    self.firstName_q.text = firstName as? String;
                    self.gender_q.text = gender as? String;
                    self.birthdate_q.text = birthDate as? String;
                    self.id_q.text = id as? String;
                    self.mobilePhone_q.text = mobilePhone as? String;
                    self.email_q.text = email;
                    //let now = Date();
                    let age = self.calcAge(birthday: birthDate as! String)
                    self.age_q.text = String(age)
                    
                }
            }
            else{
                print("error")
            }
        }    }

    func showErr(msg : String){
        errLbl.text = msg
        errLbl.alpha = 1
    }
    
    func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd-MM-yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
    
    func setFieldsToDisable () {
        familyName_q.isEnabled = false
        familyName_q.backgroundColor = UIColor.systemGray5
        firstName_q.isEnabled = false
        firstName_q.backgroundColor = UIColor.systemGray5
        age_q.isEnabled = false
        age_q.backgroundColor = UIColor.systemGray5
        birthdate_q.isEnabled = false
        birthdate_q.backgroundColor = UIColor.systemGray5
        id_q.isEnabled = false
        id_q.backgroundColor = UIColor.systemGray5
        email_q.isEnabled = false
        email_q.backgroundColor = UIColor.systemGray5
        gender_q.isEnabled = false
        gender_q.backgroundColor = UIColor.systemGray5
        mobilePhone_q.isEnabled = false
        mobilePhone_q.backgroundColor = UIColor.systemGray5
        
    }
    func getUserInformationFromVC () -> String{
        _ = prevName_q.text
        let address = streetNum_q.text
        let city = city_q.text
        let postcode = postCode_q.text
        let homePhone = homePhone_q.text
        let birthCountry = birthCountry_q.text
        let momBirth = momBirthcountry_q.text
        let dadBirth = dadBirthcountry_q.text
        let weight = weight_q.text
        let age = age_q.text
        _ = counryArrivedYear_q.text
        _ = nameOfPatient.text
        _ = reminedToDonate_segmented_q.selectedSegmentIndex
        _ = agreementToSearching_segmented_q.selectedSegmentIndex
        
        if (weight != ""){
            let floatWeight = (weight! as NSString).floatValue
            if (floatWeight < 50.0){
                showErr(msg: "לא ניתן לתרום דם במשקל נמוך מ-50 ק״ג")
                return "weight too low"
            }
        }
        let intAge = (age! as NSString).intValue
        
        if (intAge < 17 || intAge > 60){
            showErr(msg: "ניתן לתרום דם מגיל 17-60 בלבד")
            return "invalid age"
        }
        if (address == "" || city == "" || postcode == "" ||
                birthCountry == "" || momBirth == "" || dadBirth == "" || weight == "") {
            return "מלא את כל שדות החובה"
        }
        if (homePhone != ""){
            if (validateHomePhone(homePhone: homePhone!) == false){
                homePhone_q.textColor = UIColor.red
                homePhone_q.text = "בבקשה הזן מספר טלפון תקין (ללא -)"
                return "בבקשה הזן מספר טלפון תקין (ללא -)"
            }
        }
        
        return ""
    }
    
    func validateHomePhone(homePhone : String) -> Bool {
        if (homePhone.count != 9){
            return false;
        }
        return true
    }
    
    
    
}
