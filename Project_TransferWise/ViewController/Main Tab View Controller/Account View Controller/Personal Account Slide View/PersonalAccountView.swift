//
//  PersonalAccountView.swift
//  Project_TransferWise
//
//  Created by Tiko on 8/21/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

protocol PersonalAccountDelegate: class {
    func movePersonalAccount()
    func moveBusinessAccount()
}

class PersonalAccountView: UIView {
    
    // MARK: - @IBOutlets
    @IBOutlet private weak var viewLine: UIView!
    @IBOutlet private weak var personalView: UIView!
    @IBOutlet private weak var businessView: UIView!
    
    // MARK: - Properties
    weak var delegate: PersonalAccountDelegate?
    
    // MARK: - View LifeCyrcle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configuration()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        self.viewLine.cornerView(cornerRadius: 2, borderWidth: 0.1, borderColor: Constants.Color.disabledGrey)
        let heightPersonal = self.personalView.frame.size.height
        let heightBusiness = self.businessView.frame.size.height
        self.personalView.cornerView(cornerRadius: heightPersonal/2, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
        self.businessView.cornerView(cornerRadius: heightBusiness/2, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
    }
    
    // MARK: - IBActions
    @IBAction private func personalAccout() {
        self.delegate?.movePersonalAccount()
    }
    
    @IBAction private func businessAccount() {
        self.delegate?.moveBusinessAccount()
    }
}
