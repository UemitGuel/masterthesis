
import UIKit
import ResearchKit
import HealthKit

class TaskViewController: UIViewController, HealthClientType {
    
    let defaults = UserDefaults.standard
    
    var uuid: String = "Example 1"
//        if let currentDeviceID = UIDevice.current.identifierForVendor?.uuidString {
//            return currentDeviceID
//        } else {
//            return "no device ID"
//        }
//    }
    
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
                
                FirebaseHelper.shared.saveSteps(uuid: self.uuid, stepsLast30DaysAverage: stepsLast30daysInt, stepsLast60to30DaysAverage: stepsLast60to30daysInt, changeInPercentage: changeInPercentageRounded)
                self.defaults.set(true, forKey: "stepDataSaved")
            }
        }
    }
    
    func getChangeInPercentage(stepsLast30days: Double, stepsLast60to30days: Double) -> Double {
        let devision: Double = (((stepsLast60to30days/stepsLast30days)-1)*100)
        return devision
    }
    
    //Helper methods for Handler functions
    
    func getIntAnswer(identifier: String, formResult: ORKStepResult) -> Int {
        let result = formResult.result(forIdentifier: identifier) as! ORKChoiceQuestionResult
        return result.choiceAnswers?.first as? Int ?? -1
    }
    
    //MARK: Handle A1 Results
    func handleA1FormResults(_ result: ORKTaskResult) {
        let a1FormResult = result.result(forIdentifier: "a1Form") as! ORKStepResult
        let a11Result = a1FormResult.result(forIdentifier: "a11") as! ORKChoiceQuestionResult
        let a11Answer = a11Result.choiceAnswers?.first as? String
        
        let a12Result = a1FormResult.result(forIdentifier: "a12") as! ORKChoiceQuestionResult
        let a12Answer = a12Result.choiceAnswers?.first as? String
        
        let a13Result = a1FormResult.result(forIdentifier: "a13") as! ORKChoiceQuestionResult
        let a13Answer = a13Result.choiceAnswers?.first as? String
        
        let a14Result = a1FormResult.result(forIdentifier: "a14") as! ORKScaleQuestionResult
        let a14Answer = a14Result.scaleAnswer?.stringValue
        
        let a15Result = a1FormResult.result(forIdentifier: "a15") as! ORKScaleQuestionResult
        let a15Answer = a15Result.scaleAnswer?.stringValue
        
        let a16Result = a1FormResult.result(forIdentifier: "a16") as! ORKScaleQuestionResult
        let a16Answer = a16Result.scaleAnswer?.stringValue
        
        FirebaseHelper.shared.saveDataA1(uuid: self.uuid, a11: a11Answer ?? "k.A.", a12: a12Answer ?? "k.A.", a13: a13Answer ?? "k.A.", a14: a14Answer ?? "k.A.", a15: a15Answer ?? "k.A.", a16: a16Answer ?? "k.A.")
        
    }
    
    //MARK: Handle B1 Results
    func handleB1FormResults(_ result: ORKTaskResult) {
        let b1FormResult = result.result(forIdentifier: "b1Form") as! ORKStepResult
        
        let b11 = getIntAnswer(identifier: "b11", formResult: b1FormResult)
        let b12 = getIntAnswer(identifier: "b12", formResult: b1FormResult)
        let b13 = getIntAnswer(identifier: "b13", formResult: b1FormResult)
        let b14 = getIntAnswer(identifier: "b14", formResult: b1FormResult)
        let b15 = getIntAnswer(identifier: "b15", formResult: b1FormResult)
        let b16 = getIntAnswer(identifier: "b16", formResult: b1FormResult)
        
        let averageB1FormResult = AverageCalculatorHelper.shared.getAverage([b11,b12,b13,b14,b15,b16])
        
        FirebaseHelper.shared.saveDataB1(uuid: uuid, b11: b11, b12: b12, b13: b13, b14: b14, b15: b15, b16: b16, b1Average: averageB1FormResult )
    }
    
    //MARK: Handle B1 Results
    func handleB1_2FormResults(_ result: ORKTaskResult) {
        let b1_2FormResult = result.result(forIdentifier: "b1_2Form") as! ORKStepResult
        
        let b11_2 = getIntAnswer(identifier: "b11_2", formResult: b1_2FormResult)
        let b12_2 = getIntAnswer(identifier: "b12_2", formResult: b1_2FormResult)
        let b13_2 = getIntAnswer(identifier: "b13_2", formResult: b1_2FormResult)
        
        let averageB1_2FormResult = AverageCalculatorHelper.shared.getAverage([b11_2,b12_2,b13_2])
        
        FirebaseHelper.shared.saveDataB1_2(uuid: uuid, b11_2: b11_2, b12_2: b12_2 , b13_2: b13_2, b1_2Average: averageB1_2FormResult)
    }
    
    //MARK: Handle B2 Results
    func handleB2FormResults(_ result: ORKTaskResult) {
        let b2FormResult = result.result(forIdentifier: "b2Form") as! ORKStepResult

        let b21 = getIntAnswer(identifier: "b21", formResult: b2FormResult)
        let b22 = getIntAnswer(identifier: "b22", formResult: b2FormResult)
        let b23 = getIntAnswer(identifier: "b23", formResult: b2FormResult)
        let b24 = getIntAnswer(identifier: "b24", formResult: b2FormResult)
        let b25 = getIntAnswer(identifier: "b25", formResult: b2FormResult)
        
        let averageB2FormResult = AverageCalculatorHelper.shared.getAverage([b21,b22,b23,b24,b25])
        
        FirebaseHelper.shared.saveDataB2(uuid: uuid, b21: b21, b22: b22, b23: b23, b24: b24, b25: b25, b2Average: averageB2FormResult)
    }
}

extension TaskViewController: ORKTaskViewControllerDelegate{
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            handleA1FormResults(taskViewController.result)
            handleB1FormResults(taskViewController.result)
            handleB1_2FormResults(taskViewController.result)
            handleB2FormResults(taskViewController.result)
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
