
import ResearchKit
import HealthKit

class HealthDataStep: ORKInstructionStep {
    // MARK: Properties
    
    let healthDataItemsToRead: Set<HKObjectType> = [
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
    ]
    
    // MARK: Initialization
    
    override init(identifier: String) {
        super.init(identifier: identifier)
        
        title = "Schrittzähler - Warum brauche ich den Zugang?"
        text = "Auf dem nächsten Bildschirm wirst du aufgefordert mir den Zugang zu deinem Schrittzähler zu gewähren. Der essentielle Punkt meiner Masterarbeit ist, zu zeigen das digitale Umfrage-Methoden unbekannte Korrelationen aufzeigen könnten. Dafür möchte ich deine pysische Gesundheit, die durch den Fragebogen erfragt werden soll,"
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Convenience
    
    func getHealthAuthorization(_ completion: @escaping (_ success: Bool, _ error: NSError?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            let error = NSError(domain: "com.example.apple-samplecode.ORKSample", code: 2, userInfo: [NSLocalizedDescriptionKey: "Health data is not available on this device."])
            
            completion(false, error)
            
            return
        }
        
        // Get authorization to access the data
        HKHealthStore().requestAuthorization(toShare: nil, read: healthDataItemsToRead) { (success, error) -> Void in
            completion(success, error as NSError?)
        }
    }
}
