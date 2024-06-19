//
//  SoloCharacterModel.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 19.06.2024.
//

import UIKit

struct SoloCharacterModel {
    
    let name: String
    let image: UIImage
    let status: String
    let gender: Gender
    let type: String
    let species: Species
    
    init(name: String, image: UIImage, status: String, gender: Gender, type: String, species: Species) {
        self.name = name
        self.image = image
        self.status = status
        self.gender = gender
        self.type = type
        self.species = species
    }
}
