//
//  MyselfViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 9/25/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class MyselfViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var iBANTextField: UITextField!
    @IBOutlet private weak var holdNameLineView: UIView!
    @IBOutlet private weak var iBANLineView: UIView!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var segmanetControl: UISegmentedControl!
    
    // MARK: - Properties
    private var alert = UIAlertController()
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
        self.setSegmantColor()
        self.changeLineColors()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.nameTextField.delegate = self
        self.iBANTextField.delegate = self
        self.nameTextField.attributedPlaceholder = NSAttributedString(string: "Account holder name", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.iBANTextField.attributedPlaceholder = NSAttributedString(string: "IBAN", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.continueButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.payGreen)
    }
    
    private func setSegmantColor() {
        let titleTextAttributeFirst = [NSAttributedString.Key.foregroundColor: Constants.Color.brandBlue]
        self.segmanetControl.setTitleTextAttributes(titleTextAttributeFirst, for:.normal)
        let titleTextAttributeSecond = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.segmanetControl.setTitleTextAttributes(titleTextAttributeSecond, for:.selected)
    }
    
    private func emptyFieldsAlert() {
        self.alert = UIAlertController(title: "Can't save", message: "Name is missing Value for IBAN is missing", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func dismissAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.alert.dismiss(animated: true, completion: nil)
        })
    }
    
    private func continueAlert() {
        self.alert = UIAlertController(title: "Save", message: "Your data is saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func setUpperCaseString(textField: UITextField) {
        textField.text = textField.text?.uppercased()
    }
    
    // MARK: - IBActions
    @IBAction private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func continueTo() {
        if self.nameTextField.text == "" ||
            self.iBANTextField.text == "" {
            self.emptyFieldsAlert()
            self.dismissAlert()
        } else {
            self.continueAlert()
        }
    }
    
    @IBAction private func chandeColorHoldName() {
        self.holdNameLineView.backgroundColor = Constants.Color.brandBlue
        if iBANTextField.text != "" {
            self.iBANLineView.backgroundColor = Constants.Color.brandBlue
        } else {
            self.iBANLineView.backgroundColor = Constants.Color.keylineGrey
        }
    }
    
    @IBAction private func chandeColorIBAN() {
        self.iBANLineView.backgroundColor = Constants.Color.brandBlue
        if nameTextField.text != "" {
            self.holdNameLineView.backgroundColor = Constants.Color.brandBlue
        } else {
            self.holdNameLineView.backgroundColor = Constants.Color.keylineGrey
        }
        self.iBANTextField.addTarget(self, action: #selector(setUpperCaseString), for: .editingChanged)
    }
}

extension MyselfViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.nameTextField:
            self.iBANTextField.becomeFirstResponder()
            self.iBANLineView.backgroundColor = Constants.Color.brandBlue
        default:
            self.iBANTextField.resignFirstResponder()
        }
        return true
    }
}

extension MyselfViewController {
    func changeLineColors() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.changeColor)))
    }
    
    @objc func changeColor(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
            sender.cancelsTouchesInView = false
            if nameTextField.text != "" { self.holdNameLineView.backgroundColor = Constants.Color.brandBlue}
            else { self.holdNameLineView.backgroundColor = Constants.Color.keylineGrey }
            
            if iBANTextField.text != "" { self.iBANLineView.backgroundColor = Constants.Color.brandBlue }
            else { self.iBANLineView.backgroundColor = Constants.Color.keylineGrey }
        }
    }
}
