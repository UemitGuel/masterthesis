
import Foundation

let sharedAverageCalculatorHelper = AverageCalculatorHelper()

class AverageCalculatorHelper {
    
    func getAverage(arrayOfInt: [Int]) -> Int {
        var total = 0
        for item in arrayOfInt {
            total += item
        }
        let average = total/arrayOfInt.count
        return average
    }
    
}
