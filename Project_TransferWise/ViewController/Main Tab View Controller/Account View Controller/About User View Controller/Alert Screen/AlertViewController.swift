//
//  AlertViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 9/17/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var lineView: UIView!

    // MARK:  - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.lineView.cornerView(cornerRadius: 10, borderWidth: 0.7, borderColor: Constants.Color.keylineGrey)
    }
    
    // MARK: - IBActions
    @IBAction private func ok(_ sender: Any) {
        dismiss(animated: true)
    }
}
