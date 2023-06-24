//
//  AppTabBar.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 23.06.2023.
//

//import UIKit
//
//final class AppTabBar: UITabBar {
//
//    private var shapeLayer: CALayer?
//
//    override func draw(_ rect: CGRect) {
//        self.addShape()
//    }
//
//    private func addShape() {
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.strokeColor = UIColor.tabBarBackground.cgColor
//        shapeLayer.fillColor = UIColor.tabBarBackground.cgColor
//        shapeLayer.lineWidth = 2.0
//
//        if let oldShapeLayer = self.shapeLayer {
//            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
//        } else {
//            self.layer.insertSublayer(shapeLayer, at: 0)
//        }
//
//        self.shapeLayer = shapeLayer
//    }
//}
//
//extension UITabBar {
//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//        var sizeThatFits = super.sizeThatFits(size)
//        sizeThatFits.height = 83
//        return sizeThatFits
//    }
//}
