
import UIKit
import ResearchKit

class WithdrawViewController: ORKTaskViewController {
    // MARK: Initialization
    
    init() {
        let instructionStep = ORKInstructionStep(identifier: "WithdrawlInstruction")
        instructionStep.title = "Are you sure you want to withdraw?"
        instructionStep.text = "Withdrawing from the study will reset the app to the state it was in prior to you originally joining the study."
        
        let completionStep = ORKCompletionStep(identifier: "Withdraw")
        completionStep.title = "We appreciate your time."
        completionStep.text = "Thank you for your contribution to this study. We are sorry that you could not continue."
        
        let withdrawTask = ORKOrderedTask(identifier: "Withdraw", steps: [instructionStep, completionStep])
        
        super.init(task: withdrawTask, taskRun: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

