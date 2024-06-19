//
//  Services.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 18.06.2024.
//

import UIKit

enum CharacterModelType {
    case characters
    case solo
}

protocol RickAndMortyCharactersDelegate: AnyObject {
    func getAllCharcters(_ character: [CharactersModel])
}

protocol RickAndMortySoloDelegate: AnyObject {
    func getSoloCharacter(_ character: [SoloCharacterModel])
}

class RickAndMortyManager {
    
    weak var delegate: RickAndMortyCharactersDelegate?
    weak var soloDelegate: RickAndMortySoloDelegate?
    
    let url = "https://rickandmortyapi.com/api/character"
    
    func getCharacters(characterModel: CharacterModelType) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Ошибка при загрузке: \(error.localizedDescription)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode) {
                    print(response.debugDescription)
                }
                
                if let safeData = data {
                    switch characterModel {
                    case .characters:
                        if let model = self.parseJSONCharacters(safeData) {
                            self.delegate?.getAllCharcters(model)
                        }
                    case .solo:
                        if let model = self.parseJSONSolo(safeData) {
                            self.soloDelegate?.getSoloCharacter(model)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSONCharacters(_ data: Data) -> [CharactersModel]? {
        var allModel: [CharactersModel] = []
        do {
            let decodedData = try JSONDecoder().decode(RickAndMortyData.Welcome.self, from: data)
            for data in decodedData.results {
                let imageUrlString = data.image
                guard let imageUrl = URL(string: imageUrlString),
                      let imageData = try? Data(contentsOf: imageUrl),
                      let image = UIImage(data: imageData) else {
                    print("Ошибка при получении изображения")
                    return nil
                }
                let name = data.name
                let status = "Status: \(data.status.rawValue)"
                let id = data.id
                let rickAndMortyModel = CharactersModel(id: id, image: image, name: name, status: status)
                allModel.append(rickAndMortyModel)
            }
            return allModel
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func parseJSONSolo(_ data: Data) -> [SoloCharacterModel]? {
        var soloCharacterModel: [SoloCharacterModel] = []
        do {
            let decodedData = try JSONDecoder().decode(RickAndMortyData.Welcome.self, from: data)
            for data in decodedData.results {
                let imageUrlString = data.image
                guard let imageUrl = URL(string: imageUrlString),
                      let imageData = try? Data(contentsOf: imageUrl),
                      let image = UIImage(data: imageData) else {
                    print("Ошибка при получении изображения")
                    return nil
                }
                let name = data.name
                let status = "Status: \(data.status.rawValue)"
                let gender = data.gender
                let type = data.type
                let species = data.species
                let soloModel = SoloCharacterModel(id: data.id, name: name, image: image, status: status, gender: gender, type: type, species: species)
                soloCharacterModel.append(soloModel)
            }
            return soloCharacterModel
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }
}


