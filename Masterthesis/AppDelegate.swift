//
//  AppDelegate.swift
//  Masterthesis
//
//  Created by Ümit Gül on 03.07.20.
//  Copyright © 2020 Ümit Gül. All rights reserved.
//

import UIKit
import ResearchKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let healthStore = HKHealthStore()
    
    var window: UIWindow?
    
    var containerViewController: ResearchContainerViewController? {
        return window?.rootViewController as? ResearchContainerViewController
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
//        let standardDefaults = UserDefaults.standard
//        if standardDefaults.object(forKey: "ORKSampleFirstRun") == nil {
//            ORKPasscodeViewController.removePasscodeFromKeychain()
//            standardDefaults.setValue("ORKSampleFirstRun", forKey: "ORKSampleFirstRun")
//        }
        // Dependency injection.
        containerViewController?.injectHealthStore(healthStore)
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {

    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
}

