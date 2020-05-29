//
//  ViewController.swift
//  PetStats
//
//  Created by Fabio Lindemberg on 21/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import UIKit
import SDWebImage

class BreedViewController: UIViewController, BreedUI {

    @IBOutlet weak var imgDog: UIImageView!
    @IBOutlet weak var vwGradientAlpha: UIView!
    @IBOutlet weak var cvBreeds: UICollectionView!
    @IBOutlet weak var sldLogevity: UISlider!
    
    var modelView = BreedModelView(model: BreedModel())
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.vwGradientAlpha.setAlphaGradientLayer()
        
        modelView.delegate = self
        
        cvBreeds.dataSource = self
        cvBreeds.delegate = self
        imgDog.alpha = 0
    }
    
    // ----------------------
    // MARK: BreedUI delegate
    // ----------------------
    var name: String = ""
    var image: String = "" {
        didSet {
            if let url = URL(string: image) {
                DispatchQueue.main.async {
                    self.imgDog.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "dog-placeholder"), options: [], context: nil)
                }
            }
        }
    }
    
    var temperament: String = ""
    
    var lifeSpan: String = "" {
        didSet {
            let range = lifeSpan.split(separator: "-")
            sldLogevity.value = Float(range.last ?? "10") ?? 10.0
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    UIView.animate(withDuration: 0.15) {
                        self.imgDog.alpha = 0
                    }
                } else {
                    UIView.animate(withDuration: 0.15) {
                        self.imgDog.alpha = 1
                    }
                }
            }
        }
    }
}

extension BreedViewController: ModelViewDelegate {
    func fail(message: String) {
        print(message)
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.cvBreeds.reloadData()
        }
    }
}

extension BreedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelView.breedsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        if indexPath.row == 0 {
            modelView.fillUI(index: indexPath.row, breedUI: [self, cell])
        } else {
            modelView.fillUI(index: indexPath.row, breedUI: cell)
        }
        
        return cell
    }
    
    fileprivate func updateMainInfo(_ cell: CollectionViewCell) {
        imgDog.image = cell.imgDog.image
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        modelView.fillUI(index: indexPath.row, breedUI: self)
    }
}
