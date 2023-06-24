//
//  UIView+AddSubviews.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 24.06.2023.
//

import UIKit

extension UIView {

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}
