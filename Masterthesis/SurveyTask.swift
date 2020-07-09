
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    // Instruction step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Knoweledge of the Universe Survey"
    instructionStep.text = "Please answer these 6 questions to the best of your ability. It's okay to skip a question if you don't know the answer."
    
    steps += [instructionStep]
    
    // Quest question using text choice
    let questQuestionStepTitle = "Which of the following is not a planet?"
    let textChoices = [
        ORKTextChoice(text: "Saturn", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Uranus", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Pluto", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Mars", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let questAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
    let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: questQuestionStepTitle, answer: questAnswerFormat)
    
    steps += [questQuestionStep]
    
    // Name question using text input
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 25)
    nameAnswerFormat.multipleLines = false
    let nameQuestionStepTitle = "What do you think the next comet that's discovered should be named?"
    let nameQuestionStep = ORKQuestionStep(identifier: "NameQuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    
    steps += [nameQuestionStep]
    
    // Date question
    let today = NSDate()
    let dateAnswerFormat = ORKAnswerFormat.dateAnswerFormat(withDefaultDate: nil, minimumDate: today as Date, maximumDate: nil, calendar: nil)
    let dateQuestionStepTitle = "When is the next solar eclipse?"
    let dateQuestionStep = ORKQuestionStep(identifier: "DateQuestionStep", title: dateQuestionStepTitle, answer: dateAnswerFormat)
    
    steps += [dateQuestionStep]
    
    // Boolean question
    let booleanAnswerFormat = ORKBooleanAnswerFormat()
    let booleanQuestionStepTitle = "Is Venus larger than Saturn?"
    let booleanQuestionStep = ORKQuestionStep(identifier: "BooleanQuestionStep", title: booleanQuestionStepTitle, answer: booleanAnswerFormat)
    
    steps += [booleanQuestionStep]
    
    // Continuous question
    let continuousAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 150, minimumValue: 30, defaultValue: 20, step: 10, vertical: false, maximumValueDescription: "Objects", minimumValueDescription: " ")
    let continuousQuestionStepTitle = "How many objects are in Messier's catalog?"
    let continuousQuestionStep = ORKQuestionStep(identifier: "ContinuousQuestionStep", title: continuousQuestionStepTitle, answer: continuousAnswerFormat)
    
    steps += [continuousQuestionStep]
    
    // Summary step
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Thank you."
    summaryStep.text = "We appreciate your time."
    
    steps += [summaryStep]
    
    
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
