
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
    
    func handleA1FormResults(_ result: ORKTaskResult) {
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
//        print(a11Answer)
//        print(a12Answer)
//        print(a13Answer)
//        print(a14Answer)
//        print(a15Answer)
    }
    
        func handleB1FormResults(_ result: ORKTaskResult) {
            let b1FormResult = result.result(forIdentifier: "b1Form") as! ORKStepResult
            let b11Result = b1FormResult.result(forIdentifier: "b11") as! ORKChoiceQuestionResult
            let b11Answer = b11Result.choiceAnswers?.first as? Int
            
            let b12Result = b1FormResult.result(forIdentifier: "b12") as! ORKChoiceQuestionResult
            let b12Answer = b12Result.choiceAnswers?.first as? Int
            
            let b13Result = b1FormResult.result(forIdentifier: "b13") as! ORKChoiceQuestionResult
            let b13Answer = b13Result.choiceAnswers?.first as? Int
            
            let b14Result = b1FormResult.result(forIdentifier: "b14") as! ORKChoiceQuestionResult
            let b14Answer = b14Result.choiceAnswers?.first as? Int
            
            let b15Result = b1FormResult.result(forIdentifier: "b15") as! ORKChoiceQuestionResult
            let b15Answer = b15Result.choiceAnswers?.first as? Int
            
            let b16Result = b1FormResult.result(forIdentifier: "b16") as! ORKChoiceQuestionResult
            let b16Answer = b16Result.choiceAnswers?.first as? Int
            
            let answerArray = [b11Answer,b12Answer,b13Answer,b14Answer,b15Answer,b16Answer].compactMap { $0 }
            
            let averageB1FormResult = sharedAverageCalculatorHelper.getAverage(arrayOfInt: answerArray)
            print(averageB1FormResult)
            
        }
    
}

extension TaskViewController: ORKTaskViewControllerDelegate{
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            handleA1FormResults(taskViewController.result)
            handleB1FormResults(taskViewController.result)
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
