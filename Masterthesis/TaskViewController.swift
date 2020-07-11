
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
            print(typesToRequest)
            guard authorized else { return }
        }
        updateSteps { double in
            print(double)
        }

    }
    
    func updateSteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var resultCount = 0.0

            guard let result = result else {
                print("\(String(describing: error?.localizedDescription)) ")
                completion(resultCount)
                return
            }

            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.count())
            }

            DispatchQueue.main.async {
                completion(resultCount)
            }
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
