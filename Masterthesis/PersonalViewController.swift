
import UIKit
import ResearchKit
import MessageUI

class PersonalViewController: UIViewController {
    
    @IBOutlet weak var mailButton: UIButton!
    
    @IBOutlet weak var copsoqInformationButton: UIButton!
    
    @IBAction func copsoqButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "https://www.copsoq.de") {
            UIApplication.shared.open(url)
        }
    }
    
    
    @IBOutlet weak var githubButton: UIButton!
    
    @IBAction func githubButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "https://github.com/quechupiOS/masterthesis") {
            UIApplication.shared.open(url)
        }
    }
    
    
    
    @IBAction func mailButtonTapped(_ sender: UIButton) {
        sendEmail(subject: "Frage zur Umfrage um die psychische Gesundheit von Studenten zu evaluieren", body: "<p>Lieber Ümit,ich habe folgende Frage zu deiner Studie:</p>")
    }
    
    @IBOutlet weak var withdrawStudy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    func configureButton() {
        mailButton.layer.cornerRadius = 10
        withdrawStudy.layer.cornerRadius = 10
        copsoqInformationButton.layer.cornerRadius = 10
        githubButton.layer.cornerRadius = 10
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
