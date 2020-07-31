
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
    
    func saveDataB3(uuid: String, b31: Int, b32: Int, b33: Int, b34: Int, b35: Int, b3Average: Int) {
        ref.child(uuid).child("B3").setValue(["B31": b31, "B32" : b32, "B33" : b33, "B34" : b34, "B35" : b35,"B3Average": b3Average])
    }
    
    func saveDataB4(uuid: String, b41: Int, b4Average: Int) {
        ref.child(uuid).child("B4").setValue(["B41": b41,"B4Average": b4Average])
    }
    
    func saveDataB5(uuid: String, b51: Int, b52: Int, b53: Int, b54: Int, b55: Int, b56: Int, b5Average: Int) {
        ref.child(uuid).child("B5").setValue(["B51": b51, "B52" : b52, "B53" : b53, "B54" : b54, "B55" : b55, "B56": b56, "B5Average": b5Average])
    }
    
    func saveSteps(uuid: String, stepsLast30DaysAverage: Int, stepsLast60to30DaysAverage: Int, changeInPercentage: Double) {
        if changeInPercentage.isNaN {
            ref.child(uuid).child("Durschnittliche Schritte").setValue(["Letzten 30 Tage": Int(stepsLast30DaysAverage), "Letzten 60 bis 30 Tage": Int(stepsLast60to30DaysAverage), "Prozentuale Veränderung": 0])
        } else {
            ref.child(uuid).child("Durschnittliche Schritte").setValue(["Letzten 30 Tage": Int(stepsLast30DaysAverage), "Letzten 60 bis 30 Tage": Int(stepsLast60to30DaysAverage), "Prozentuale Veränderung": changeInPercentage])
        }
        
    }
}
