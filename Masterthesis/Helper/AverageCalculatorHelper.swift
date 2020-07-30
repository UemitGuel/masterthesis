
import Foundation

class AverageCalculatorHelper {
    
    static let shared = AverageCalculatorHelper()
    
    func getAverage(_ arrayOfInt: [Int?]) -> Int {
        let arrayOfIntNotNil = arrayOfInt.compactMap { $0 }
        if arrayOfIntNotNil.count == 0 {
            return 0
        } else {
            var total = 0
            for item in arrayOfIntNotNil {
                total += item
            }
            let average = total/arrayOfIntNotNil.count
            return average
        }

    }
    
}
