//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 18.06.2024.
//

import UIKit

class CharactersViewController: UIViewController {
    
    let rickAndMortyManager = RickAndMortyManager()
    var data: [CharactersModel] = [CharactersModel(image: UIImage(named: "border")!, name: "Marat", status: "Alive")]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Characters"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.reuseIdentifier)
        collection.delegate = self
        collection.dataSource = self
        collection.layer.cornerRadius = 8
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        rickAndMortyManager.delegate = self
        rickAndMortyManager.getCharacters(characterModel: .characters)
        
        view.addSubview(titleLabel)
        view.addSubview(charactersCollectionView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            charactersCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            charactersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            charactersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            charactersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        charactersCollectionView.reloadData()
    }
}

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: 280)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Выбрали элемент \(data[indexPath.row].name)")
        let vc = SoloCharacterViewController()
        present(vc, animated: true)
    }
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! CustomCollectionViewCell
        cell.charecterImage.image = data[indexPath.row].image
        cell.characterNameLabel.text = data[indexPath.row].name
        cell.characterStatusLabel.text = data[indexPath.row].status
        return cell
    }
}

extension CharactersViewController: RickAndMortyCharactersDelegate {
    func getAllCharcters(_ character: [CharactersModel]) {
        DispatchQueue.main.async {
            self.data = character
            print(character)
            self.charactersCollectionView.reloadData()
        }
    }
}

