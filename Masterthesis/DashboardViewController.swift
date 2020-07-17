
import UIKit
import ResearchKit

class DashboardViewController: UIViewController, HealthClientType {

    var healthStore: HKHealthStore?
    
    @IBOutlet weak var discreteGraph: ORKDiscreteGraphChartView!
    
    let discreteGraphDataSource = DiscreteGraphDataSource()

    @IBOutlet weak var last30DaysLabel: UILabel!
    
    @IBOutlet weak var last30DaysDateLabel: UILabel!
    
    @IBOutlet weak var last60DaysLabel: UILabel!
    
    @IBOutlet weak var last60DaysDateLabel: UILabel!
    
    @IBOutlet weak var DifferenceLabel: UILabel!
    
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
        
        var first: Double = 0
        var second: Double = 0

        sharedStepCalculatorHelper.getAverageStepsFor(dayInterval: .zeroToThirty, healthStore: healthStore) { double in
            first = double
            DispatchQueue.main.async {
                self.last30DaysLabel.text = "\(Int(double)) Schritte"
                self.discreteGraphDataSource.plotPoints[0][1] = ORKValueRange(minimumValue: 0, maximumValue: double)
                self.discreteGraphDataSource.axisText[1] = "\(dateBefore60Days) - \(dateBefore30Days)"
                self.discreteGraph.dataSource = self.discreteGraphDataSource

            }
            sharedStepCalculatorHelper.getAverageStepsFor(dayInterval: .fourtyToSixty, healthStore: self.healthStore) { double in
                second = double
                DispatchQueue.main.async {
                self.last60DaysLabel.text = "\(Int(double)) Schritte"
                    self.discreteGraphDataSource.plotPoints[0][2] = ORKValueRange(minimumValue: 0, maximumValue: double)
                    self.discreteGraphDataSource.axisText[2] = "\n\(dateBefore30Days) - \(today)"
                    self.discreteGraph.dataSource = self.discreteGraphDataSource
                }
                let devision = (((second/first)-1)*100)
                if devision > 0 {
                    let string = "\(String(format: "%.1f", devision))%"
                    DispatchQueue.main.async {
                    self.DifferenceLabel.text = string
                    self.DifferenceLabel.textColor = .systemGreen
                    }
                }
            }
        }
    }
}
