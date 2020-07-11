
import UIKit
import ResearchKit

let defaults = UserDefaults.standard

class ResearchContainerViewController: UIViewController, HealthClientType {
    // MARK: HealthClientType
    
    var healthStore: HKHealthStore?
    
    // MARK: Propertues
        
    var contentHidden = false {
        didSet {
            guard contentHidden != oldValue && isViewLoaded else { return }
            children.first?.view.isHidden = contentHidden
        }
    }
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.bool(forKey: "joinedStudy") == true {
            toStudy()
        } else {
            toOnboarding()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let healthStore = healthStore {
            segue.destination.injectHealthStore(healthStore)
        }
    }
    
    // MARK: Unwind segues
    
    @IBAction func unwindToStudy(_ segue: UIStoryboardSegue) {
        toStudy()
    }
    
    @IBAction func unwindToWithdrawl(_ segue: UIStoryboardSegue) {
        toWithdrawl()
    }
    
    // MARK: Transitions
    
    func toOnboarding() {
        performSegue(withIdentifier: "toOnboarding", sender: self)
    }
    
    func toStudy() {
        performSegue(withIdentifier: "toStudy", sender: self)
    }
    
    func toWithdrawl() {
        let viewController = WithdrawViewController()
        viewController.delegate = self
        
        present(viewController, animated: true, completion: nil)
    }
}


extension ResearchContainerViewController: ORKTaskViewControllerDelegate {

    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Check if the user has finished the `WithdrawViewController`.
        if taskViewController is WithdrawViewController {
            /*
                If the user has completed the withdrawl steps, remove them from
                the study and transition to the onboarding view.
            */
            if reason == .completed {
                defaults.set(false, forKey: "joinedStudy")
                toOnboarding()
            }
            
            // Dismiss the `WithdrawViewController`.
            dismiss(animated: true, completion: nil)
        }
    }
}
