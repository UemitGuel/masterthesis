
import FirebaseDatabase
import Foundation

class FirebaseHelper {
    
    static let shared = FirebaseHelper()
    
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
    
    func saveDataB1_2(uuid: String, b11_2: Int, b12_2: Int, b13_2: Int, b1_2Average: Int) {
        ref.child(uuid).child("B1_2").setValue(["B11_2": b11_2, "B12_2" : b12_2, "B13_2" : b13_2,"B1_2Average": b1_2Average])
    }
    
    func saveDataB2(uuid: String, b21: Int, b22: Int, b23: Int, b24: Int, b25: Int, b2Average: Int) {
        ref.child(uuid).child("B2").setValue(["B21": b21, "B22" : b22, "B23" : b23, "B24" : b24, "B25" : b25, "B2Average": b2Average])
    }
    
    func saveSteps(uuid: String, stepsLast30DaysAverage: Int, stepsLast60to30DaysAverage: Int, changeInPercentage: Double) {
        if changeInPercentage.isNaN {
            ref.child(uuid).child("Durschnittliche Schritte").setValue(["Letzten 30 Tage": Int(stepsLast30DaysAverage), "Letzten 60 bis 30 Tage": Int(stepsLast60to30DaysAverage), "Prozentuale Veränderung": 0])
        } else {
            ref.child(uuid).child("Durschnittliche Schritte").setValue(["Letzten 30 Tage": Int(stepsLast30DaysAverage), "Letzten 60 bis 30 Tage": Int(stepsLast60to30DaysAverage), "Prozentuale Veränderung": changeInPercentage])
        }
        
    }
}
