
import UIKit
import ResearchKit
import HealthKit

class TaskViewController: UIViewController, HealthClientType {
    
    let defaults = UserDefaults.standard
    
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
        if defaults.bool(forKey: "stepDataSaved") == false {
            self.fillViewModelWithStepsData()
        }
        
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
    
    func fillViewModelWithStepsData() {
        sharedStepCalculatorHelper.getAverageStepsFor(dayInterval: .zeroToThirty, healthStore: healthStore) { double in
            sharedModel.stepsLast30days = double
            sharedStepCalculatorHelper.getAverageStepsFor(dayInterval: .fourtyToSixty, healthStore: self.healthStore) { double in
                sharedModel.stepsLast60to30days = double
                sharedFirebaseHelper.saveSteps(uuid: sharedModel.uuid, stepsLast30DaysAverage: sharedModel.stepsLast30days ?? -1, stepsLast60to30DaysAverage: sharedModel.stepsLast60to30days ?? -1, changeInPercentage: sharedModel.changeInPercentage ?? -1)
                self.defaults.set(true, forKey: "stepDataSaved")
            }
        }
    }
    
    func handleA1FormResults(_ result: ORKTaskResult) {
        let a1FormResult = result.result(forIdentifier: "a1Form") as! ORKStepResult
        let a11Result = a1FormResult.result(forIdentifier: "a11") as! ORKChoiceQuestionResult
        sharedModel.a11Answer = a11Result.choiceAnswers?.first as? String
        
        let a12Result = a1FormResult.result(forIdentifier: "a12") as! ORKChoiceQuestionResult
        sharedModel.a12Answer = a12Result.choiceAnswers?.first as? String
        
        let a13Result = a1FormResult.result(forIdentifier: "a13") as! ORKScaleQuestionResult
        sharedModel.a13Answer = a13Result.scaleAnswer?.stringValue
        
        let a14Result = a1FormResult.result(forIdentifier: "a14") as! ORKScaleQuestionResult
        sharedModel.a14Answer = a14Result.scaleAnswer?.stringValue
        
        let a15Result = a1FormResult.result(forIdentifier: "a15") as! ORKScaleQuestionResult
        sharedModel.a15Answer = a15Result.scaleAnswer?.stringValue
        
        sharedFirebaseHelper.saveDataA1(uuid: sharedModel.uuid, a11: sharedModel.a11Answer ?? "k.A.", a12: sharedModel.a12Answer ?? "k.A.", a13: sharedModel.a13Answer ?? "k.A.", a14: sharedModel.a14Answer ?? "k.A.", a15: sharedModel.a15Answer ?? "k.A.")
        
    }
    
    func handleB1FormResults(_ result: ORKTaskResult) {
        let b1FormResult = result.result(forIdentifier: "b1Form") as! ORKStepResult
        let b11Result = b1FormResult.result(forIdentifier: "b11") as! ORKChoiceQuestionResult
        sharedModel.b11Answer = b11Result.choiceAnswers?.first as? Int
        
        let b12Result = b1FormResult.result(forIdentifier: "b12") as! ORKChoiceQuestionResult
        sharedModel.b12Answer = b12Result.choiceAnswers?.first as? Int
        
        let b13Result = b1FormResult.result(forIdentifier: "b13") as! ORKChoiceQuestionResult
        sharedModel.b13Answer = b13Result.choiceAnswers?.first as? Int
        
        let b14Result = b1FormResult.result(forIdentifier: "b14") as! ORKChoiceQuestionResult
        sharedModel.b14Answer = b14Result.choiceAnswers?.first as? Int
        
        let b15Result = b1FormResult.result(forIdentifier: "b15") as! ORKChoiceQuestionResult
        sharedModel.b15Answer = b15Result.choiceAnswers?.first as? Int
        
        let b16Result = b1FormResult.result(forIdentifier: "b16") as! ORKChoiceQuestionResult
        sharedModel.b16Answer = b16Result.choiceAnswers?.first as? Int
        
        sharedFirebaseHelper.saveDataB1(uuid: sharedModel.uuid, b11: sharedModel.b11Answer ?? -1, b12: sharedModel.b12Answer ?? -1, b13: sharedModel.b13Answer ?? -1, b14: sharedModel.b14Answer ?? -1, b15: sharedModel.b15Answer ?? -1, b16: sharedModel.b16Answer ?? -1, b1Average: sharedModel.averageB1FormResult ?? -1)
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
