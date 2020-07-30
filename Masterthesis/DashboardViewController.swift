
import UIKit
import ResearchKit

class DashboardViewController: UIViewController, HealthClientType {
    
    var healthStore: HKHealthStore?
    
    @IBOutlet weak var last30DaysLabel: UILabel!
    
    @IBOutlet weak var last30DaysDateLabel: UILabel!
    
    @IBOutlet weak var last60DaysLabel: UILabel!
    
    @IBOutlet weak var last60DaysDateLabel: UILabel!
    
    @IBOutlet weak var differenceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateLabels()
        
        // Do any additional setup after loading the view.
    }
    
    func populateLabels() {
        let today = sharedStepCalculatorHelper.getTodayFormatted()
        let dateBefore30Days = sharedStepCalculatorHelper.getBefore30DaysFormatted()
        last30DaysDateLabel.text = "von \(dateBefore30Days) bis \(today)"
        let dateBefore60Days = sharedStepCalculatorHelper.getBefore60DaysFormatted()
        last60DaysDateLabel.text = "von \(dateBefore60Days) bis \(dateBefore30Days)"
        
        if let last30 = sharedModel.stepsLast30days {
            last30DaysLabel.text = "\((last30*100).rounded()/100) Schritte"
        }
        
        if let last60to30 = sharedModel.stepsLast60to30days {
            last60DaysLabel.text = "\((last60to30*100).rounded()/100) Schritte"
        }
        
        if let changeInPercentage = sharedModel.changeInPercentage {
            differenceLabel.text = "\((changeInPercentage*100).rounded()/100)%"
        }
    }
}
