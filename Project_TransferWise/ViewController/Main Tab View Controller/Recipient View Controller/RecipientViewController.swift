//
//  RecipientViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 8/1/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class RecipientViewController: UIViewController {
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction private func add() {
        let vc = AddRecipientViewController()
        vc.name = "Add a recipient"
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true)
    }
}
