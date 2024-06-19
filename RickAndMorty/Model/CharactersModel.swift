//
//  RickAndMortyModel.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 18.06.2024.
//

import UIKit

struct CharactersModel {
    let id: Int
    let image: UIImage
    let name: String
    let status: String
    
    init(id: Int, image: UIImage, name: String, status: String) {
        self.id = id
        self.image = image
        self.name = name
        self.status = status
    }
}


