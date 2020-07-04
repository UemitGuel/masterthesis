//
//  PersonalViewController.swift
//  Masterthesis
//
//  Created by Ümit Gül on 04.07.20.
//  Copyright © 2020 Ümit Gül. All rights reserved.
//

import UIKit
import ResearchKit

class PersonalViewController: UIViewController {

    @IBOutlet weak var showConsentDocument: UIButton!
    
    @IBAction func showConsentDocumentTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: consentPDFViewerTask(), taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func consentPDFViewerTask() -> ORKOrderedTask{
        var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
        docURL = docURL?.appendingPathComponent("consent.pdf")
        let PDFViewerStep = ORKPDFViewerStep.init(identifier: "ConsentPDFViewer", pdfURL: docURL)
        PDFViewerStep.title = "Consent"
        return ORKOrderedTask(identifier: String("ConsentPDF"), steps: [PDFViewerStep])
    }

}

extension PersonalViewController: ORKTaskViewControllerDelegate{
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
    }
}
