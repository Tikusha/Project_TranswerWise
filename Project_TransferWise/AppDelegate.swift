//
//  AppDelegate.swift
//  Project_TransferWise
//
//  Created by Tiko on 7/10/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = MainScreenViewController(nibName: "MainScreen", bundle: nil)
        let main = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = main
        FirebaseApp.configure()
        return true
    }
}

