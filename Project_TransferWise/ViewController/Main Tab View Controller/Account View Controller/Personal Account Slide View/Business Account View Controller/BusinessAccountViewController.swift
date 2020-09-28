//
//  BusinessAccountViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 9/24/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class BusinessAccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var startButton: UIButton!

    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.startButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
    }
    
    // MARK: - IBActions
    @IBAction private func getStarted() {
        
    }
    
    @IBAction private func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
