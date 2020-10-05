//
//  PriceCompareViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 9/28/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class PriceCompareViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var passMoneyLabel: UILabel!
    @IBOutlet private weak var passFromLabel: UILabel!
    @IBOutlet private weak var passToLabel: UILabel!
    
    // MARK: - Properties
    var passMoney: String?
    var passFrom: String?
    var passTo: String?
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }
    
    // MARK: - Configuration
    private func configuration() {
        guard let passMoney = self.passMoney else { return }
        guard let passFrom = self.passFrom else { return }
        guard let passTo = self.passTo else { return }
        self.passMoneyLabel.text = passMoney
        self.passFromLabel.text = passFrom
        self.passToLabel.text = passTo
    }
    
    // MARK: - IBActions
    @IBAction private func moveToSite() {
        let vc = LoadSiteViewController()
        vc.linkPath = "https://transferwise.com/gb/compare/disclaimer"
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction private func shareLink(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [" "], applicationActivities:  nil)
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            completed ? print(Constant.completed) : print(Constant.cencalled)
        }
        present(activityController, animated: true) {
            print(Constant.presented)
        }
    }
    
    @IBAction private func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PriceCompareViewController {
    enum Constant {
        static let completed = "completed"
        static let cencalled = "cencaled"
        static let presented = "presented"
    }
}
