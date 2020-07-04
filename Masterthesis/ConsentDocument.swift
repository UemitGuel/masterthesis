
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
            consentSection.summary = "Unternehmen sind verpflichtet psychische Gesundheitsevaluierung durchzuführen um ihre Arbeitnehmer vor mentalen Erkrankungen zu schützen.\nStudenten sind per Definition keine Arbeitnehmer und bekommen dadurch nicht den selben Schutz, obwohl auch Studenten eine gefährdete Gruppe für diese Art der pysischen Überbelastung darstellen.\nDiese Studie soll der Universität ein Werkzeug in die Hand geben um die psychische Belastung ihrer Studenten zu verstehen und messen zu können."
            consentSection.content = "Unternehmen sind verpflichtet psychische Gesundheitsevaluierung durchzuführen um ihre Arbeitnehmer vor mentalen Erkrankungen zu schützen. Studenten sind laut Gesetzbuch keine Arbeitnehmer und bekommen dadurch nicht den selben Schutz, obwohl auch Studenten eine gefährdete Gruppe für diese Art der pysischen Überbelastung darstellen.\nDiese Studie soll der Universität ein Werkzeug in die Hand geben um die psychische Belastung ihrer Studenten zu verstehen und messen zu können."
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
            consentSection.summary = "Es werden Ihnen nur Fragen gestellt. Es gibt keine Aufgaben die Sie bewältigen müssen."
            consentSection.content = "Es werden Ihnen nur Fragen gestellt. Es gibt keine Aufgaben die Sie bewältigen müssen."
            
        case .withdrawing:
            consentSection.title = "Rücktritt"
            consentSection.summary = "Sie können jederzeit aus der Studie zurücktreten. In dem Fall werden schnellstmöglich alle ihre Daten gelöscht."
            consentSection.content = "Sie können jederzeit aus der Studie zurücktreten. In dem Fall werden schnellstmöglich alle ihre Daten gelöscht."
        default:
            break
        }
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: "placeHolderTitle", dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}
