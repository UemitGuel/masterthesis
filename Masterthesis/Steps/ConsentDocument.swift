import ResearchKit

class ConsentDocument: ORKConsentDocument {
    // MARK: Properties
    
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        title = "Einverständniserklärung"
        
        let consentSectionTypes: [ORKConsentSectionType] = [
            .overview,
            .studySurvey,
            .timeCommitment,
            .privacy,
            .dataUse,
            .withdrawing
        ]
        
        let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
            let consentSection = ORKConsentSection(type: contentSectionType)
            switch contentSectionType {
            case .overview:
                consentSection.title = "Worum geht es in der Studie?"
                let summary = "App-basierte Studien haben den Vorteil, dass sie herkömmliche Umfragen durch reale Gesundheitsdaten erweitern können. Das könnte dazu führen, dass sonst verborgen gebliebene Zusammenhänge festgestellt werden können.\nUm diese These zu überprüfen möchte ich zum einen mit einer Umfrage die psychische Belastung von Studierenden in Stress-Situationen erfassen und zum anderen untersuchen, ob die Stress-Situation einen signifikanten Effekt auf die täglich zurückgelegten Schritte hatte."
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
                let summary = "Die Umfrage sollte nicht länger als 10-15 minuten dauern."
                consentSection.summary = summary
                consentSection.content = summary
                
            case .studySurvey:
                consentSection.title = "Umfrage der Studie"
                let summary = "Der verwendete Fragebogen ist eine leicht abgewandelte Version des COPSOQ (Copenhagen Psychosocial Questionnaire). Dieser ist ein wissenschaftlich validierter Fragebogen zur Erfassung psychischer Belastungen und Beanspruchungen bei der Arbeit. Er wird insbesondere im Rahmen der betrieblichen Gefährdungsbeurteilung eingesetzt. Ich habe den Fragebogen aber auf Studierende angepasst. Die Teilnahme an der Umfrage ist freiwillig. Du kannst mir jederzeit unter dem Menü-Punkt ‘Account‘ eine Email schreiben wenn du Fragen hast."
                consentSection.summary = summary
                consentSection.content = summary
                
            case .withdrawing:
                consentSection.title = "Rücktritt"
                let summary = "Du kannst unter dem Menü-Punkt ‘Account‘ jederzeit aus der Studie wieder austreten."
                consentSection.summary = summary
                consentSection.content = summary
            default:
                break
            }
            
            return consentSection
        }
        
        sections = consentSections        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
