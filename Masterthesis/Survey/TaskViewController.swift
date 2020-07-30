
import UIKit
import ResearchKit
import HealthKit

class TaskViewController: UIViewController, HealthClientType {
    
    let defaults = UserDefaults.standard
    
    var uuid: String {
        if let currentDeviceID = UIDevice.current.identifierForVendor?.uuidString {
            return currentDeviceID
        } else {
            return "no device ID"
        }
    }
    
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
            let stepsLast30daysDouble = double
            let stepsLast30daysInt = Int(double)
            self.defaults.set(stepsLast30daysInt, forKey: StepsEnum.stepsLast30days.rawValue)
            sharedStepCalculatorHelper.getAverageStepsFor(dayInterval: .fourtyToSixty, healthStore: self.healthStore) { double in
                let stepsLast60to30daysDouble = double
                let stepsLast60to30daysInt = Int(double)
                self.defaults.set(stepsLast60to30daysInt, forKey: StepsEnum.stepsLast60to30days.rawValue)
                let changeInPercentage = (((stepsLast30daysDouble/stepsLast60to30daysDouble)-1)*100)
                let changeInPercentageRounded = ((changeInPercentage*100).rounded()/100)
                print(changeInPercentageRounded)
                self.defaults.set(changeInPercentageRounded, forKey: StepsEnum.changeInPercentage.rawValue)
                
                sharedFirebaseHelper.saveSteps(uuid: self.uuid, stepsLast30DaysAverage: stepsLast30daysInt, stepsLast60to30DaysAverage: stepsLast60to30daysInt, changeInPercentage: changeInPercentageRounded)
                self.defaults.set(true, forKey: "stepDataSaved")
            }
        }
    }
    
    func getChangeInPercentage(stepsLast30days: Double, stepsLast60to30days: Double) -> Double {
        let devision: Double = (((stepsLast60to30days/stepsLast30days)-1)*100)
        return devision
    }
    
    //MARK: Handle A1 Results
    func handleA1FormResults(_ result: ORKTaskResult) {
        let a1FormResult = result.result(forIdentifier: "a1Form") as! ORKStepResult
        let a11Result = a1FormResult.result(forIdentifier: "a11") as! ORKChoiceQuestionResult
        let a11Answer = a11Result.choiceAnswers?.first as? String
        
        let a12Result = a1FormResult.result(forIdentifier: "a12") as! ORKChoiceQuestionResult
        let a12Answer = a12Result.choiceAnswers?.first as? String
        
        let a13Result = a1FormResult.result(forIdentifier: "a13") as! ORKScaleQuestionResult
        let a13Answer = a13Result.scaleAnswer?.stringValue
        
        let a14Result = a1FormResult.result(forIdentifier: "a14") as! ORKScaleQuestionResult
        let a14Answer = a14Result.scaleAnswer?.stringValue
        
        let a15Result = a1FormResult.result(forIdentifier: "a15") as! ORKScaleQuestionResult
        let a15Answer = a15Result.scaleAnswer?.stringValue
        
        sharedFirebaseHelper.saveDataA1(uuid: self.uuid, a11: a11Answer ?? "k.A.", a12: a12Answer ?? "k.A.", a13: a13Answer ?? "k.A.", a14: a14Answer ?? "k.A.", a15: a15Answer ?? "k.A.")
        
    }
    
    //MARK: Handle B1 Results
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
        
        let averageB1FormResult = AverageCalculatorHelper.shared.getAverage([b11Answer,b12Answer,b13Answer,b14Answer,b15Answer,b16Answer])
        
        sharedFirebaseHelper.saveDataB1(uuid: uuid, b11: b11Answer ?? -1, b12: b12Answer ?? -1, b13: b13Answer ?? -1, b14: b14Answer ?? -1, b15: b15Answer ?? -1, b16: b16Answer ?? -1, b1Average: averageB1FormResult )
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