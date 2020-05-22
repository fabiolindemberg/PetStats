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
        config()
        // Do any additional setup after loading the view.
    }

    func config() {
        
//        let gradient = CAGradientLayer(start: .topLeft, end: .bottomRight, colors: [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.withAlphaComponent(1).cgColor], type: .axial)
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.colors = [UIColor.black.withAlphaComponent(0.0).cgColor, UIColor.black.withAlphaComponent(0.9).cgColor]
        gradient.type = .axial
        gradient.frame = vwGradientAlpha.bounds
        vwGradientAlpha.layer.addSublayer(gradient)
    }
}

