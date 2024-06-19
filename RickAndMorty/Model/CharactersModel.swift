//
//  RickAndMortyModel.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 18.06.2024.
//

import UIKit

struct CharactersModel {
    let image: UIImage
    let name: String
    let status: String
    
    init(image: UIImage, name: String, status: String) {
        self.image = image
        self.name = name
        self.status = status
    }
}


