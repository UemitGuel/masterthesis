
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
        
        let last30 = defaults.integer(forKey: StepsEnum.stepsLast30days.rawValue)
        last30DaysLabel.text = "\(last30) Schritte"
        
        let last60to30 = defaults.integer(forKey: StepsEnum.stepsLast60to30days.rawValue)
        last60DaysLabel.text = "\(last60to30) Schritte"
        
        let changeInPercentage = defaults.double(forKey: StepsEnum.changeInPercentage.rawValue)
        if changeInPercentage.isNaN {
            differenceLabel.text = "-"
        } else {
            differenceLabel.text = "\(changeInPercentage)%"
        }
        if changeInPercentage < 0 {
            differenceLabel.textColor = .systemRed
        } else {
            differenceLabel.textColor = .systemGreen
        }
    }
}
