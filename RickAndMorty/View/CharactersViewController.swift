//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 18.06.2024.
//

import UIKit

class CharactersViewController: UIViewController {
    //MARK: - Private Properties
    private var allCharactersData: [CharactersModel] = []
    private var soloCharactersData: [SoloCharacterModel] = []
    
    private let rickAndMortyManager = RickAndMortyManager()
    
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
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        rickAndMortyManager.delegate = self
        rickAndMortyManager.getCharacters(characterModel: .characters)
        
        view.addSubview(titleLabel)
        view.addSubview(charactersCollectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            charactersCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            charactersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            charactersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            charactersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
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
        let vc = SoloCharacterViewController()
        vc.name = allCharactersData[indexPath.row].name
        vc.id = allCharactersData[indexPath.row].id
        vc.charecterImage.image = allCharactersData[indexPath.row].image
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allCharactersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! CustomCollectionViewCell
        let image = allCharactersData[indexPath.row].image
        let characterName = allCharactersData[indexPath.row].name
        let characterStatus = allCharactersData[indexPath.row].status
        cell.setupCellDatas(image: image, characterName: characterName, characterStatus: characterStatus)
        return cell
    }
}

//MARK: - RickAndMortyCharactersDelegate
extension CharactersViewController: RickAndMortyCharactersDelegate {
    func getAllCharcters(_ character: [CharactersModel]) {
        DispatchQueue.main.async {
            self.allCharactersData = character
            print(character)
            self.charactersCollectionView.reloadData()
        }
    }
}

