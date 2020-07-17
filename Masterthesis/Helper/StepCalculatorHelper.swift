
import HealthKit

let sharedStepCalculatorHelper = StepCalculatorHelper()

enum DayInterval {
    case zeroToTwenty
    case twentyToFourty
    case fourtyToSixty
}


class StepCalculatorHelper {
    
    func getAverageStepsFor(dayInterval: DayInterval, healthStore: HKHealthStore?, completion: @escaping ([Double]) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        var rightBoundry: Date?
        var leftBoundry: Date?
        var predicate: NSPredicate?
        var query: HKStatisticsCollectionQuery?
        
        switch dayInterval {
        case .zeroToTwenty:
            rightBoundry = now
            leftBoundry = Calendar.current.date(byAdding: DateComponents(day: -60), to: now)!
            print(leftBoundry)
            predicate = HKQuery.predicateForSamples(withStart: leftBoundry, end: rightBoundry, options: .strictStartDate)
            query = HKStatisticsCollectionQuery.init(quantityType: stepsQuantityType,
                                                     quantitySamplePredicate: predicate,
                                                     options: .cumulativeSum,
                                                     anchorDate: leftBoundry!,
                                                     intervalComponents: DateComponents(day: 1))
        case .twentyToFourty:
            rightBoundry = Calendar.current.date(byAdding: DateComponents(day: -20), to: now)!
            leftBoundry = Calendar.current.date(byAdding: DateComponents(day: -40), to: now)!
            predicate = HKQuery.predicateForSamples(withStart: leftBoundry, end: rightBoundry, options: .strictStartDate)
            query = HKStatisticsCollectionQuery.init(quantityType: stepsQuantityType,
                                                     quantitySamplePredicate: predicate,
                                                     options: .cumulativeSum,
                                                     anchorDate: leftBoundry!,
                                                     intervalComponents: DateComponents(day: 1))
        case .fourtyToSixty:
            rightBoundry = Calendar.current.date(byAdding: DateComponents(day: -40), to: now)!
            leftBoundry = Calendar.current.date(byAdding: DateComponents(day: -60), to: now)!
            predicate = HKQuery.predicateForSamples(withStart: leftBoundry, end: rightBoundry, options: .strictStartDate)
            query = HKStatisticsCollectionQuery.init(quantityType: stepsQuantityType,
                                                     quantitySamplePredicate: predicate,
                                                     options: .cumulativeSum,
                                                     anchorDate: leftBoundry!,
                                                     intervalComponents: DateComponents(day: 1))
        }
        
        guard let executablQuery = query else { return }
        
        executablQuery.initialResultsHandler = { query, results, error in
            guard let statsCollection = results else {
                // Perform proper error handling here...
                fatalError()
            }
            var stepsTotal: [Double] = []
            statsCollection.enumerateStatistics(from: leftBoundry!, to: rightBoundry!) { statistics, stop in
                if let quantity = statistics.averageQuantity() {
                    print(quantity.doubleValue(for: HKUnit.count()))
                    let stepValue = quantity.doubleValue(for: HKUnit.count())
                    stepsTotal.append(stepValue)
                }
            }
            completion(stepsTotal)
        }
        
        healthStore?.execute(executablQuery)
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
