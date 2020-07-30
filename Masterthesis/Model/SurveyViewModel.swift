
import UIKit
import Foundation

var sharedModel = SurveyViewModel()

struct SurveyViewModel {
    
    let uuid = "ExampleUser1"
    
    var stepsLast30days: Double?
    var stepsLast60to30days: Double?
    
    var changeInPercentage: Double? {
        guard let last30 = stepsLast30days else { return -1 }
        guard let last60 = stepsLast60to30days else { return -1 }
        let devision: Double = (((last60/last30)-1)*100)
        return devision
    }
    
    var a11Answer: String?
    var a12Answer: String?
    var a13Answer: String?
    var a14Answer: String?
    var a15Answer: String?
    
    var b11Answer: Int?
    var b12Answer: Int?
    var b13Answer: Int?
    var b14Answer: Int?
    var b15Answer: Int?
    var b16Answer: Int?
    var averageB1FormResult: Int? {
        let b1NotNilAnswerArray = [b11Answer,b12Answer,b13Answer,b14Answer,b15Answer,b16Answer].compactMap { $0 }
        if b1NotNilAnswerArray.count != 0 {
            var total = 0
            for item in b1NotNilAnswerArray {
                total += item
            }
            let average = total/b1NotNilAnswerArray.count
            return average
        } else {
            return 0
        }
    }
}
