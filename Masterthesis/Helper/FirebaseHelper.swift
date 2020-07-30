
import FirebaseDatabase
import Foundation

var sharedFirebaseHelper = FirebaseHelper()

class FirebaseHelper {
    
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    func saveDataA1(uuid: String, a11: String, a12: String, a13: String, a14: String, a15: String, a16: String) {
        ref.child(uuid).child("A1").setValue(["Studiengang": a11, "Studienabschnitt": a12, "Geschlecht" : a13, "Alter" : a14, "Stunden pro Woche Arbeit" : a15, "Stunden pro Woche Lernen" : a16])
    }
    
    func saveDataB1(uuid: String, b11: Int, b12: Int, b13: Int, b14: Int, b15: Int, b16: Int, b1Average: Int) {
        ref.child(uuid).child("B1").setValue(["B11": b11, "B12" : b12, "B13" : b13, "B14" : b14, "B15" : b15, "B16": b16, "B1Average": b1Average])
    }
    
    func saveSteps(uuid: String, stepsLast30DaysAverage: Int, stepsLast60to30DaysAverage: Int, changeInPercentage: Double) {
        if changeInPercentage.isNaN {
            ref.child(uuid).child("Durschnittliche Schritte").setValue(["Letzten 30 Tage": Int(stepsLast30DaysAverage), "Letzten 60 bis 30 Tage": Int(stepsLast60to30DaysAverage), "Prozentuale Veränderung": 0])
        } else {
            ref.child(uuid).child("Durschnittliche Schritte").setValue(["Letzten 30 Tage": Int(stepsLast30DaysAverage), "Letzten 60 bis 30 Tage": Int(stepsLast60to30DaysAverage), "Prozentuale Veränderung": changeInPercentage])
        }
        
    }
}
