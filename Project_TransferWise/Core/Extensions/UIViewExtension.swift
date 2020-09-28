//
//  UIViewExtension.swift
//  Project_TransferWise
//
//  Created by Tiko on 7/26/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Round corners
    func cornerView(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = false
    }
}

extension UIView {
    
    // MARK: - Round top corners
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIView {
    
    func anchorConstraints(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, pedding: UIEdgeInsets = .zero) {
        topAnchor.constraint(equalTo: top, constant: pedding.top).isActive = true
        trailingAnchor.constraint(equalTo: trailing, constant: pedding.right).isActive = true
        bottomAnchor.constraint(equalTo: bottom, constant: pedding.bottom).isActive = true
        leadingAnchor.constraint(equalTo: leading, constant: pedding.left).isActive = true
    }
    
    func anchorConstraints(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor) {
        topAnchor.constraint(equalTo: top).isActive = true
        trailingAnchor.constraint(equalTo: trailing).isActive = true
        bottomAnchor.constraint(equalTo: bottom).isActive = true
        leadingAnchor.constraint(equalTo: leading).isActive = true
    }
}
