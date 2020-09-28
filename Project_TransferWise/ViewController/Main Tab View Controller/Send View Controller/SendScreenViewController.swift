//
//  SendScreenViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 7/26/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class SendScreenViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var priceComparisonButton: UIButton!
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var recipientTextField: UITextField!
    @IBOutlet private weak var sendAmountTextField: UITextField!
    @IBOutlet private weak var currencyFirstLabel: UILabel!
    @IBOutlet private weak var currencySecondLabel: UILabel!
    @IBOutlet private weak var currentFirstImage: UIImageView!
    @IBOutlet private weak var currentSecondImage: UIImageView!
    @IBOutlet private weak var currentFirstButton: UIButton!
    @IBOutlet private weak var currentSecondButton: UIButton!
    @IBOutlet private weak var continueButton: UIButton!
    
    // MARK: - Properties
    private let fetchRate = FetchCurrency()
    private var isTagCurrentFirstButton: Bool = false
    private var countRightNumber = 0
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
        self.dismissKeyboard()
        self.editingFirstChanged()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.priceComparisonButton.customCornerButton(cornerRadius: 3, borderWidth: 1, borderColor: Constants.Color.brandBlue)
        self.topView.cornerView(cornerRadius: 3, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
        self.bottomView.cornerView(cornerRadius: 3, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
        self.continueButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.payGreen)
    }
    
    private func moveCountryScreen() {
        let vc = CountryViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func editingFirstChanged() {
        self.fetchRate.amount = self.sendAmountTextField.text
        self.fetchRate.currencyFrom = self.currencyFirstLabel.text
        self.fetchRate.currencyTo = self.currencySecondLabel.text
        self.fetchRate.fetch { currencyRate in
            guard let rates = currencyRate else { return }
            self.recipientTextField.text = String(rates.value)
        }
    }
    
    @objc func editingSecondChanged() {
        self.fetchRate.amount = self.recipientTextField.text
        self.fetchRate.currencyFrom = self.currencySecondLabel.text
        self.fetchRate.currencyTo = self.currencyFirstLabel.text
        self.fetchRate.fetch { currencyRate in
            guard let rates = currencyRate else { return }
            self.sendAmountTextField.text = String(rates.value)
        }
    }
    
    // MARK: - IBActions
    @IBAction private func sendFirstValue() {
        self.sendAmountTextField.addTarget(self, action: #selector(self.editingFirstChanged), for: .editingChanged)
    }
    
    @IBAction private func sendSecondValue() {
        self.recipientTextField.addTarget(self, action: #selector(self.editingSecondChanged), for: .editingChanged)
    }
    
    @IBAction private func close() {
        self.dismiss(animated: true)
    }
    
    @IBAction private func continueTo() {
        let vc = AddRecipientViewController()
        vc.name = "Who are you sending to?"
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction private func getCountryFrom(_ sender: UIButton) {
        self.isTagCurrentFirstButton = true
        self.moveCountryScreen()
    }
    
    @IBAction private func getCountryTo(_ sender: UIButton) {
        self.isTagCurrentFirstButton = false
        self.moveCountryScreen()
    }
}

// MARK: - Delegate set country code
extension SendScreenViewController: SetCountryCodeDelegate {
    func setCountryCode(image: UIImage, code: String, country: String) {
        if self.isTagCurrentFirstButton {
            print(self.isTagCurrentFirstButton)
            self.currentFirstImage.image = image
            self.currencyFirstLabel.text = code
            self.editingFirstChanged()
        } else {
            print(self.isTagCurrentFirstButton)
            self.currentSecondImage.image = image
            self.currencySecondLabel.text = code
            self.editingSecondChanged()
        }
    }
}


