
import HealthKit

let sharedStepCalculatorHelper = StepCalculatorHelper()

class StepCalculatorHelper {
    
    func getAverageStepsLast30Days(healthStore: HKHealthStore?, completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let oneMonthAgo = Calendar.current.date(byAdding: DateComponents(day: -30), to: now)!
        let startOfoneMonthAgo = Calendar.current.startOfDay(for: oneMonthAgo)
        let predicate = HKQuery.predicateForSamples(withStart: startOfoneMonthAgo, end: now, options: .strictStartDate)
        
        let query = HKStatisticsCollectionQuery.init(quantityType: stepsQuantityType,
                                                     quantitySamplePredicate: predicate,
                                                     options: .cumulativeSum,
                                                     anchorDate: startOfoneMonthAgo,
                                                     intervalComponents: DateComponents(day: 1))
        
        query.initialResultsHandler = { query, results, error in
            guard let statsCollection = results else {
                // Perform proper error handling here...
                fatalError()
            }
            var stepsTotal: Double = 0
            statsCollection.enumerateStatistics(from: startOfoneMonthAgo, to: now) { statistics, stop in
                if let quantity = statistics.sumQuantity() {
                    let stepValue = quantity.doubleValue(for: HKUnit.count())
                    stepsTotal += stepValue
                }
            }
            completion(stepsTotal/30)
        }
        
        healthStore?.execute(query)
    }
    
    func getAverageSteps60Days(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let oneMonthAgo = Calendar.current.date(byAdding: DateComponents(day: -30), to: now)!
        let twoMonthAgo = Calendar.current.date(byAdding: DateComponents(day: -60), to: now)!
        let startOfTwoMonthAgo = Calendar.current.startOfDay(for: twoMonthAgo)
        let predicate = HKQuery.predicateForSamples(withStart: startOfTwoMonthAgo, end: oneMonthAgo, options: .strictStartDate)
        
        let query = HKStatisticsCollectionQuery.init(quantityType: stepsQuantityType,
                                                     quantitySamplePredicate: predicate,
                                                     options: .cumulativeSum,
                                                     anchorDate: startOfTwoMonthAgo,
                                                     intervalComponents: DateComponents(day: 1))
        
        query.initialResultsHandler = { query, results, error in
            guard let statsCollection = results else {
                // Perform proper error handling here...
                fatalError()
            }
            var stepsTotal: Double = 0
            statsCollection.enumerateStatistics(from: startOfTwoMonthAgo, to: oneMonthAgo) { statistics, stop in
                if let quantity = statistics.sumQuantity() {
                    let stepValue = quantity.doubleValue(for: HKUnit.count())
                    stepsTotal += stepValue
                }
            }
            completion(stepsTotal/30)
        }
        
//        healthStore?.execute(query)
    }
    
    func getAverageSteps90Days(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let oneMonthAgo = Calendar.current.date(byAdding: DateComponents(day: -60), to: now)!
        let twoMonthAgo = Calendar.current.date(byAdding: DateComponents(day: -90), to: now)!
        let startOfTwoMonthAgo = Calendar.current.startOfDay(for: twoMonthAgo)
        let predicate = HKQuery.predicateForSamples(withStart: startOfTwoMonthAgo, end: oneMonthAgo, options: .strictStartDate)
        
        let query = HKStatisticsCollectionQuery.init(quantityType: stepsQuantityType,
                                                     quantitySamplePredicate: predicate,
                                                     options: .cumulativeSum,
                                                     anchorDate: startOfTwoMonthAgo,
                                                     intervalComponents: DateComponents(day: 1))
        
        query.initialResultsHandler = { query, results, error in
            guard let statsCollection = results else {
                // Perform proper error handling here...
                fatalError()
            }
            var stepsTotal: Double = 0
            statsCollection.enumerateStatistics(from: startOfTwoMonthAgo, to: oneMonthAgo) { statistics, stop in
                if let quantity = statistics.sumQuantity() {
                    let stepValue = quantity.doubleValue(for: HKUnit.count())
                    stepsTotal += stepValue
                }
            }
            completion(stepsTotal/30)
        }
        
//        healthStore?.execute(query)
    }
    
}
