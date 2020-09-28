//
//  UIVIewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 8/2/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

extension UIViewController {
 
    func loadSlide(sliderBackground: UIView?, slider: UIView?, slideHeight: CGFloat) {
        slider?.backgroundColor = .white
        
        // Create shadow layer
        sliderBackground?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Presentation shadew layer
        UIApplication.shared.keyWindow?.addSubview(sliderBackground!)
        
        // Placement of slider
        
        slider?.frame.origin.y = self.view.frame.size.height
        slider?.frame.size.height = slideHeight
        slider?.frame.size.width = self.view.frame.size.width
        
        // Presentation of viewSelector
        UIApplication.shared.keyWindow?.addSubview(slider!)
        UIView.animate(withDuration: 0.5) {
            slider?.frame.origin.y = self.view.frame.size.height - slideHeight
        }
    }
}

extension UIViewController {
    func dismissKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
}


