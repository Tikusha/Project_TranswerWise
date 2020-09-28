//
//  BusinessViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 9/22/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class BusinessViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var iBANTextField: UITextField!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var mailLineView: UIView!
    @IBOutlet private weak var nameLineView: UIView!
    @IBOutlet private weak var iBANLineView: UIView!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var currencyImage: UIImageView!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var segmanetControl: UISegmentedControl!
    
    // MARK: - Properties
    var name: String?
    var nameButton: String?
    var colorButton: UIColor?
    private var alert = UIAlertController()
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
        self.dismissKeyboard()
        self.changeLineColors()
        self.setSegmantColor()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.titleLabel.text = name
        self.addButton.setTitle(nameButton, for: .normal)
        self.addButton.backgroundColor = colorButton
        self.mailTextField.delegate = self
        self.nameTextField.delegate = self
        self.iBANTextField.delegate = self
        self.mailTextField.attributedPlaceholder = NSAttributedString(string: "Recient's email (optional)", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.nameTextField.attributedPlaceholder = NSAttributedString(string: "Your Name of business / charity", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.iBANTextField.attributedPlaceholder = NSAttributedString(string: "IBAN", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.addButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
    }
    
    private func setSegmantColor() {
        let titleTextAttributeFirst = [NSAttributedString.Key.foregroundColor: Constants.Color.brandBlue]
        self.segmanetControl.setTitleTextAttributes(titleTextAttributeFirst, for:.normal)
        let titleTextAttributeSecond = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.segmanetControl.setTitleTextAttributes(titleTextAttributeSecond, for:.selected)
    }
    
    private func emptyFieldsAlert() {
        self.alert = UIAlertController(title: "Can't save", message: "Please fill in all fields", preferredStyle: UIAlertController.Style.alert)
        present(alert, animated: true)
    }
    
    private func addDataAlert() {
        self.alert = UIAlertController(title: "Save", message: "Your data is saved", preferredStyle: UIAlertController.Style.alert)
        present(alert, animated: true)
    }
    
    private func dismissAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.alert.dismiss(animated: true, completion: nil)
        })
    }
    
    @objc private func setUpperCaseString(textField: UITextField) {
        textField.text = textField.text?.uppercased()
    }
    
    // MARK: - IBActions
    @IBAction private func currency() {
        let vc = CountryViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func add() {
        if self.mailTextField.text == "" ||
            self.nameTextField.text == "" ||
            self.iBANTextField.text == "" {
            self.emptyFieldsAlert()
            self.dismissAlert()
        } else {
            self.addDataAlert()
            self.dismissAlert()
        }
    }
    
    @IBAction private func chandeColorMail() {
        self.mailLineView.backgroundColor = Constants.Color.brandBlue
        
        if self.nameTextField.text != "" { self.nameLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.nameLineView.backgroundColor = Constants.Color.keylineGrey }
       
        if self.iBANTextField.text != "" {  self.iBANLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.iBANLineView.backgroundColor = Constants.Color.keylineGrey }
    }
    
    @IBAction private func chandeColorHoldName() {
        self.nameLineView.backgroundColor = Constants.Color.brandBlue
        
        if self.iBANTextField.text != "" {  self.iBANLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.iBANLineView.backgroundColor = Constants.Color.keylineGrey }
        
        if self.mailTextField.text != "" { self.mailLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.mailLineView.backgroundColor = Constants.Color.keylineGrey }
    }
    
    @IBAction private func chandeColorIBAN() {
        self.iBANLineView.backgroundColor = Constants.Color.brandBlue
        
        if self.nameTextField.text != "" { self.nameLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.nameLineView.backgroundColor = Constants.Color.keylineGrey }
        
        if self.mailTextField.text != "" { self.mailLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.mailLineView.backgroundColor = Constants.Color.keylineGrey }
        self.iBANTextField.addTarget(self, action: #selector(setUpperCaseString), for: .editingChanged)
    }
}

extension BusinessViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.mailTextField:
            self.nameTextField.becomeFirstResponder()
            self.nameLineView.backgroundColor = Constants.Color.brandBlue
        case self.nameTextField:
            self.iBANTextField.becomeFirstResponder()
            self.iBANLineView.backgroundColor = Constants.Color.brandBlue
        default:
            self.iBANTextField.resignFirstResponder()
        }
        return true
    }
}

extension BusinessViewController: SetCountryCodeDelegate {
    func setCountryCode(image: UIImage, code: String, country: String) {
        self.currencyImage.image = image
        self.countryLabel.text = "\(code) - \(country)"
    }
}

extension BusinessViewController {
    func changeLineColors() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.changeColor)))
    }
    
    @objc func changeColor(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
            if self.nameTextField.text != "" { self.nameLineView.backgroundColor = Constants.Color.brandBlue }
            else { self.nameLineView.backgroundColor = Constants.Color.keylineGrey }
           
            if self.iBANTextField.text != "" {  self.iBANLineView.backgroundColor = Constants.Color.brandBlue }
            else { self.iBANLineView.backgroundColor = Constants.Color.keylineGrey }
            
            if self.mailTextField.text != "" { self.mailLineView.backgroundColor = Constants.Color.brandBlue }
            else { self.mailLineView.backgroundColor = Constants.Color.keylineGrey }
        }
    }
}

