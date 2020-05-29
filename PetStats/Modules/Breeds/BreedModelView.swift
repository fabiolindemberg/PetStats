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
    //var id: Int { get set }
    var name: String { get set }
    var image: String { get set }
    var temperament: String { get set }
    var lifeSpan: String { get set }
    var isLoading: Bool { get set }
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
    
    private func loadImageInfo(by breadId: Int, completionHandler: @escaping (_ imageInfo: ImageInfo?)-> Void) {
        self.model.getImageInfo(by: breadId) { imageInfo, error in
            completionHandler(imageInfo)
        }
    }
    
    func breedsCount() -> Int {
        return breeds.count
    }
    
    func fillUI(index: Int, breedUI: [BreedUI]) {
        breedUI.forEach { element in
            self.fillUI(index: index, breedUI: element)
        }
    }
    
    func fillUI(index: Int, breedUI: BreedUI) {
        
        var mutableBreedUI = breedUI
        mutableBreedUI.isLoading = true
        mutableBreedUI.name = self.breeds[index].name
        mutableBreedUI.lifeSpan = adjustRange(from: self.breeds[index].lifeSpan ?? "")
        mutableBreedUI.temperament = self.breeds[index].temperament ?? ""
        
        guard self.breeds[index].imageUrl == nil else {
            mutableBreedUI.image = self.breeds[index].imageUrl ?? ""
            mutableBreedUI.isLoading = false
            return
        }
        
        self.loadImageInfo(by: self.breeds[index].id) { imageInfo in
            self.breeds[index].imageUrl = imageInfo?.url
            mutableBreedUI.image = imageInfo?.url ?? ""
            mutableBreedUI.isLoading = false
        }
    }
    
    func adjustRange(from text: String) -> String {
        return text.replacingOccurrences(of: " - ", with: "-")
            .replacingOccurrences(of: " years", with: "")
    }
}
