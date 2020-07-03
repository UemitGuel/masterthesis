
import ResearchKit

public var ConsentTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    //WelcomeStep
    let instructionStep = ORKInstructionStep(identifier: "InstructionStepIdentifier")
    instructionStep.title = "Welcome!"
    instructionStep.detailText = "Thank you for joining our study. Tap Next to learn more before signing up."
    instructionStep.image =  UIImage(named: "first")!
    steps += [instructionStep]

    
    let informedConsentInstructionStep = ORKInstructionStep(identifier: "ConsentStepIdentifier")
    informedConsentInstructionStep.title = "Before You Join"
    informedConsentInstructionStep.image = UIImage(named: "thesis")!

    let heartBodyItem = ORKBodyItem(text: "exampleText",
                                    detailText: nil,
                                    image: UIImage(systemName: "heart.fill"),
                                    learnMoreItem: nil,
                                    bodyItemStyle: .image)

    informedConsentInstructionStep.bodyItems = [heartBodyItem]
    steps += [informedConsentInstructionStep]
    
    var consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    let signature = consentDocument.signatures!.first as! ORKConsentSignature
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
    
    reviewConsentStep.text = "Zustimmung"
    reviewConsentStep.reasonForConsent = "Zustimmung zur Teilnahme an der Studie"

    steps += [reviewConsentStep]
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
