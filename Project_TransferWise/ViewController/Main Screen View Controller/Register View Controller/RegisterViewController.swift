//
//  RegisterViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 8/23/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var mailTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var eyeButton: UIButton!
    @IBOutlet private weak var passwordLineView: UIView!
    @IBOutlet private weak var mailLineView: UIView!
    @IBOutlet private weak var registerButton: UIButton!
    
    // MARK: - Properties
    var alert = UIAlertController()
    private var isSecureTextEntryPassword = true

    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        self.configuration()
        self.changeLineColors()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.mailTextfield.attributedPlaceholder = NSAttributedString(string: "Your email", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.passwordTextfield.attributedPlaceholder = NSAttributedString(string: "Choose a password", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        self.registerButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
        self.eyeButton.isHidden = true
        self.passwordTextfield.delegate = self
        self.mailTextfield.delegate = self
    }
    
    private func showAlert() {
        self.alert = UIAlertController(title: "Can't save", message: "Please fill in all fields", preferredStyle: UIAlertController.Style.alert)
        present(self.alert, animated: true)
    }
    
    private func dismissAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.alert.dismiss(animated: true, completion: nil)
        })
    }
    
    private func alertPasword() {
        self.alert = UIAlertController(title: "Info", message: "Password must be more than 6, or mail format is wrong", preferredStyle: UIAlertController.Style.alert)
        present(self.alert, animated: true)
    }
    
    // MARK: - IBActions
    @IBAction private func chandeColorMail() {
        self.mailLineView.backgroundColor = Constants.Color.brandBlue
        self.eyeButton.isHidden = true
        if self.passwordTextfield.text != "" {
            self.passwordLineView.backgroundColor = Constants.Color.brandBlue
            self.eyeButton.isHidden = false
        } else {
            self.passwordLineView.backgroundColor = Constants.Color.keylineGrey
            self.eyeButton.isHidden = true
        }
    }
    
    @IBAction private func chandeColorPassword() {
        self.eyeButton.isHidden = false
        self.passwordLineView.backgroundColor = Constants.Color.brandBlue
        if mailTextfield.text != "" {
            self.mailLineView.backgroundColor = Constants.Color.brandBlue
        } else {
            self.mailLineView.backgroundColor = Constants.Color.keylineGrey
        }
    }
    
    @IBAction private func register() {
        guard let email = self.mailTextfield.text?.isNotEmpty,
            let password = self.passwordTextfield.text?.isNotEmpty else {
            self.showAlert()
            self.dismissAlert()
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                print("Register")
                let vc = MainTabViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } else {
                self.alertPasword()
                self.dismissAlert()
            }
        }
    }
    
    @IBAction private func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func showPassword(_ sender: Any) {
        if self.isSecureTextEntryPassword {
            self.eyeButton.setImage(UIImage(named: "opened_eye"), for: .normal)
            self.passwordTextfield.isSecureTextEntry = false
            self.isSecureTextEntryPassword = false
        } else {
            self.eyeButton.setImage(UIImage(named: "closed_eye"), for: .normal)
            self.passwordTextfield.isSecureTextEntry = true
            self.isSecureTextEntryPassword = true
        }
    }
}

extension String {
    var isNotEmpty: String? {
        if self.isEmpty { return nil }
        return self
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.mailTextfield:
            self.passwordTextfield.becomeFirstResponder()
            self.eyeButton.isHidden = false
            self.passwordLineView.backgroundColor = Constants.Color.brandBlue
        default:
            self.passwordTextfield.resignFirstResponder()
            self.register()
        }
        return false
    }
}

extension RegisterViewController {
    func changeLineColors() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.changeColor)))
    }
    
    @objc func changeColor(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
        }
        if self.mailTextfield.text != "" { self.mailLineView.backgroundColor = Constants.Color.brandBlue }
        else { self.mailLineView.backgroundColor = Constants.Color.keylineGrey }
        if self.passwordTextfield.text != "" {
            self.eyeButton.isHidden = false
            self.passwordLineView.backgroundColor = Constants.Color.brandBlue
        }
        else {
            self.eyeButton.isHidden = true
            self.passwordLineView.backgroundColor = Constants.Color.keylineGrey }
    }
}
