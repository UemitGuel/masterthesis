
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        // Request authrization to query the health objects that need to be shown.
        guard let healthStore = healthStore else { fatalError("healhStore not set") }
        let typesToRequest = Set<HKObjectType>(healthObjectTypes)
        healthStore.requestAuthorization(toShare: nil, read: typesToRequest) { (authorized, _) in
            guard authorized else { return }
        }
    }
        
    func configureButton() {
        startStudyButton.layer.cornerRadius = 10
    }
    
    func handlea1FormResults(_ result: ORKTaskResult) {
        let a1FormResult = result.result(forIdentifier: "a1Form") as! ORKStepResult
        let a11Result = a1FormResult.result(forIdentifier: "a11") as! ORKQuestionResult
        let a11Answer = a11Result.answer
        
        let a12Result = a1FormResult.result(forIdentifier: "a12") as! ORKQuestionResult
        let a12Answer = a12Result.answer
        
        let a13Result = a1FormResult.result(forIdentifier: "a13") as! ORKQuestionResult
        let a13Answer = a13Result.answer
        
        let a14Result = a1FormResult.result(forIdentifier: "a14") as! ORKQuestionResult
        let a14Answer = a14Result.answer
        
        let a15Result = a1FormResult.result(forIdentifier: "a15") as! ORKQuestionResult
        let a15Answer = a15Result.answer
        print(a11Answer)
        print(a12Answer)
        print(a13Answer)
        print(a14Answer)
        print(a15Answer)

    }
    
}

extension TaskViewController: ORKTaskViewControllerDelegate{
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            handlea1FormResults(taskViewController.result)
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
