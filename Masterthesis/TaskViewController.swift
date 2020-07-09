
import UIKit
import ResearchKit

class TaskViewController: UIViewController {
    
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
