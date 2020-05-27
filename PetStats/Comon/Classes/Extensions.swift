//
//  Extensions.swift
//  PetStats
//
//  Created by Fabio Lindemberg on 22/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import UIKit

extension CAGradientLayer {

    enum Point {
        case topLeft
        case centerLeft
        case bottomLeft
        case topCenter
        case center
        case bottomCenter
        case topRight
        case centerRight
        case bottomRight

        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .centerLeft:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeft:
                return CGPoint(x: 0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottomCenter:
                return CGPoint(x: 0.5, y: 1.0)
            case .topRight:
                return CGPoint(x: 1.0, y: 0.0)
            case .centerRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }

    convenience init(start: Point, end: Point, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}

extension UIView {
    func setAlphaGradientLayer() {
        
        let defaulCollor: UIColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 0.9)
        gradient.colors = [defaulCollor.withAlphaComponent(0.0).cgColor, defaulCollor.cgColor]
        gradient.type = .axial
        gradient.frame = self.bounds
        self.layer.addSublayer(gradient)
    }
    
    func setShadow(fillColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cornerRadius: CGFloat = 10) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.masksToBounds = false

        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3
        layer.cornerRadius = cornerRadius
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }

}
