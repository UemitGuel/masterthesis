
import UIKit
import ResearchKit
import HealthKit

class TaskViewController: UIViewController, HealthClientType {
    
    let healthObjectTypes = [
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
    ]
    
    var healthStore: HKHealthStore?
    
    @IBOutlet weak var startStudyButton: UIButton!
    
    @IBAction func startStudyButtonTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    var task: ORKTask?
    var result: ORKTaskResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        // Request authrization to query the health objects that need to be shown.
        guard let healthStore = healthStore else { fatalError("healhStore not set") }
        let typesToRequest = Set<HKObjectType>(healthObjectTypes)
        healthStore.requestAuthorization(toShare: nil, read: typesToRequest) { (authorized, _) in
            guard authorized else { return }
        }
        getAverageStepsLast30Days { double in
            print("30\(double)")
        }
        getAverageSteps60Days { double in
            print("60\(double)")
        }
        getAverageSteps90Days { double in
            print("90\(double)")
        }
    }
    
    func getAverageStepsLast30Days(completion: @escaping (Double) -> Void) {
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
        
        healthStore?.execute(query)
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
        
        healthStore?.execute(query)
    }
    
    func configureButton() {
        startStudyButton.layer.cornerRadius = 10
    }
}

extension TaskViewController: ORKTaskViewControllerDelegate{
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            self.task = taskViewController.task
            self.result = taskViewController.result
            let taskResult = taskViewController.result.result(forIdentifier: "BooleanQuestionStep") as! ORKStepResult
            let firstResult = taskResult.firstResult as! ORKBooleanQuestionResult
            print(firstResult.booleanAnswer)
            taskViewController.dismiss(animated: true)
            break
        case .discarded:
            taskViewController.dismiss(animated: true)
            break
        case .failed:
        break // Do not advance here, as Reaction Time task reports a failed result from its instructions.
        case .saved:
            break
        @unknown default:
            break
        }
        
    }
}
