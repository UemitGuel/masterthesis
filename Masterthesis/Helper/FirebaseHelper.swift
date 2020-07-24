
import FirebaseDatabase
import Foundation

var sharedFirebaseHelper = FirebaseHelper()

class FirebaseHelper {
   
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    func saveDataA1(uuid: String, a11: String, a12: String, a13: String, a14: String, a15: String) {
        ref.child("users").child(uuid).child("A1").setValue(["Studiengang": a11, "Geschlecht" : a12, "Alter" : a13, "Stunden pro Woche Arbeit" : a14, "Stunden pro Woche Lernen" : a15])
    }
    
    func saveDataB1(uuid: String, b11: Int, b12: Int, b13: Int, b14: Int, b15: Int, b16: Int, b1Average: Int) {
        ref.child("users").child(uuid).child("B1").setValue(["b11": b11, "b12" : b12, "b13" : b13, "b14" : b14, "b15" : b15, "b16": b16, "b1Average": b1Average])
    }
}
