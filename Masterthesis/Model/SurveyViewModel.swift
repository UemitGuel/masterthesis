
import UIKit
import Foundation

var sharedModel = SurveyViewModel()

enum StepsEnum: String {
    case stepsLast30days
    case stepsLast60to30days
    case changeInPercentage
}

struct SurveyViewModel {
    
    let uuid = "ExampleUser1"
    
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
