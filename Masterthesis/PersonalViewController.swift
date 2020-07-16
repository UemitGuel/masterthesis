//
//  PersonalViewController.swift
//  Masterthesis
//
//  Created by Ümit Gül on 04.07.20.
//  Copyright © 2020 Ümit Gül. All rights reserved.
//

import UIKit
import ResearchKit
import MessageUI

class PersonalViewController: UIViewController, HealthClientType {
    
    var healthStore: HKHealthStore?
    
    @IBOutlet weak var lineGraph: ORKLineGraphChartView!
    
    let lineGraphDataSource = LineGraphDataSource()
    
    @IBOutlet weak var legendeLabel: UILabel!
    
    
    @IBOutlet weak var showConsentDocument: UIButton!
    
    @IBAction func showConsentDocumentTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: consentPDFViewerTask(), taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var mailButton: UIButton!
    
    @IBAction func mailButtonTapped(_ sender: UIButton) {
        sendEmail(subject: "Frage zur Umfrage um die psychische Gesundheit von Studenten zu evaluieren", body: "<p>Lieber Ümit,ich habe folgende Frage zu deiner Studie:</p>")
    }
    
    @IBOutlet weak var withdrawStudy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        populateLegendLabel()
        sharedStepCalculatorHelper.getAverageStepsFor(dayInterval: .zeroToTwenty, healthStore: healthStore) { double in
            print(double.count)
            for i in 0...59 {
                print(i)
                self.lineGraphDataSource.plotPoints[0][i] = ORKValueRange(value: double[i])
            }
            DispatchQueue.main.async {
            self.lineGraph.dataSource = self.lineGraphDataSource
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func populateLegendLabel() {
        legendeLabel.text = "X-Achse: Tage\nY-Achse: Schritte in 1000"
    }
    
    func configureButton() {
        showConsentDocument.layer.cornerRadius = 10
        showConsentDocument.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        showConsentDocument.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        showConsentDocument.contentHorizontalAlignment = .left
        mailButton.layer.cornerRadius = 10
        mailButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        mailButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        mailButton.contentHorizontalAlignment = .left
        withdrawStudy.layer.cornerRadius = 10
        withdrawStudy.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        withdrawStudy.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        withdrawStudy.contentHorizontalAlignment = .left
    }
    
    func consentPDFViewerTask() -> ORKOrderedTask{
        var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
        docURL = docURL?.appendingPathComponent("consent.pdf")
        let PDFViewerStep = ORKPDFViewerStep.init(identifier: "ConsentPDFViewer", pdfURL: docURL)
        PDFViewerStep.title = "Consent"
        return ORKOrderedTask(identifier: String("ConsentPDF"), steps: [PDFViewerStep])
    }
    
    func sendEmail(subject: String, body: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["uemit.guel@rwth-aachen.de"])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: true)
            present(mail, animated: true)
        } else {
            print("fail")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension PersonalViewController: ORKTaskViewControllerDelegate{
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
    }
}

extension PersonalViewController: MFMailComposeViewControllerDelegate {
    
}
