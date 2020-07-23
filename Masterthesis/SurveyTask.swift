
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    //MARK: DIFFERENT ANSWER FORMATS
    
    let whichUniChoices = [
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
    let whichUniAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: whichUniChoices)
    
    whichUniAnswerFormat.shouldShowDontKnowButton = true
    
    // WhichGenderQuestionStep
    let whichGenderChoices = [
        ORKTextChoice(text: "männlich", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "weiblich", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "divers", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let whichGenderAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: whichGenderChoices)
    
    whichGenderAnswerFormat.customDontKnowButtonText = "Das möchte ich nicht beantworten"
    
    //AGE
    var ageChoices: [ORKTextChoice] = []
    for i in 16...35 {
        ageChoices.append(ORKTextChoice(text: "\(i)", value: i as NSCoding & NSCopying & NSObjectProtocol))
    }
    
    let ageAnswerFormat = ORKAnswerFormat.valuePickerAnswerFormat(with: ageChoices)
    
    // hoursAnswerFormat
    let hoursAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 60, minimumValue: 0, defaultValue: 20, step: 5, vertical: false, maximumValueDescription: "60 h/Woche", minimumValueDescription: "0 h/Woche")
    
    
    //AlwaysToNeverTextChoices
    let alwaysToNeverTextChoices: [ORKTextChoice] = [ORKTextChoice(text: "nie/ fast nie", value: 1 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "selten", value: 2 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "manchmal", value: 3 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "oft", value: 10 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "immer", value: 5 as NSCoding & NSCopying & NSObjectProtocol)]
    
    let alwaysToNeverAnswerFormat = ORKAnswerFormat.textScale(with: alwaysToNeverTextChoices, defaultIndex: NSIntegerMax, vertical: false)
    
    alwaysToNeverAnswerFormat.shouldShowDontKnowButton = true
    
    //vastToSmallExtendTextChoices
    let vastToSmallExtendTextChoices: [ORKTextChoice] = [ORKTextChoice(text: "in sehr geringem Maß", value: 1 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "in geringem Maß", value: 2 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "zum Teil", value: 3 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "in hohem Maß", value: 10 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "in sehr hohem Maß", value: 5 as NSCoding & NSCopying & NSObjectProtocol)]
    
    let vastToSmallExtendAnswerFormat = ORKAnswerFormat.textScale(with: vastToSmallExtendTextChoices, defaultIndex: NSIntegerMax, vertical: false)
    
    vastToSmallExtendAnswerFormat.shouldShowDontKnowButton = true
    
    //neverToEveryDayTextChoices
    let neverToEveryDayTextChoices: [ORKTextChoice] = [ORKTextChoice(text: "nie", value: 1 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "einige Male im Jahr", value: 2 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "einige Male im Monat", value: 3 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "einige Male in der Woche", value: 10 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "jeden Tag", value: 5 as NSCoding & NSCopying & NSObjectProtocol)]
    
    let neverToEveryDayAnswerFormat = ORKAnswerFormat.textScale(with: neverToEveryDayTextChoices, defaultIndex: NSIntegerMax, vertical: false)
    
    neverToEveryDayAnswerFormat.shouldShowDontKnowButton = true
    
    //happyToNotHappyTextChoices
    let happyToNotHappyTextChoices: [ORKTextChoice] = [ORKTextChoice(text: "sehr unzufrieden", value: 1 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "unzufrieden", value: 2 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "teils-teils", value: 3 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "zufrieden", value: 10 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "sehr zufrieden", value: 5 as NSCoding & NSCopying & NSObjectProtocol)]
    
    let happyToNotHappyAnswerFormat = ORKAnswerFormat.textScale(with: happyToNotHappyTextChoices, defaultIndex: NSIntegerMax, vertical: false)
    
    happyToNotHappyAnswerFormat.shouldShowDontKnowButton = true
    
    
    // Instruction step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Evaluierung deiner psychischen Belastung"
    instructionStep.text = "Bitte beantworte die Fragen so gut es geht. Du kannst bei Bedarf jede Frage überspringen."
    
    steps += [instructionStep]
    
    // Chapter A
    
    let a11 = ORKFormItem(identifier: "a11", text: "Welchen Studiengang studierst du?", answerFormat: whichUniAnswerFormat, optional: true)
    let a12 = ORKFormItem(identifier: "a12", text: "Welchen Geschlecht hast du?", answerFormat: whichGenderAnswerFormat, optional: true)
    let a13 = ORKFormItem(identifier: "a13", text: "Wie alt bist du?", answerFormat: ageAnswerFormat, optional: true)
    let a14 = ORKFormItem(identifier: "a14", text: "Wie viele Stunden pro Woche arbeitest du nebenbei ungefähr? (Nebenjob, Werksstudent, Ehrenamtlich, etc.)", answerFormat: hoursAnswerFormat, optional: true)
    let a15 = ORKFormItem(identifier: "a15", text: "Wie viele Stunden pro Woche lernst du ungefähr?", answerFormat: hoursAnswerFormat, optional: true)
    
    let a1Form = ORKFormStep(identifier: "a1Form", title: "Person& Studium", text: nil)
    
    a1Form.formItems = [
        a11, a12, a13, a14, a15
    ]
    
    steps += [a1Form]
    
    //MARK: B1
        
    let b11 = ORKFormItem(identifier: "b11", text: "Musst du sehr schnell lernen?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b12 = ORKFormItem(identifier: "b12", text: "Arbeitest du den ganzen Tag mit hohem Tempo?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b13 = ORKFormItem(identifier: "b13", text: "Wie oft kommt es vor, dass du nicht genügend Zeit hast, alle Aufgaben für den Tag zu erledigen?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b14 = ORKFormItem(identifier: "b14", text: "Kommst du mit dem Lernen in Rückstand?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b15 = ORKFormItem(identifier: "b15", text: "Musst du länger lernen als du dir das vorgenommen hast?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b16 = ORKFormItem(identifier: "b16", text: "Gehört es zu deinem Lernen dazu, sich mit den persönlichen Problemen anderer Menschen zu beschäftigen?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b1Form = ORKFormStep(identifier: "b1Form", title: nil, text: "Folgende Fragen betreffen die Anforderungen beim Lernen")
    
    b1Form.formItems = [
        b11, b12, b13, b14, b15, b16
    ]
    
    steps += [b1Form]
    
    //MARK: 1 2ter Teil
    
    let b11_2 = ORKFormItem(identifier: "b11_2", text: "Fordert dich das Lernen emotional?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b12_2 = ORKFormItem(identifier: "b12_2", text: "Verlangt das Studium von dir, dass du deine Gefühle verbergen musst?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b13_2 = ORKFormItem(identifier: "b13_2", text: "Verlangt das Studium von dir, deine Meinung zurück zu halten?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b1_2Form = ORKFormStep(identifier: "b1_2Form", title: nil, text: "Anforderungen beim Lernen (Teil 2)")
    
    b1_2Form.formItems = [
        b11_2, b12_2, b13_2
    ]
    
    steps += [b1_2Form]
    
    //MARK: B2
    
    let b21 = ORKFormItem(identifier: "b21", text: "Die Anforderungen meines Studiums stören mein Privat- und Familienleben", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b22 = ORKFormItem(identifier: "b22", text: "Wegen meiner Verpflichtungen im Studium muss ich Pläne für private oder Familienaktivitäten ändern", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b23 = ORKFormItem(identifier: "b23", text: "Mein Studium beansprucht so viel Energie, dass sich dies negativ auf mein Privatleben auswirkt", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b24 = ORKFormItem(identifier: "b24", text: "Mein Studium nimmt so viel Zeit in Anspruch, dass sich dies negativ auf mein Privatleben auswirkt.", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b25 = ORKFormItem(identifier: "b25", text: "In meiner Freizeit bin ich für Personen, mit den ich im Studium zu tun habe, erreichbar.", answerFormat: vastToSmallExtendAnswerFormat)
    
    
    let b2Form = ORKFormStep(identifier: "b2Form", title: nil, text: "Die folgenden Fragen betreffen das Verhältnis zwischen Arbeit und Privatleben: Inwieweit stimmst du folgenden Aussagen zu?")
    
    b2Form.formItems = [
        b21, b22, b23, b24, b25
    ]
    
    steps += [b2Form]
    
    //MARK: B3
    
    let b31 = ORKFormItem(identifier: "b31", text: "Hast du großen Einfluss auf die Entscheidungen, die dein Studium betreffen?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b32 = ORKFormItem(identifier: "b32", text: "Hast du Einfluss auf die Menge an Arbeit, die dir übertragen wird?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b33 = ORKFormItem(identifier: "b33", text: "Hast du Einfluss darauf, was du im Studium machst?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b34 = ORKFormItem(identifier: "b34", text: "Kannst du selber bestimmen, wann du eine Pause machst?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b35 = ORKFormItem(identifier: "b35", text: "Kannst du mehr oder weniger frei entscheiden, wann du Urlaub machst?", answerFormat: alwaysToNeverAnswerFormat)
    
    
    let b3Form = ORKFormStep(identifier: "b3Form", title: nil, text: "Die folgenden Fragen betreffen deine Einflussmöglichkeiten und ihren Spielraum bei der Arbeit.")
    
    b3Form.formItems = [
        b31, b32, b33, b34, b35
    ]
    
    steps += [b3Form]
    
    //MARK: B4
    
    let b41 = ORKFormItem(identifier: "b41", text: "Ist dein Studium abwechslungsreich?", answerFormat: alwaysToNeverAnswerFormat)
    
    
    let b4Form = ORKFormStep(identifier: "b4Form", title: nil, text: "Entwicklungsmöglichkeiten und die Bedeutung der Arbeit (Teil 1).")
    
    b4Form.formItems = [
        b41
    ]
    
    steps += [b4Form]
    
    //MARK: B5
    
    let b51 = ORKFormItem(identifier: "b51", text: "Hast du die Möglichkeit im Studium, neue Dinge zu erlernen?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b52 = ORKFormItem(identifier: "b52", text: "Kannst du deine Fertigkeiten oder dein Fachwissen im Studium auch anwenden?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b53 = ORKFormItem(identifier: "b53", text: "Findest du dein Studium sinnvoll?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b54 = ORKFormItem(identifier: "b54", text: "Hast du das Gefühl, dass dein Studium wichtig ist?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b55 = ORKFormItem(identifier: "b55", text: "Bist du Stolz, Teil deiner Universität zu sein?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b56 = ORKFormItem(identifier: "b56", text: "Erzählst du anderen gerne über dein Studium?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b5Form = ORKFormStep(identifier: "b5Form", title: nil, text: "Entwicklungsmöglichkeiten und Bedeutung (Teil 2).")
    
    b5Form.formItems = [
        b51, b52, b53, b54, b55, b56
    ]
    
    steps += [b5Form]
    
    //MARK: B6
    
    let b61 = ORKFormItem(identifier: "b61", text: "Wirst du rechtzeitig im Voraus über Veränderungen in deinem Studium informiert, z.B. über wichtige Entscheidungen, Veränderungen oder Pläne für die Zukunft?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b62 = ORKFormItem(identifier: "b62", text: "Erhältst du alle Informationen, die du brauchst, um dein Studium gut zu erledigen?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b63 = ORKFormItem(identifier: "b63", text: "Gibt es klare Ziele für dein Studium?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b64 = ORKFormItem(identifier: "b64", text: "Weißt du genau, welche Dinge in deinen Verantwortungsbereich fallen?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b65 = ORKFormItem(identifier: "b65", text: "Weißt du genau, was von dir in deinem Studium erwartet wird?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b66 = ORKFormItem(identifier: "b66", text: "Werden in deinem Studium widersprüchliche Erwartungen gestellt?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b67 = ORKFormItem(identifier: "b67", text: "Musst du manchmal Dinge tun, die eigentlich auf andere Weise getan werden sollten?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b68 = ORKFormItem(identifier: "b68", text: "Musst du manchmal Dinge tun, die dir unnötig erscheinen?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b6Form = ORKFormStep(identifier: "b6Form", title: nil, text: "Nun einige Fragen zu Regelungen und Abläufen bei deinem Studium.")
    
    b6Form.formItems = [
        b61, b62, b63, b64, b65, b66, b67, b68
    ]
    
    steps += [b6Form]
    
    //MARK: B7
    
    let b71 = ORKFormItem(identifier: "b71", text: "... für gute Entwicklungsmöglichkeiten der Studierende sorgen?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b72 = ORKFormItem(identifier: "b72", text: "... der Zufriedenheit der Studierende einen hohen Stellenwert beimessen?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b73 = ORKFormItem(identifier: "b73", text: "... das Fach/Vorlesung/Übung gut planen?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b74 = ORKFormItem(identifier: "b74", text: "... konflikte gut lösen?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b7Form = ORKFormStep(identifier: "b7Form", title: nil, text: "Bitte schätze ein, in welchem Maße Dozierende bzw. Professoren/innen...")
    
    b7Form.formItems = [
        b71, b72, b73, b74
    ]
    
    steps += [b7Form]
    
    //MARK: B8
    
    let b81 = ORKFormItem(identifier: "b81", text: "Wie oft erhältst du bei Bedarf Hilfe und Unterstützung von deinen Mitstudierenden?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b82 = ORKFormItem(identifier: "b82", text: "Wie oft sind deine Mitstudierende bei Bedarf bereit, sich deine studienbezogenen Probleme anzuhören?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b83 = ORKFormItem(identifier: "b83", text: "Wie oft erhältst du bei Bedarf Hilfe und Unterstützung von den Dozierenden bzw. Professoren/innen?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b84 = ORKFormItem(identifier: "b84", text: "Wie oft sind Dozierende bzw. Professoren/innen bei Bedarf bereit, sich deine Probleme mit dem Studium anzuhören?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b85 = ORKFormItem(identifier: "b85", text: "Wie oft sprechen Dozierende bzw. Professoren/innen mit dir über die Qualität deiner Leistungen?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b86 = ORKFormItem(identifier: "b86", text: "Wir oft sprechen deine Mitstudierende mit dir über die Qualität deiner Leistungen?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b87 = ORKFormItem(identifier: "b87", text: "Ist die Atmosphäre zwischen dir und deinen Mitstudierenden gut?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b88 = ORKFormItem(identifier: "b88", text: "Ist die Zusammenarbeit zwischen dir und deinen Mitstudierenden gut?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b89 = ORKFormItem(identifier: "b89", text: "Wie oft fühlst du dich von Dozierenden bzw. Professoren/innen zu Unrecht kritisiert, schikaniert oder vor anderen bloßgestellt?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b8Form = ORKFormStep(identifier: "b8Form", title: nil, text: "Die folgenden Fragen betreffen dein Verhältnis zu deinen Mitstudierenden und Dozierenden bzw. Professoren/innen.")
    
    b8Form.formItems = [
        b81, b82, b83, b84, b85, b86, b87, b88, b89
    ]
    
    steps += [b8Form]
    
    //MARK: B8a
    
    let b81a = ORKFormItem(identifier: "b81a", text: "Vertrauen die Dozierenden bzw. Professoren/innen darauf, dass die Studierenden ihr Lernpensum gut einteilen?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b82a = ORKFormItem(identifier: "b82a", text: "Können Studierende den Informationen vertrauen, die sie von den Dozierenden bzw. Professoren/innen bekommen?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b83a = ORKFormItem(identifier: "b83a", text: "Werden Konflikte auf gerechte Weise gelöst?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b84a = ORKFormItem(identifier: "b84a", text: "Erfährt dein Einsatz im Studium Anerkennung und Wertschätzung von Dozierenden bzw. Professoren/innen?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b8aForm = ORKFormStep(identifier: "b8aForm", title: nil, text: "Die nächsten Fragen beziehen sich nicht auf deine Lerntätigkeit, sondern auf das Studium an sich.")
    
    b8aForm.formItems = [
        b81a, b82a, b83a, b84a
    ]
    
    steps += [b8aForm]
    
    //MARK: B8b
    
    let whichBadEnviromentChoices = [
        ORKTextChoice(text: "Lichtverhältnissen", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Luftverhältnissen", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Temperaturverhältnissen", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Zugluft", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Umgebungsgeräuschen ", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let whichBadEnviromentAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: whichBadEnviromentChoices)
    
    whichBadEnviromentAnswerFormat.shouldShowDontKnowButton = true
    
    let b81b = ORKFormItem(identifier: "b81a", text: "Wie oft kommt es vor, dass du während des Lernens schlechten/lauten ... ausgesetzt bist?", answerFormat: whichBadEnviromentAnswerFormat)
    
    let b8bForm = ORKFormStep(identifier: "b8bForm", title: nil, text: "Die nächsten Fragen beziehen sich nicht auf deine Umgebungsbedingungen beim Lernen")
    
    b8bForm.formItems = [
        b81b
    ]
    
    steps += [b8bForm]
    
    //MARK: B9
    
    let b91 = ORKFormItem(identifier: "b91", text: "... du nach dem Studium kein Job findest?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b92 = ORKFormItem(identifier: "b92", text: "... neue Technologien dich überflüssig machen?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b93 = ORKFormItem(identifier: "b93", text: "... es schwierig für dich wäre, eine Alternative zu finden, wenn du dieses Studium nicht schaffen würdest?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b94 = ORKFormItem(identifier: "b94", text: "... du nach deinem Studium einen Job mit geringem Einkommen finden wirst. ?", answerFormat: vastToSmallExtendAnswerFormat)
    
    let b9Form = ORKFormStep(identifier: "b9Form", title: nil, text: "Machst du dir Sorgen, dass ...")
    
    b9Form.formItems = [
        b91, b92, b93, b94
    ]
    
    steps += [b9Form]
    
    //MARK: B10
    
    let b101 = ORKFormItem(identifier: "b101", text: "... dein Studium aufzugeben?", answerFormat: neverToEveryDayAnswerFormat)
    
    let b102 = ORKFormItem(identifier: "b102", text: "... dein Studium zu wechseln?", answerFormat: neverToEveryDayAnswerFormat)
    
    let b10Form = ORKFormStep(identifier: "b10Form", title: nil, text: "Wie oft hast du im Laufe der letzten 12 Monate daran gedacht ...")
    
    b10Form.formItems = [
        b101, b102
    ]
    
    steps += [b10Form]
    
    //MARK: B11
    
    let b111 = ORKFormItem(identifier: "b111", text: "... deinen Berufsperspektiven?", answerFormat: happyToNotHappyAnswerFormat)
    
    let b112 = ORKFormItem(identifier: "b112", text: "... deinen Mitstudierenden?", answerFormat: happyToNotHappyAnswerFormat)
    
    let b113 = ORKFormItem(identifier: "b113", text: "... den körperlichen Studiums Bedingungen?", answerFormat: happyToNotHappyAnswerFormat)
    
    let b114 = ORKFormItem(identifier: "b114", text: "... der Art und Weise, wie die Universität geführt wird?", answerFormat: happyToNotHappyAnswerFormat)
    
    let b115 = ORKFormItem(identifier: "b115", text: "... der Art und Weise, wie deine Fähigkeiten genutzt werden?", answerFormat: happyToNotHappyAnswerFormat)
    
    let b116 = ORKFormItem(identifier: "b116", text: "... deinem Studium insgesamt, unter Berücksichtigung aller Umstände?", answerFormat: happyToNotHappyAnswerFormat)
    
    let b11Form = ORKFormStep(identifier: "b11Form", title: nil, text: "Wenn du deine Studiums- Situation insgesamt betrachtest, wie zufrieden bist du mit ...")
    
    b11Form.formItems = [
        b111, b112, b113, b114, b115, b116
    ]
    
    steps += [b11Form]
    
    //MARK: B12
    
    let b12AnswerFormat = ORKSESAnswerFormat(topRungText: "bester denkbarer Gesundheitszustand",
                                             bottomRungText: "schlechtester denkbarer Gesundheitszustand")

    let b121 = ORKFormItem(identifier: "b121",
                                          text: nil,
                                          answerFormat: b12AnswerFormat)
    
    let b121Form = ORKFormStep(identifier: "b12Form", title: nil, text: "Dein Gesundheitszustand: Wenn du den besten denkbaren Gesundheitszustand mit 10 Punkten und den schlechtesten denkbaren mit 0 Punkten bewerten würdest: Wie viele Punkte würdest du deinem derzeitigen Gesundheitszustand vergeben?")
    
    b121Form.formItems = [
        b121
    ]
    
    steps += [b121Form]
    
    //MARK: B13
    
    let b131 = ORKFormItem(identifier: "b131", text: "... bist du körperlich erschöpft?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b132 = ORKFormItem(identifier: "b132", text: "... bist du emotional erschöpft?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b133 = ORKFormItem(identifier: "b133", text: "... fühlst du dich ausgelaugt?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b134 = ORKFormItem(identifier: "b134", text: "... musst du trotzdem lernen, obwohl du dich krank und unwohl fühlst?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b135 = ORKFormItem(identifier: "b135", text: "... kannst du während deiner Freizeit dein Studium nicht vergessen?", answerFormat: alwaysToNeverAnswerFormat)
    
    let b13Form = ORKFormStep(identifier: "b13Form", title: nil, text: "Energie und psychisches Wohlbefinden: Bitte gebe für jede der Folgenden Aussagen an, inwieweit diese auf dich zutreffen. Wie häufig ...")
    
    b13Form.formItems = [
        b131, b132, b133, b134, b135
    ]
    
    steps += [b13Form]
    
    //MARK: B14
    
    let b141 = ORKFormItem(identifier: "b141", text: "Wenn ich lerne bin ich voller Energie", answerFormat: alwaysToNeverAnswerFormat)
    
    let b142 = ORKFormItem(identifier: "b142", text: "Ich bin von meinem Studium begeistert", answerFormat: alwaysToNeverAnswerFormat)
    
    let b143 = ORKFormItem(identifier: "b143", text: "Ich gehe völlig in meinem Studium auf", answerFormat: alwaysToNeverAnswerFormat)

    
    let b14Form = ORKFormStep(identifier: "b14Form", title: nil, text: "Wie oft treffen folgende Aussagen auf dich zu?")
    
    b14Form.formItems = [
        b141, b142, b143
    ]
    
    steps += [b14Form]

    
    // Summary step
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Danke dir!"
    summaryStep.text = "Ein kleiner Schritt für dich, ein großer Schritt für meine Masterarbeit :)"
    
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
