//
//  RoundedTab.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
//

import UIKit

@IBDesignable class TabBarWithCorners: UITabBar {
    // add button into the IB for color and radius
    @IBInspectable var color: UIColor?
    @IBInspectable var radii: CGFloat = 15.0
    // animations handling
    private var shapeLayer: CALayer?

    override func draw(_ rect: CGRect) {
        addShape()
    }
    // draw shape of the tab bar
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        shapeLayer.fillColor = color?.cgColor ?? UIColor.white.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0   , height: -3);
        shapeLayer.shadowOpacity = 0.2
        shapeLayer.shadowPath =  UIBezierPath(roundedRect: bounds, cornerRadius: radii).cgPath
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    // maths for shape
    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radii, height: 0.0))
        return path.cgPath
    }
    
    // show the tab bar
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame = self.frame
        tabFrame.size.height = 65 + (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? CGFloat.zero)
        tabFrame.origin.y = self.frame.origin.y +   ( self.frame.height - 65 - (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? CGFloat.zero))
        self.layer.cornerRadius = 20
        self.frame = tabFrame
        self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0) })
    }
    
}
