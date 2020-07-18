
import HealthKit

let sharedStepCalculatorHelper = StepCalculatorHelper()

enum TimeIntervalCustom {
    case zeroToThirty
    case fourtyToSixty
}


class StepCalculatorHelper {
    
    let sharedDateFormatter = DateFormatter()
    
    init() {
        sharedDateFormatter.dateStyle = .short
        sharedDateFormatter.timeStyle = .none
    }
    
    func getAverageStepsFor(dayInterval: TimeIntervalCustom, healthStore: HKHealthStore?, completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        var rightBoundry: Date?
        var leftBoundry: Date?
        var predicate: NSPredicate?
        var query: HKStatisticsCollectionQuery?
        
        switch dayInterval {
        case .zeroToThirty:
            rightBoundry = now
            leftBoundry = Calendar.current.date(byAdding: DateComponents(day: -30), to: now)!
            predicate = HKQuery.predicateForSamples(withStart: leftBoundry, end: rightBoundry, options: .strictStartDate)
            query = HKStatisticsCollectionQuery.init(quantityType: stepsQuantityType,
                                                     quantitySamplePredicate: predicate,
                                                     options: .cumulativeSum,
                                                     anchorDate: leftBoundry!,
                                                     intervalComponents: DateComponents(day: 1))
        case .fourtyToSixty:
            rightBoundry = Calendar.current.date(byAdding: DateComponents(day: -30), to: now)!
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
            var stepsTotal: Double = 0
            statsCollection.enumerateStatistics(from: leftBoundry!, to: rightBoundry!) { statistics, stop in
                if let quantity = statistics.sumQuantity() {
                    let stepValue = quantity.doubleValue(for: HKUnit.count())
                    stepsTotal += stepValue
                }
            }
            completion(stepsTotal/30)
        }
        
        healthStore?.execute(executablQuery)
    }
    
    func getTodayFormatted() -> String {
        let today = Date()
        let todayFormatted = sharedDateFormatter.string(from: today)
        return todayFormatted
    }
    
    func getBefore30DaysFormatted() -> String {
        let today = Date()
        let before30Days = Calendar.current.date(byAdding: DateComponents(day: -30), to: today)!
        let before30DaysFormatted = sharedDateFormatter.string(from: before30Days)
        return before30DaysFormatted
    }
    
    func getBefore60DaysFormatted() -> String {
        let today = Date()
        let before60Days = Calendar.current.date(byAdding: DateComponents(day: -60), to: today)!
        let before60DaysFormatted = sharedDateFormatter.string(from: before60Days)
        return before60DaysFormatted
    }
}
