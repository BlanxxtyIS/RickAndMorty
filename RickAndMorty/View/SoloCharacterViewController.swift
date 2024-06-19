//
//  SoloCharacterViewController.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 19.06.2024.
//

import UIKit

class SoloCharacterViewController: UIViewController {
    
    let soloCharacterManager = RickAndMortyManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soloCharacterManager.soloDelegate = self
        soloCharacterManager.getCharacters(characterModel: .solo)
    }
}

extension SoloCharacterViewController: RickAndMortySoloDelegate {
    func getSoloCharacter(_ character: [SoloCharacterModel]) {
        print(character.first?.name)
    }
}
