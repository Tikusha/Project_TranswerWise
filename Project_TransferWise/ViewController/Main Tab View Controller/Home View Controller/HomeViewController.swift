//
//  ActivityViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 7/19/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var openButton: UIButton!
    @IBOutlet private weak var transactionView: UIView!

    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.openButton.customCornerButton(cornerRadius: 10, borderWidth: 0.2, borderColor: .gray)
        self.transactionView.layer.cornerRadius = 10
    }
    
    // MARK: - IBActions
    @IBAction private func openBalance() {
        self.present(SetUpBalanceViewController(), animated: true)
    }
}
