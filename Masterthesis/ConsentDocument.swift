
import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Einverständniserklärung"
    
    let consentSectionTypes: [ORKConsentSectionType] = [
        .overview,
        .privacy,
        .dataUse,
        .timeCommitment,
        .studySurvey,
        .withdrawing
    ]
    
    let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        switch contentSectionType {
        case .overview:
            consentSection.title = "Worum geht es in der Studie?"
            consentSection.summary = "Unternehmen sind verpflichtet im Rahmen der betrieblichen Gefährdungsbeurteilung psychische Belastungen und Beanspruchungen ihrer Arbeitnehmer bei der Arbeit zu messen und sie vor mentalen Erkrankungen zu schützen. Studenten bekommen leider nicht den selben Schutz, obwohl auch sie eine gefährdete Gruppe darstellen. Diese Studie soll der Universität ein Werkzeug in die Hand geben um die psychischen Belastungen ihrer Studenten verstehen und messen zu können."
            consentSection.content = "Unternehmen sind verpflichtet im Rahmen der betrieblichen Gefährdungsbeurteilung psychische Belastungen und Beanspruchungen ihrer Arbeitnehmer bei der Arbeit zu messen und sie vor mentalen Erkrankungen zu schützen. Studenten bekommen leider nicht den selben Schutz, obwohl auch sie eine gefährdete Gruppe darstellen. Diese Studie soll der Universität ein Werkzeug in die Hand geben um die psychischen Belastungen ihrer Studenten verstehen und messen zu können."
        case .privacy:
            consentSection.title = "Datenschutz"
            consentSection.summary = "Deine Daten werden vollständig anonymisert und können nicht zurückgeführt werden. Es werden keinerlei persönliche Daten übergeben. Alle Daten werden auf deutschen Servern gesichert und unterliegen der DSGVO.\nDie gesamte Code-base ist Open Source, sodass jeder nachvollziehen kann was passiert."
            consentSection.content = "Die Daten werden ausschließlich auf deutschen Servern unter Einhaltung der DSGVO erstellt."
        case .dataUse:
            consentSection.title = "Datennutzung"
            consentSection.summary = "Die gesammelten Daten werden anonymisiert der Fakultät für Arbeitswissenschaften der RWTH Aachen übergeben."
            consentSection.content = "Die gesammelten Daten werden anonymisiert der Fakultät für Arbeitswissenschaften der RWTH Aachen übergeben."
        case .timeCommitment:
            consentSection.title = "Dauer"
            consentSection.summary = "Die Umfrage sollte nicht länger als 15-20 minuten dauern."
            consentSection.content = "Die Umfrage sollte nicht länger als 15-20 minuten dauern."
            
        case .studySurvey:
            consentSection.title = "Umfrage der Studie"
            consentSection.summary = "Es werden Ihnen nur Fragen gestellt. Es gibt keine Aufgaben die Sie bewältigen müssen. Sie können nach der Einführung unter dem Punkt ‘Account‘ mir jederzeit Fragen zur Studie zusenden."
            consentSection.content = "Es werden Ihnen nur Fragen gestellt. Es gibt keine Aufgaben die Sie bewältigen müssen. Sie können nach der Einführung unter dem Punkt ‘Account‘ mir jederzeit Fragen zur Studie zusenden."
            
        case .withdrawing:
            consentSection.title = "Rücktritt"
            consentSection.summary = "Sie können jederzeit aus der Studie zurücktreten, indem Sie unter dem Punkt ‘Account‘ die Löschung ihre Daten anfordern."
            consentSection.content = "Sie können jederzeit aus der Studie zurücktreten, indem Sie unter dem Punkt ‘Account‘ die Löschung ihre Daten anfordern."
        default:
            break
        }
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: "placeHolderTitle", dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}
