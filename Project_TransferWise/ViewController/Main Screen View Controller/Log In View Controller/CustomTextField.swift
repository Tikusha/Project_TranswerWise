//
//  CustomTextField.swift
//  Project_TransferWise
//
//  Created by Tiko on 8/24/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    // MARK: - Properties
    private var customLabel: UILabel!
    
    @IBInspectable
    private var _placeholder: String?
    
    @IBInspectable
    private var floatingLabelBackground: UIColor = UIColor.white.withAlphaComponent(1) {
        didSet {
            self.customLabel.backgroundColor = self.floatingLabelBackground
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    private var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            self.customLabel.font = self.floatingLabelFont
            self.font = self.floatingLabelFont
            self.setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder
        placeholder = self._placeholder
        self.customLabel = UILabel(frame: CGRect.zero)
        self.addTarget(self, action: #selector(self.addLabel), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.removeLabel), for: .editingDidEnd)
    }
    
    @objc func addLabel() {
        if self.text == "" {
            self.customLabel.textColor = Constants.Color.brandBlue
            self.customLabel.font = floatingLabelFont
            self.customLabel.text = self._placeholder
            self.customLabel.layer.backgroundColor = UIColor.white.cgColor
            self.customLabel.translatesAutoresizingMaskIntoConstraints = false
            self.customLabel.clipsToBounds = true
            self.customLabel.frame = CGRect(x: 0, y: 0, width: customLabel.frame.width + 7, height: customLabel.frame.height + 5)
            self.customLabel.textAlignment = .center
            self.addSubview(self.customLabel)
            
            self.customLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive = true 
            self.placeholder = ""
        }
        
        self.bringSubviewToFront(subviews.last!)
        self.setNeedsDisplay()
    }
    
    @objc func removeLabel() {
        if self.text == "" {
            UIView.animate(withDuration: 0.3) {
                self.subviews.forEach{ $0.removeFromSuperview() }
                self.setNeedsDisplay()
            }
            self.placeholder = self._placeholder
        }
        self.layer.borderColor = UIColor.black.cgColor
    }
}
