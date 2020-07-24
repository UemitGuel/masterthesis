
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
}
