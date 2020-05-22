//
//  ViewController.swift
//  PetStats
//
//  Created by Fabio Lindemberg on 21/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var vwGradientAlpha: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setGradientLayer()
    }

    private func setGradientLayer() {
        
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 0.9)
        gradient.colors = [UIColor.black.withAlphaComponent(0.0).cgColor, UIColor.black.cgColor]
        gradient.type = .axial
        gradient.frame = vwGradientAlpha.bounds
        vwGradientAlpha.layer.addSublayer(gradient)
    }
}

