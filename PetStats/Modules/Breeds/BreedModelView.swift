//
//  ModelView.swift
//  PetStats
//
//  Created by Fabio Lindemberg on 23/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import Foundation

protocol ModelViewDelegate {
    func fail(message: String)
    func updateUI()
}

protocol BreedUI {
    var id: Int { get set }
    var name: String { get set }
    var image: String { get set }
    var temperament: String { get set }
    var lifeSpan: String { get set }
}

class BreedModelView {
    
    var delegate: ModelViewDelegate?
    private var breeds: [Breed] = []
    private var model: BreedModel
    
    init(model: BreedModel) {
        self.model = model
        loadData()
    }
    
    private func loadData() {
        self.model.getBreeds() { breeds, error in
            guard error == nil else {
                self.delegate?.fail(message: error!.localizedDescription)
                return
            }
            
            self.breeds = breeds
            self.delegate?.updateUI()
        }
    }
    
    func breedsCount() -> Int {
        return breeds.count
    }
    
    func fillUI(index: Int, breadUI: BreedUI) {
        let breed = self.breeds[index]
        
        var breedUI = breadUI
        breedUI.id = breed.id
        breedUI.name = breed.name
//        breedUI.image = breed.imageUrl ?? ""
        breedUI.lifeSpan = breed.lifeSpan ?? ""
        breedUI.temperament = breed.temperament ?? ""
    }
    
}
