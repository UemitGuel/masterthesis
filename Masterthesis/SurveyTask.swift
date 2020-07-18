
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    // Instruction step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Evaluierung deiner psychischen Belastung"
    instructionStep.text = "Bitte beantworte die Fragen so gut es geht. Du kannst bei Bedarf jede Frage überspringen."
    
    steps += [instructionStep]
    
    // Chapter A
    let chapterTitleA = "Person& Studium"
    
    // WhichUniversityQuestionStep
    let whichUniversityStepTitle = "Welchen Studiengang studierst du?"
    let whichUniversityChoices = [
        ORKTextChoice(text: "Ingenieurwissenschaften", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Naturwissenschaften", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Wirtschaftswissenschaften", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Medizin", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Jura", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Sozialwissenschaften", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Informatik", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Lehramt", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Sonstiges", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let questAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: whichUniversityChoices)
    
    let whichUniversityQuestionStep = ORKQuestionStep(identifier: "whichUniversityQuestionStep", title: chapterTitleA, question: whichUniversityStepTitle, answer: questAnswerFormat)
    
    steps += [whichUniversityQuestionStep]
    
    // WhichGenderQuestionStep
    let whichGenderQuestionStepTitle = "Welchen Geschlecht hast du?"
    let whichGenderChoices = [
        ORKTextChoice(text: "männlich", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "weiblich", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "divers", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let whichGenderAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: whichGenderChoices)
    
    let whichGenderQuestionStep = ORKQuestionStep(identifier: "whichGenderQuestionStep", title: chapterTitleA, question: whichGenderQuestionStepTitle, answer: whichGenderAnswerFormat)
    
    steps += [whichGenderQuestionStep]
    
    // AgeQuestionStep
    
    var ageChoices: [ORKTextChoice] = []
    for i in 16...35 {
        ageChoices.append(ORKTextChoice(text: "\(i)", value: i as NSCoding & NSCopying & NSObjectProtocol))
        }
    
    let ageAnswerFormat = ORKAnswerFormat.valuePickerAnswerFormat(with: ageChoices)
    
    let ageQuestionStep = ORKQuestionStep(identifier: String(describing: "AgeQuestionStep"), title: chapterTitleA, question: "Wie alt bist du?", answer: ageAnswerFormat)
        
    steps += [ageQuestionStep]
    
    // workHoursStep
    let workHoursAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 40, minimumValue: 0, defaultValue: 10, step: 5, vertical: false, maximumValueDescription: "40 h/Woche", minimumValueDescription: "0 h/Woche")
    let workHoursQuestionStepTitle = "Wie viele Stunden pro Woche arbeitest du ca. nebenbei? (Nebenjob, Werksstudent, Ehrenamtlich, etc.)?"
    let workHoursQuestionStep = ORKQuestionStep(identifier: "workHoursStep", title: chapterTitleA, question: workHoursQuestionStepTitle, answer: workHoursAnswerFormat)
    
    steps += [workHoursQuestionStep]
    
    // studyHoursStep
    let studyHoursAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 70, minimumValue: 0, defaultValue: 20, step: 10, vertical: false, maximumValueDescription: "70 h/Woche", minimumValueDescription: "0 h/Woche")
    let studyHoursQuestionStepTitle = "Wie viele Stunden pro Woche lernst du ungefähr?"
    let studyHoursQuestionStep = ORKQuestionStep(identifier: "studyHoursStep", title: chapterTitleA, question: studyHoursQuestionStepTitle, answer: studyHoursAnswerFormat)
    
    steps += [studyHoursQuestionStep]
    
    // Summary step
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Danke dir!"
    summaryStep.text = "Ein kleiner Schritt für dich, ein großer Schritt für meine Masterarbeit :)"
    
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
