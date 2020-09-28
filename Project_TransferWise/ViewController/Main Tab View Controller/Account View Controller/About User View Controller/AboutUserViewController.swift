//
//  AboutUserViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 9/17/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

protocol CloseScreanDelegate {
    func closeScreen()
}

class AboutUserViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var firstnameTextfield: UITextField!
    @IBOutlet private weak var lastnameTextfield: UITextField!
    @IBOutlet private weak var addressTextfield: UITextField!
    @IBOutlet private weak var cityTextfield: UITextField!
    @IBOutlet private weak var postCodeTextfield: UITextField!
    @IBOutlet private weak var dayTextfield: UITextField!
    @IBOutlet private weak var monthTextfield: UITextField!
    @IBOutlet private weak var yearTextfield: UITextField!
    @IBOutlet private weak var firstnameLineView: UIView!
    @IBOutlet private weak var lastnameLineView: UIView!
    @IBOutlet private weak var addressLineView: UIView!
    @IBOutlet private weak var cityLineView: UIView!
    @IBOutlet private weak var postCodeLineView: UIView!
    @IBOutlet private weak var dayLineView: UIView!
    @IBOutlet private weak var monthLineView: UIView!
    @IBOutlet private weak var yearLineView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var saveButton: UIButton!
    
    // MARK: - Properties
    var delegate: CloseScreanDelegate?
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
        self.changeLineColors()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.firstnameTextfield.attributedPlaceholder = NSAttributedString(string: "First name", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.lastnameTextfield.attributedPlaceholder = NSAttributedString(string: "Last name", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.addressTextfield.attributedPlaceholder = NSAttributedString(string: "Address", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.cityTextfield.attributedPlaceholder = NSAttributedString(string: "City", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.postCodeTextfield.attributedPlaceholder = NSAttributedString(string: "Post code", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.dayTextfield.attributedPlaceholder = NSAttributedString(string: "DD", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.monthTextfield.attributedPlaceholder = NSAttributedString(string: "MM", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.yearTextfield.attributedPlaceholder = NSAttributedString(string: "YYYY", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.saveButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
        self.firstnameTextfield.delegate = self
        self.lastnameTextfield.delegate = self
        self.addressTextfield.delegate = self
        self.cityTextfield.delegate = self
        self.postCodeTextfield.delegate = self
    }
    
    // MARK: - IBActions
    @IBAction private func chandeColorFirstname() {
        self.colorChangesOfLine()
        self.firstnameLineView.backgroundColor = Constants.Color.brandBlue
    }
    
    @IBAction private func chandeColorLastname() {
        self.colorChangesOfLine()
        self.lastnameLineView.backgroundColor = Constants.Color.brandBlue
    }
    
    @IBAction private func chandeColorAddress() {
        self.colorChangesOfLine()
        self.addressLineView.backgroundColor = Constants.Color.brandBlue
    }
    
    @IBAction private func chandeColorCity() {
        self.colorChangesOfLine()
        self.cityLineView.backgroundColor = Constants.Color.brandBlue
    }
    
    @IBAction private func chandeColorPostCode() {
        self.colorChangesOfLine()
        self.postCodeLineView.backgroundColor = Constants.Color.brandBlue
    }
    
    @IBAction private func chandeColorDay() {
        self.colorChangesOfLine()
        self.dayLineView.backgroundColor = Constants.Color.brandBlue
    }
    
    @IBAction private func chandeColorMonth() {
        self.colorChangesOfLine()
        self.monthLineView.backgroundColor = Constants.Color.brandBlue
    }
    
    @IBAction private func chandeColorYear() {
        self.colorChangesOfLine()
        self.yearLineView.backgroundColor = Constants.Color.brandBlue
    }
    
    @IBAction private func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.closeScreen()
    }
    
    @IBAction private func save() {
        if self.firstnameTextfield.text == "" ||
            self.lastnameTextfield.text == "" ||
            self.addressTextfield.text == "" ||
            self.cityTextfield.text == "" ||
            self.postCodeTextfield.text == "" ||
            self.dayTextfield.text == "" ||
            self.monthTextfield.text == "" ||
            self.yearTextfield.text == "" {
            let alert = UIAlertController(title: "Check your details", message: "Please check that all fields are filled in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Save", message: "Your data is saved.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension AboutUserViewController {
    func changeLineColors() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.changeColor)))
    }
    
    @objc func changeColor(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
        }
        self.colorChangesOfLine()
    }
}

extension AboutUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.firstnameTextfield:
            self.lastnameTextfield.becomeFirstResponder()
            self.lastnameLineView.backgroundColor = Constants.Color.brandBlue
        case self.lastnameTextfield:
            self.addressTextfield.becomeFirstResponder()
            self.addressLineView.backgroundColor = Constants.Color.brandBlue
        case self.addressTextfield:
            self.cityTextfield.becomeFirstResponder()
            self.cityLineView.backgroundColor = Constants.Color.brandBlue
        case self.cityTextfield:
            self.postCodeTextfield.becomeFirstResponder()
            self.postCodeLineView.backgroundColor = Constants.Color.brandBlue
        case self.postCodeTextfield:
            self.dayTextfield.becomeFirstResponder()
            self.dayLineView.backgroundColor = Constants.Color.brandBlue
        default:
            self.dayTextfield.resignFirstResponder()
        }
        return true
    }
}

extension AboutUserViewController {
    private func colorChangesOfLine() {
        if self.firstnameTextfield.text != "" { self.firstnameLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.firstnameLineView.backgroundColor = Constants.Color.keylineGrey }
        
        if self.lastnameTextfield.text != "" { self.lastnameLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.lastnameLineView.backgroundColor = Constants.Color.keylineGrey }
        
        if self.addressTextfield.text != "" { self.addressLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.addressLineView.backgroundColor = Constants.Color.keylineGrey }
        
        if self.cityTextfield.text != "" { self.cityLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.cityLineView.backgroundColor = Constants.Color.keylineGrey }
        
        if self.postCodeTextfield.text != "" { self.postCodeLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.postCodeLineView.backgroundColor = Constants.Color.keylineGrey }
        
        if self.dayTextfield.text != "" { self.dayLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.postCodeLineView.backgroundColor = Constants.Color.keylineGrey }
        
        if self.monthTextfield.text != "" { self.monthLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.monthLineView.backgroundColor = Constants.Color.keylineGrey }
        
        if self.yearTextfield.text != "" { self.yearLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.yearLineView.backgroundColor = Constants.Color.keylineGrey }
    }
}
