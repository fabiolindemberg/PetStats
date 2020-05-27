//
//  ViewController.swift
//  PetStats
//
//  Created by Fabio Lindemberg on 21/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import UIKit
import SDWebImage

class BreedViewController: UIViewController {

    @IBOutlet weak var imgDog: UIImageView!
    @IBOutlet weak var vwGradientAlpha: UIView!
    @IBOutlet weak var cvBreeds: UICollectionView!
    
    var modelView = BreedModelView(model: BreedModel())
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.vwGradientAlpha.setAlphaGradientLayer()
        
        modelView.delegate = self
        
        cvBreeds.dataSource = self
        cvBreeds.delegate = self
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
        modelView.fillUI(index: indexPath.row, breadUI: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.15) {
            self.imgDog.alpha = 0
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        imgDog.image = cell.imgDog.image
        
        UIView.animate(withDuration: 0.15) {
            self.imgDog.alpha = 1
        }
    }
}
