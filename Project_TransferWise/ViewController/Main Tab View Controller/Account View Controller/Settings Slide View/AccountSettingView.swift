//
//  SliderView.swift
//  Project_TransferWise
//
//  Created by Tiko on 8/2/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol MoveOtherScreenDelegate: class {
    func selectLogOut()
}

class AccountSettingView: UIView {
    
    // MARK: - @IBOutlets
    @IBOutlet private weak var viewLine: UIView!
    @IBOutlet private weak var settingView: UIView!
    @IBOutlet private weak var helpView: UIView!
    @IBOutlet private weak var logOutView: UIView!
    
    // MARK: - Properties
    weak var delegate: MoveOtherScreenDelegate?
    
    // MARK: - View LifeCyrcle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configuration()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        self.viewLine.cornerView(cornerRadius: 2, borderWidth: 0.1, borderColor: Constants.Color.disabledGrey)
        let heightSetting = self.settingView.frame.size.height
        let heightHelp = self.helpView.frame.size.height
        let heightLogOut = self.logOutView.frame.size.height
        self.settingView.cornerView(cornerRadius: heightSetting/2, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
        self.helpView.cornerView(cornerRadius: heightHelp/2, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
        self.logOutView.cornerView(cornerRadius: heightLogOut/2, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
    }
    
    // MARK: - IBActions
    @IBAction func settings() {
        let vc = SettingsViewController()
        vc.modalPresentationStyle = .fullScreen
//        let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
//        let vc: CampainDetailView = storyboard.instantiateViewControllerWithIdentifier("campainDetailView") as! CampainDetailView
//        let currentController = self.getCurrentViewController()
//        currentController?.presentViewController(vc, animated: false, completion: nil)
    }
    
    @IBAction func help() {
        
    }
    
    @IBAction func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.delegate?.selectLogOut()
             print("LogOut")
        } catch let sighOutError as NSError {
            print("Error signing out: %@", sighOutError)
        }
    }
}

