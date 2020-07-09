import ResearchKit

class ConsentDocumentNew: ORKConsentDocument {
    // MARK: Properties
    
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        title = "Einverständniserklärung"
        
        let consentSectionTypes: [ORKConsentSectionType] = [
            .overview,
            .privacy,
            .dataUse,
            .timeCommitment,
            .studySurvey,
            .withdrawing
        ]
        
        var consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
            let consentSection = ORKConsentSection(type: contentSectionType)
            switch contentSectionType {
            case .overview:
                consentSection.title = "Worum geht es in der Studie?"
                let summary = "Unternehmen sind verpflichtet im Rahmen der betrieblichen Gefährdungsbeurteilung psychische Belastungen und Beanspruchungen ihrer Arbeitnehmerinnen und Arbeitnehmer bei der Arbeit zu messen und sie vor psychischen Erkrankungen zu schützen. Universitäten sind im Bezug auf Studenten nicht dazu verpflichtet. Diese Studie soll daher helfen die psychischen Beanspruchungen von Studenten in Stress-Situationen besser nachzuvollziehen."
                consentSection.summary = summary
                consentSection.content = summary
            case .privacy:
                consentSection.title = "Datenschutz"
                let summary = "Deine Daten werden vollständig anonymisert und können nicht auf deine Person zurückgeführt werden. Es werden keinerlei persönliche Daten übergeben. Alle Daten werden auf deutschen Servern gesichert und unterliegen der DSGVO.\nDie gesamte Code-base ist Open Source, sodass jeder nachvollziehen kann was passiert."
                consentSection.summary = summary
                consentSection.content = summary
            case .dataUse:
                consentSection.title = "Datennutzung"
                let summary = "Die gesammelten Daten werden anonymisiert der Fakultät für Arbeitswissenschaften der RWTH Aachen übergeben und dort mindestens 10 Jahre aufbewahrt."
                consentSection.summary = summary
                consentSection.content = summary
            case .timeCommitment:
                consentSection.title = "Dauer"
                let summary = "Die Umfrage sollte nicht länger als 15-20 minuten dauern."
                consentSection.summary = summary
                consentSection.content = summary
                
            case .studySurvey:
                consentSection.title = "Umfrage der Studie"
                let summary = "Die Teilnahme an der Umfrage is freiwillig. Es werden Ihnen nur Fragen gestellt. Es gibt keine Aufgaben die Sie bewältigen müssen. Sie können nach der Einführung unter dem Punkt ‘Account‘ mir jederzeit Fragen zur Studie zusenden."
                consentSection.summary = summary
                consentSection.content = summary
                
            case .withdrawing:
                consentSection.title = "Rücktritt"
                let summary = "Sie können jederzeit aus der Studie zurücktreten, indem Sie unter dem Punkt ‘Account‘ die Löschung ihre Daten anfordern."
                consentSection.summary = summary
                consentSection.content = summary
            default:
                break
            }
            
            return consentSection
        }
        
        sections = consentSections
        
        addSignature(ORKConsentSignature(forPersonWithTitle: "placeHolderTitle", dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
