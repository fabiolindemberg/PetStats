//
//  CollectionViewCell.swift
//  PetStats
//
//  Created by Fabio Lindemberg on 23/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell, BreedUI {
        
    @IBOutlet weak var lblBreed: UILabel!
    @IBOutlet weak var lblTemperament: UILabel!
    @IBOutlet weak var lblLifeSpan: UILabel!
    @IBOutlet weak var imgDog: UIImageView!
    @IBOutlet weak var vwGradientAlpha: UIView!
    
    var id: Int = 0 {
        didSet {
            if id > 0 {
                
                BreedModel().getImageInfo(by: id) { imageInfo, error in
                    
                    guard error == nil else {
                        return
                    }
                    
                    if let url = imageInfo?.url {
                        self.image = url
                    }
                }
            }
        }
    }
    
    var name: String = "" {
        didSet {
            lblBreed.text = name
        }
    }
    
    var image: String = "" {
        didSet {
        
            if let url = URL(string: image) {
                DispatchQueue.main.async {
                    self.imgDog.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "dog-placeholder"), options: [], context: nil)
                    self.vwGradientAlpha.setAlphaGradientLayer()
                    self.layer.cornerRadius = 10
                    self.vwGradientAlpha.layer.cornerRadius = 10
                    self.imgDog.setShadow()
                }
            }
        }
    }
    
    var temperament: String = "" {
        didSet {
            lblTemperament.text = temperament
        }
    }
    
    var lifeSpan: String = "" {
        didSet {
            lblLifeSpan.text = lifeSpan
        }
    }
    

}

