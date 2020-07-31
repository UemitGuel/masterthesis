
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
    
    @IBOutlet weak var thankYouLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        if defaults.bool(forKey: "SurveyFinished") {
            disableSurveyButton()
        }

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
    
    func disableSurveyButton() {
        startStudyButton.isEnabled = false
        startStudyButton.alpha = 0.3
        
        thankYouLabel.isHidden = false
        thankYouLabel.text = "Danke für die Teilnahme!\nDu kannst du App jetzt entweder löschen oder dich weiter umschauen."
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
        let a14Answer = a14Result.scaleAnswer?.intValue
        
        let a15Result = a1FormResult.result(forIdentifier: "a15") as! ORKScaleQuestionResult
        let a15Answer = a15Result.scaleAnswer?.intValue
        
        let a16Result = a1FormResult.result(forIdentifier: "a16") as! ORKScaleQuestionResult
        let a16Answer = a16Result.scaleAnswer?.intValue
        
        FirebaseHelper.shared.saveDataA1(uuid: self.uuid, a11: a11Answer ?? "k.A.", a12: a12Answer ?? "k.A.", a13: a13Answer ?? "k.A.", a14: a14Answer ?? -1, a15: a15Answer ?? -1, a16: a16Answer ?? -1)
        
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
    
    //MARK: Handle B3 Results
    func handleB3FormResults(_ result: ORKTaskResult) {
        let b3FormResult = result.result(forIdentifier: "b3Form") as! ORKStepResult
        
        let b31 = getIntAnswer(identifier: "b31", formResult: b3FormResult)
        let b32 = getIntAnswer(identifier: "b32", formResult: b3FormResult)
        let b33 = getIntAnswer(identifier: "b33", formResult: b3FormResult)
        let b34 = getIntAnswer(identifier: "b34", formResult: b3FormResult)
        let b35 = getIntAnswer(identifier: "b35", formResult: b3FormResult)
        
        let averageB3FormResult = AverageCalculatorHelper.shared.getAverage([b31,b32,b33,b34,b35])
        
        FirebaseHelper.shared.saveDataB3(uuid: uuid, b31: b31, b32: b32, b33: b33, b34: b34, b35: b35, b3Average: averageB3FormResult )
    }
    
    //MARK: Handle B4 Results
    func handleB4FormResults(_ result: ORKTaskResult) {
        let b4FormResult = result.result(forIdentifier: "b4Form") as! ORKStepResult
        
        let b41 = getIntAnswer(identifier: "b41", formResult: b4FormResult)
        
        let averageB4FormResult = AverageCalculatorHelper.shared.getAverage([b41])
        
        FirebaseHelper.shared.saveDataB4(uuid: uuid, b41: b41, b4Average: averageB4FormResult )
    }
    
    //MARK: Handle B5 Results
    func handleB5FormResults(_ result: ORKTaskResult) {
        let b5FormResult = result.result(forIdentifier: "b5Form") as! ORKStepResult
        
        let b51 = getIntAnswer(identifier: "b51", formResult: b5FormResult)
        let b52 = getIntAnswer(identifier: "b52", formResult: b5FormResult)
        let b53 = getIntAnswer(identifier: "b53", formResult: b5FormResult)
        let b54 = getIntAnswer(identifier: "b54", formResult: b5FormResult)
        let b55 = getIntAnswer(identifier: "b55", formResult: b5FormResult)
        let b56 = getIntAnswer(identifier: "b56", formResult: b5FormResult)
        
        let averageB5FormResult = AverageCalculatorHelper.shared.getAverage([b51,b52,b53,b54,b55,b56])
        
        FirebaseHelper.shared.saveDataB5(uuid: uuid, b51: b51, b52: b52, b53: b53, b54: b54, b55: b55,  b56: b56, b5Average: averageB5FormResult )
    }
    
    //MARK: Handle B6 Results
    func handleB6FormResults(_ result: ORKTaskResult) {
        let b6FormResult = result.result(forIdentifier: "b6Form") as! ORKStepResult
        
        let b61 = getIntAnswer(identifier: "b61", formResult: b6FormResult)
        let b62 = getIntAnswer(identifier: "b62", formResult: b6FormResult)
        let b63 = getIntAnswer(identifier: "b63", formResult: b6FormResult)
        let b64 = getIntAnswer(identifier: "b64", formResult: b6FormResult)
        let b65 = getIntAnswer(identifier: "b65", formResult: b6FormResult)
        let b66 = getIntAnswer(identifier: "b66", formResult: b6FormResult)
        let b67 = getIntAnswer(identifier: "b67", formResult: b6FormResult)
        let b68 = getIntAnswer(identifier: "b68", formResult: b6FormResult)
        
        let averageB6FormResult = AverageCalculatorHelper.shared.getAverage([b61,b62,b63,b64,b65,b66,b67,b68])
        
        FirebaseHelper.shared.saveDataB6(uuid: uuid, b61: b61, b62: b62, b63: b63, b64: b64, b65: b65,  b66: b66, b67: b67, b68: b68, b6Average: averageB6FormResult )
    }
    
    //MARK: Handle B7 Results
    func handleB7FormResults(_ result: ORKTaskResult) {
        let b7FormResult = result.result(forIdentifier: "b7Form") as! ORKStepResult
        
        let b71 = getIntAnswer(identifier: "b71", formResult: b7FormResult)
        let b72 = getIntAnswer(identifier: "b72", formResult: b7FormResult)
        let b73 = getIntAnswer(identifier: "b73", formResult: b7FormResult)
        let b74 = getIntAnswer(identifier: "b74", formResult: b7FormResult)
        
        let averageB7FormResult = AverageCalculatorHelper.shared.getAverage([b71,b72,b73,b74])
        
        FirebaseHelper.shared.saveDataB7(uuid: uuid, b71: b71, b72: b72, b73: b73, b74: b74, b7Average: averageB7FormResult )
    }
    
    //MARK: Handle B8 Results
    func handleB8FormResults(_ result: ORKTaskResult) {
        let b8FormResult = result.result(forIdentifier: "b8Form") as! ORKStepResult
        
        let b81 = getIntAnswer(identifier: "b81", formResult: b8FormResult)
        let b82 = getIntAnswer(identifier: "b82", formResult: b8FormResult)
        let b83 = getIntAnswer(identifier: "b83", formResult: b8FormResult)
        let b84 = getIntAnswer(identifier: "b84", formResult: b8FormResult)
        let b85 = getIntAnswer(identifier: "b85", formResult: b8FormResult)
        let b86 = getIntAnswer(identifier: "b86", formResult: b8FormResult)
        let b87 = getIntAnswer(identifier: "b87", formResult: b8FormResult)
        let b88 = getIntAnswer(identifier: "b88", formResult: b8FormResult)
        let b89 = getIntAnswer(identifier: "b89", formResult: b8FormResult)
        
        let averageB8FormResult = AverageCalculatorHelper.shared.getAverage([b81,b82,b83,b84,b85,b86,b87,b88,b89])
        
        FirebaseHelper.shared.saveDataB8(uuid: uuid, b81: b81, b82: b82, b83: b83, b84: b84, b85: b85,  b86: b86, b87: b87, b88: b88, b89: b89, b8Average: averageB8FormResult )
    }
    
    //MARK: Handle B8a Results
    func handleB8aFormResults(_ result: ORKTaskResult) {
        let b8aFormResult = result.result(forIdentifier: "b8aForm") as! ORKStepResult
        
        let b81a = getIntAnswer(identifier: "b81a", formResult: b8aFormResult)
        let b82a = getIntAnswer(identifier: "b82a", formResult: b8aFormResult)
        let b83a = getIntAnswer(identifier: "b83a", formResult: b8aFormResult)
        let b84a = getIntAnswer(identifier: "b84a", formResult: b8aFormResult)
        
        let averageB8aFormResult = AverageCalculatorHelper.shared.getAverage([b81a,b82a,b83a,b84a])
        
        FirebaseHelper.shared.saveDataB8a(uuid: uuid, b81a: b81a, b82a: b82a, b83a: b83a, b84a: b84a, b8aAverage: averageB8aFormResult )
    }
    
    //MARK: Handle B8b Results
    func handleB8bFormResults(_ result: ORKTaskResult) {
        let b8bFormResult = result.result(forIdentifier: "b8bForm") as! ORKStepResult
        
        let b81b = getIntAnswer(identifier: "b81b", formResult: b8bFormResult)
        let b82b = getIntAnswer(identifier: "b82b", formResult: b8bFormResult)
        let b83b = getIntAnswer(identifier: "b83b", formResult: b8bFormResult)
        let b84b = getIntAnswer(identifier: "b84b", formResult: b8bFormResult)
        
        let averageB8bFormResult = AverageCalculatorHelper.shared.getAverage([b81b,b82b,b83b,b84b])
        
        FirebaseHelper.shared.saveDataB8b(uuid: uuid, b81b: b81b, b82b: b82b, b83b: b83b, b84b: b84b, b8bAverage: averageB8bFormResult )
    }
    
    //MARK: Handle B9 Results
    func handleB9FormResults(_ result: ORKTaskResult) {
        let b9FormResult = result.result(forIdentifier: "b9Form") as! ORKStepResult

        let b91 = getIntAnswer(identifier: "b91", formResult: b9FormResult)
        let b92 = getIntAnswer(identifier: "b92", formResult: b9FormResult)
        let b93 = getIntAnswer(identifier: "b93", formResult: b9FormResult)
        let b94 = getIntAnswer(identifier: "b94", formResult: b9FormResult)

        let averageB9FormResult = AverageCalculatorHelper.shared.getAverage([b91,b92,b93,b94])

        FirebaseHelper.shared.saveDataB9(uuid: uuid, b91: b91, b92: b92, b93: b93, b94: b94, b9Average: averageB9FormResult )
    }
    
    //MARK: Handle B10 Results
    func handleB10FormResults(_ result: ORKTaskResult) {
        let b10FormResult = result.result(forIdentifier: "b10Form") as! ORKStepResult
        
        let b101 = getIntAnswer(identifier: "b101", formResult: b10FormResult)
        let b102 = getIntAnswer(identifier: "b102", formResult: b10FormResult)
        
        let averageB10FormResult = AverageCalculatorHelper.shared.getAverage([b101,b102])
        
        FirebaseHelper.shared.saveDataB10(uuid: uuid, b101: b101, b102: b102, b10Average: averageB10FormResult )
    }
    
    //MARK: Handle B11 Results
    func handleB11FormResults(_ result: ORKTaskResult) {
        let b11FormResult = result.result(forIdentifier: "b11Form") as! ORKStepResult
        
        let b111 = getIntAnswer(identifier: "b111", formResult: b11FormResult)
        let b112 = getIntAnswer(identifier: "b112", formResult: b11FormResult)
        let b113 = getIntAnswer(identifier: "b113", formResult: b11FormResult)
        let b114 = getIntAnswer(identifier: "b114", formResult: b11FormResult)
        let b115 = getIntAnswer(identifier: "b115", formResult: b11FormResult)
        let b116 = getIntAnswer(identifier: "b116", formResult: b11FormResult)
        
        let averageB11FormResult = AverageCalculatorHelper.shared.getAverage([b111,b112,b113,b114,b115,b116])
        
        FirebaseHelper.shared.saveDataB11(uuid: uuid, b111: b111, b112: b112, b113: b113, b114: b114, b115: b115,  b116: b116, b11Average: averageB11FormResult )
    }
    
    //MARK: Handle A12 Results
    func handleB12FormResults(_ result: ORKTaskResult) {
        let b12FormResult = result.result(forIdentifier: "b12Form") as! ORKStepResult

        let b121Result = b12FormResult.result(forIdentifier: "b121") as! ORKScaleQuestionResult
        let b121 = b121Result.scaleAnswer?.intValue
                
        FirebaseHelper.shared.saveDataB12(uuid: uuid, b121: b121 ?? -1)
        
    }
    
    //MARK: Handle B13 Results
    func handleB13FormResults(_ result: ORKTaskResult) {
        let b13FormResult = result.result(forIdentifier: "b13Form") as! ORKStepResult
        
        let b131 = getIntAnswer(identifier: "b131", formResult: b13FormResult)
        let b132 = getIntAnswer(identifier: "b132", formResult: b13FormResult)
        let b133 = getIntAnswer(identifier: "b133", formResult: b13FormResult)
        let b134 = getIntAnswer(identifier: "b134", formResult: b13FormResult)
        let b135 = getIntAnswer(identifier: "b135", formResult: b13FormResult)
        
        let averageB13FormResult = AverageCalculatorHelper.shared.getAverage([b131,b132,b133,b134,b135])
        
        FirebaseHelper.shared.saveDataB13(uuid: uuid, b131: b131, b132: b132, b133: b133, b134: b134, b135: b135, b13Average: averageB13FormResult )
    }
    
    //MARK: Handle B14 Results
    func handleB14FormResults(_ result: ORKTaskResult) {
        let b14FormResult = result.result(forIdentifier: "b14Form") as! ORKStepResult
        
        let b141 = getIntAnswer(identifier: "b141", formResult: b14FormResult)
        let b142 = getIntAnswer(identifier: "b142", formResult: b14FormResult)
        let b143 = getIntAnswer(identifier: "b143", formResult: b14FormResult)
        
        let averageB14FormResult = AverageCalculatorHelper.shared.getAverage([b141,b142,b143])
        
        FirebaseHelper.shared.saveDataB14(uuid: uuid, b141: b141, b142: b142, b143: b143, b14Average: averageB14FormResult )
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
            handleB3FormResults(taskViewController.result)
            handleB4FormResults(taskViewController.result)
            handleB5FormResults(taskViewController.result)
            handleB6FormResults(taskViewController.result)
            handleB7FormResults(taskViewController.result)
            handleB8FormResults(taskViewController.result)
            handleB8aFormResults(taskViewController.result)
            handleB8bFormResults(taskViewController.result)
            handleB9FormResults(taskViewController.result)
            handleB10FormResults(taskViewController.result)
            handleB11FormResults(taskViewController.result)
            handleB12FormResults(taskViewController.result)
            handleB13FormResults(taskViewController.result)
            handleB14FormResults(taskViewController.result)
            defaults.set(true, forKey: "SurveyFinished")
            disableSurveyButton()
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
