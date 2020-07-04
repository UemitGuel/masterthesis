//
//  TaskViewController.swift
//  Masterthesis
//
//  Created by Ümit Gül on 04.07.20.
//  Copyright © 2020 Ümit Gül. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var startStudyButton: UIButton!
    
    @IBAction func startStudyButtonTapped(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()

    }

    func configureButton() {
        startStudyButton.layer.cornerRadius = 10
    }
}
