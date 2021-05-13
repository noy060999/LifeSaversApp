//
//  QuastianireViewController.swift
//  LifeSavers
//
//  Created by user167523 on 7/7/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import UIKit

class QuastianireViewController: UIViewController {
    
    //outlets define
    @IBOutlet weak var ans1SegmentedControl: UISegmentedControl!
    @IBOutlet weak var ans2SegmentedControl: UISegmentedControl!
    @IBOutlet weak var ans3SegmentedControl: UISegmentedControl!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var ans4SegmentedControl: UISegmentedControl!
    @IBOutlet weak var ans5SegmentedControl: UISegmentedControl!
    @IBOutlet weak var ans6SegmentedControl: UISegmentedControl!
    @IBOutlet weak var ans7SegmentedControl: UISegmentedControl!
    @IBOutlet weak var ans8SegmentedControl: UISegmentedControl!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    
    //all answers
    var answers :[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dismiss answerLabel
        //answerLabel.alpha = 0
        var popUpWindow: PopUpWindow!
        popUpWindow = PopUpWindow(title: "מידע לפני תרומה", text: "אנו מודים לך על נכונותך לתרום דם. תרומת דם מצילה חיי אדם ועשויה לעזור למספר חולים ,אם מצב בריאותך תקין. כל מנות הדם עוברות בדיקות קפדניות בבנק הדם, כדי לשלול נוכחות נגיפים ,אולם לא תמיד ניתן לזהות נגיפים מסוימים, כמו: איידס או דלקת כבד בשלב מוקדם של ההדבקה . אם נחשפת לנגיפים בדרך כלשהי , דמך עלול להעביר מחלות ולפגוע בחולים שיקבלו את המנה . לפי הנחיות משרד הבריאות , הנך נדרש/ת להשיב על השאלות בשאלון זה . חשוב שהמידע שתמסור/י בו, יהיה אמין כדי להגן על בריאותך ועל בריאות מקבלי המנה . אי מילוי שאלון  זה לא יאפשר לנו להתרים אותך . על המידע שתמסור/י , כמו גם על תוצאות הבדיקות שיבוצעו במנה, חל חיסיון מלא והם לא יועברו לגורם אחר, אלא אם העברה זו נדרשת על פי דין, ו/או במקרה של צורך רפואי. אם ברצונך לבדוק חשיפה לאיידס , פנה/י לאחד המרכזים הרפואיים בהם מתבצעות בדיקות איידס , לוועד למלחמה באיידס, או לרופא המשפחה , ואלתתרום/י דם . בכל שלב תוכל/י ליידע את בנק הדם, על רצונך להפסיק את התרומה ,להורות שלא יעשה שימוש במנה שתרמת, או לעדכן על כל שינוי במצב בריאותך , גם לאחר התרומה. לידיעתך, תהליך תרומת דם מלא אורך כ-30דקות. תהליך תרומת מרכיבי דם בשיטת אפרזיס, אורך כשעתיים וחצי. מומלץ לאכול משהו קל ולשתות לפני תרומת דם ומרכיביו. לפני תרומת הדם חובה להציג תעודה מזהה, הכוללת מספר תעודת זהות ותמונה. לכל תורם בגיל 18-17 נדרשים גם: אישור הורים או אפוטרופוס חוקי. לתורם מעל גיל 60 נדרש אישור רפואי בעת תרומה ראשונה,ולכל תורם מעל גיל 65 נדרש אישור רפואי אחת לשנה.", buttontext: "אני מסכים")
        self.present(popUpWindow, animated: true, completion: nil)
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func sendClicked(_ sender: Any) {
        
        answers = takeAnswersFromSegmentedControllers()
        let finalDecide = decideIfTheUserCanDonateBlood(answers: answers)
        if finalDecide{
            answerLabel.alpha = 1
            answerLabel.text = "You can donate blood!"
        }
        else{
            answerLabel.alpha = 1
            answerLabel.textColor = UIColor.red
            answerLabel.text = "Sorry, You can't donate blood right now."
        }
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
    
    
    func takeAnswersFromSegmentedControllers()->[Int]{
        let ans1 = ans1SegmentedControl.selectedSegmentIndex
        let ans2 = ans2SegmentedControl.selectedSegmentIndex
        let ans3 = ans3SegmentedControl.selectedSegmentIndex
        let ans4 = ans4SegmentedControl.selectedSegmentIndex
        let ans5 = ans5SegmentedControl.selectedSegmentIndex
        let ans6 = ans6SegmentedControl.selectedSegmentIndex
        let ans7 = ans7SegmentedControl.selectedSegmentIndex
        let ans8 = ans8SegmentedControl.selectedSegmentIndex
        
        var ansArray = [Int]()
        ansArray.append(ans1)
        ansArray.append(ans2)
        ansArray.append(ans3)
        ansArray.append(ans4)
        ansArray.append(ans5)
        ansArray.append(ans6)
        ansArray.append(ans7)
        ansArray.append(ans8)
        return ansArray
    }
    
}
