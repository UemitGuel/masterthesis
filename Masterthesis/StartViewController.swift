//
//  ViewController.swift
//  Masterthesis
//
//  Created by Ümit Gül on 03.07.20.
//  Copyright © 2020 Ümit Gül. All rights reserved.
//
//
//import UIKit
//import ResearchKit
//
//class StartViewController: UIViewController {
//    
//    let defaults = UserDefaults.standard
//    
//    @IBAction func consentTapped(sender : AnyObject) {
//        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
//        taskViewController.delegate = self
//        present(taskViewController, animated: true, completion: nil)
//    }
//    
//    @IBOutlet weak var joinStudyButton: UIButton!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureButton()
//        // Do any additional setup after loading the view.
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if defaults.bool(forKey: "ConsentGiven") {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
//            self.navigationController?.setViewControllers([vc!], animated:true)
//        }
//    }
//    
//    func configureButton() {
//        joinStudyButton.layer.cornerRadius = 10
//    }
//    
//}
//
//extension StartViewController: ORKTaskViewControllerDelegate {
//    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
//        switch reason{
//        case .completed:
//            let signatureResult: ORKConsentSignatureResult = taskViewController.result.stepResult(forStepIdentifier: "ConsentReviewStep")?.firstResult as! ORKConsentSignatureResult
//            let consentDocument = ConsentDocument.copy() as! ORKConsentDocument
//            signatureResult.apply(to: consentDocument)
//            consentDocument.makePDF{ (data, error) -> Void in
//                var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
//                docURL = docURL?.appendingPathComponent("consent.pdf")
//                print(docURL)
//                try? data?.write(to: docURL!, options: .atomicWrite)
//                
//                self.defaults.set(true, forKey: "ConsentGiven")
//                
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
//                self.navigationController?.setViewControllers([vc!], animated:true)
//            }
//            dismiss(animated: true, completion: nil)
//        case .discarded, .failed, .saved:
//            dismiss(animated: true, completion: nil)
//        @unknown default:
//            fatalError()
//        }
//    }
//}
