
import UIKit
import ResearchKit

class WithdrawViewController: ORKTaskViewController {
    // MARK: Initialization
    
    init() {
        let instructionStep = ORKInstructionStep(identifier: "WithdrawlInstruction")
        instructionStep.title = "Bist du sicher, dass du dich zurückziehen möchtest?"
        instructionStep.text = "Wenn du von der Studie zurücktrittst, wird die App auf den Zustand zurückgesetzt, indem du dich vor dem ursprünglichen Beitritt zur Studie befunden hast."
        
        let completionStep = ORKCompletionStep(identifier: "Withdraw")
        completionStep.title = "Danke für deine Zeit."
        completionStep.text = "Danke für deinen Beitrag zur Studie. Schade, dass du nicht fortfahren konntest/wolltest."
        
        let withdrawTask = ORKOrderedTask(identifier: "Withdraw", steps: [instructionStep, completionStep])
        
        super.init(task: withdrawTask, taskRun: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

