import ResearchKit

class ConsentDocument: ORKConsentDocument {
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
        
        let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
            let consentSection = ORKConsentSection(type: contentSectionType)
            switch contentSectionType {
            case .overview:
                consentSection.title = "Worum geht es in der Studie?"
                let summary = "App-basierte Umfragen in Kombination mit Gesundheitsdaten, die sowieso schon auf den Geräten vorhanden sind, könnten das wissenschaftliche Arbeiten langfristig verändern und Möglichkeiten bieten, sonst verborgen gebliebene Zusammenhänge festzustellen. Um diese These zu überprüfen, möchte ich gerne festellen ob es einen Zusammenhang gibt zwischen der psychischen Belastung eines Studenten in einer Stresssituation und der Anzahl von Schritten die dieser Student pro Tag zurücklegt.\n\n Dafür wende ich eine leicht abgewandelte Version des COPSOQ-Fragebogen an, welcher ursprünglich zur Gefährdungsbeurteilung von Arbeitnehmern entwickelt worden ist. Das Ergebniss des Fragebogens vergleiche ich dann mit dem durschnittlichen Wert deiner Schrittzahlen über die letzten zwei Monate."
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
                let summary = "Die Teilnahme an der Umfrage ist freiwillig. Es werden nur Fragen gestellt, es gibt keine Aufgaben die du bewältigen musst. Du kannst mir jederzeit unter dem Menü-Punkt ‘Account‘ eine Email schreiben wenn du Fragen hast."
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
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
