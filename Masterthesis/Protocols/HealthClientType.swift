
import UIKit
import HealthKit

protocol HealthClientType {
    var healthStore: HKHealthStore? { get set }
}

extension UIViewController {
    
    func injectHealthStore(_ healthStore: HKHealthStore) {
        if var client = self as? HealthClientType {
            client.healthStore = healthStore
        }
        
        for childViewController in children {
            childViewController.injectHealthStore(healthStore)
        }
    }
}
