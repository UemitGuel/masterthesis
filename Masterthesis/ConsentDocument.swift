
import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Example Consent"
    
    let consentSectionTypes: [ORKConsentSectionType] = [
        .dataGathering,
        .privacy,
        .dataUse,
        .timeCommitment,
        .studySurvey,
        .studyTasks,
        .withdrawing
    ]
    
    var consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
         switch contentSectionType {
         case .overview:
            consentSection.title = "2"
             consentSection.summary = "Überblick Masterarbeit"
             consentSection.content = "Unternehmen sind verpflichtet psychische Gesundheitsevaluierung durchzuführen um ihre Arbeitnehmer vor mentalen Erkrankungen zu schützen. Studenten sind laut Gesetzbuch keine Arbeitnehmer und bekommen dadurch nicht den selben Schutz, obwohl auch Studenten eine gefährdete Gruppe für diese Art der pysischen Überbelastung darstellen.\nDiese Studie soll der Universität ein Werkzeug in die Hand geben um die psychische Belastung ihrer Studenten zu verstehen und messen zu können."
         case .dataGathering:
             consentSection.summary = "DataGathering"
             consentSection.content = "DataGathering - Content"
             consentSection.title = "2"
         case .privacy:
             consentSection.summary = "Privacy"
             consentSection.content = "Privacy - Content"
         case .dataUse:
             consentSection.summary = "DataUse"
             consentSection.content = "DataUse - Content"
         case .timeCommitment:
             consentSection.summary = "TimeCommitment"
             consentSection.content = "TimeCommitment - Content"
         case .studySurvey:
             consentSection.summary = "StudySurvey"
             consentSection.content = "StudySurvey - Content"
         case .studyTasks:
             consentSection.summary = "StudyTasks"
             consentSection.content = "StudyTasks - Content"
         case .withdrawing:
             consentSection.summary = "Withdrawing"
             consentSection.content = "Withdrawing - Content"
         default:
             break
        }
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}
