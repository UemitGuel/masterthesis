
import ResearchKit

public var ConsentTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    //WelcomeStep
    let instructionStep = ORKInstructionStep(identifier: "InstructionStepIdentifier")
    instructionStep.title = "Willkommen!"
    instructionStep.detailText = "Vielen Dank, dass Sie an unserer Studie teilnehmen. Im Folgenden werden ihnen die Einzelheiten der Studie erklärt. Falls es Fragen geben sollte, könnne Sie mir jederzeit eine Email schreiben."
    steps += [instructionStep]

    
    let informedConsentInstructionStep = ORKInstructionStep(identifier: "ConsentStepIdentifier")
    informedConsentInstructionStep.title = "Bevor es losgeht"

    let heartBodyItem = ORKBodyItem(text: "In dieser Studie werden Sie gebeten, einige Ihrer Gesundheitsdaten mitzuteilen",
                                    detailText: nil,
                                    image: UIImage(systemName: "heart.fill"),
                                    learnMoreItem: nil,
                                    bodyItemStyle: .image)
    
    let checkMarkItem = ORKBodyItem(text: "Es werden ihnen verschienden Frage zu ihrem psychischen Gesundheitszustand gestellt",
                                    detailText: nil,
                                    image: UIImage(systemName: "checkmark.circle.fill"),
                                    learnMoreItem: nil,
                                    bodyItemStyle: .image)
    
    let signatureItem = ORKBodyItem(text: "Bevor Sie beitreten, werden wir Sie bitten, eine Einverständniserklärung zu unterzeichnen.",
                                    detailText: nil,
                                    image: UIImage(systemName: "signature"),
                                    learnMoreItem: nil,
                                    bodyItemStyle: .image)
    
    let privacyItem = ORKBodyItem(text: "Ihre Daten werden nur auf deutschen Servern verarbeitet und unterliegen der DSGVO. Es werden keine persönlichen Daten erfasst oder verwertet.",
                                    detailText: nil,
                                    image: UIImage(systemName: "lock.fill"),
                                    learnMoreItem: nil,
                                    bodyItemStyle: .image)
    
    

    informedConsentInstructionStep.bodyItems = [heartBodyItem,checkMarkItem,signatureItem,privacyItem]
    steps += [informedConsentInstructionStep]
    
    var consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    let signature = consentDocument.signatures!.first as! ORKConsentSignature
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
    
    reviewConsentStep.text = "Zustimmung zur Teilnahme an der Studie"
    reviewConsentStep.reasonForConsent = "Zustimmung zur Teilnahme an der Studie"

    steps += [reviewConsentStep]
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
