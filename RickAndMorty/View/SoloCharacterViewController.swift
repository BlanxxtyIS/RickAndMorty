//
//  SoloCharacterViewController.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 19.06.2024.
//

import UIKit

class SoloCharacterViewController: UIViewController {
    
    //MARK: - Public Properties
    let soloCharacterManager = RickAndMortyManager()
    var name = ""
    var id = 0
    
    lazy var charecterImage: UIImageView = {
        let image = UIImage(named: "")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Private Properties
    private lazy var statusCharacter: UILabel = {
        let label = UILabel()
        label.text = "Status: "
        label.textColor = .blue
        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genderCharacter: UILabel = {
        let label = UILabel()
        label.text = "Gender: "
        label.textColor = .blue
        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeCharacter: UILabel = {
        let label = UILabel()
        label.text = "Type: "
        label.textColor = .blue
        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var speciesCharacter: UILabel = {
        let label = UILabel()
        label.text = "Species: "
        label.textColor = .blue
        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = name
        let backButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
        soloCharacterManager.soloDelegate = self
        setupUI()
        DispatchQueue.global().async {
            self.soloCharacterManager.getCharacters(characterModel: .solo)
        }
    }
    
    //MARK: - Private Methods
    @objc func backAction() {
        dismiss(animated: true)
    }
    
    private func setupUI() {
        let uiViews = [charecterImage, statusCharacter, genderCharacter, typeCharacter, speciesCharacter]
        uiViews.forEach { uiView in
            uiView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(uiView)
        }
        setupConstraints()
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            charecterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charecterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charecterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            charecterImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            statusCharacter.topAnchor.constraint(equalTo: charecterImage.bottomAnchor, constant: 30),
            statusCharacter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            genderCharacter.topAnchor.constraint(equalTo: statusCharacter.bottomAnchor, constant: 30),
            genderCharacter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            typeCharacter.topAnchor.constraint(equalTo: genderCharacter.bottomAnchor, constant: 30),
            typeCharacter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            speciesCharacter.topAnchor.constraint(equalTo: typeCharacter.bottomAnchor, constant: 30),
            speciesCharacter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}

//MARK: - RickAndMortySoloDelegate
extension SoloCharacterViewController: RickAndMortySoloDelegate {
    func getSoloCharacter(_ character: [SoloCharacterModel]) {
        DispatchQueue.main.async {
            for solo in character {
                if solo.id == self.id {
                    self.charecterImage.image = solo.image
                    self.statusCharacter.text = solo.status
                    self.genderCharacter.text = "Gender: \(solo.gender.rawValue)"
                    self.typeCharacter.text = "\(solo.type)"
                    self.speciesCharacter.text = "Species: \(solo.species.rawValue)"
                    break
                }
            }
        }
    }
}
