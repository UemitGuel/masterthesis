
import UIKit
import ResearchKit
import MessageUI

class PersonalViewController: UIViewController {
    
    @IBOutlet weak var mailButton: UIButton!
    
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
        mailButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        mailButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        mailButton.contentHorizontalAlignment = .left
        withdrawStudy.layer.cornerRadius = 10
        withdrawStudy.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        withdrawStudy.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        withdrawStudy.contentHorizontalAlignment = .left
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
