//
//  Breed.swift
//  PetStats
//
//  Created by Fabio Lindemberg on 23/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import Foundation

struct Breed: Codable {
    let id: Int
    let lifeSpan: String?
    let name: String
    let origin: String?
    let temperament: String?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case lifeSpan = "life_span"
        case name
        case origin
        case temperament
        case imageUrl
    }
}
