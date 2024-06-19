//
//  CustomCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 19.06.2024.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    //MARK: - Public Properties
    static let reuseIdentifier = "CharactersCell"
    
    //MARK: - Private Properties
    private lazy var charecterImage: UIImageView = {
        let image = UIImage(named: "")
        let imageView = UIImageView(image: image)
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return imageView
    }()
    
    private lazy var characterNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var characterStatusLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var characterBackgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 8
        // Настройка тени
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: -2, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func setupCellDatas(image: UIImage, characterName: String, characterStatus: String) {
        charecterImage.image = image
        characterNameLabel.text = characterName
        characterStatusLabel.text = characterStatus
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        contentView.addSubview(characterBackgroundView)
        let uiViews = [charecterImage, characterNameLabel, characterStatusLabel]
        uiViews.forEach { uiView in
            uiView.translatesAutoresizingMaskIntoConstraints = false
            characterBackgroundView.addSubview(uiView)
        }

        NSLayoutConstraint.activate([
            characterBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            characterBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            characterBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            charecterImage.topAnchor.constraint(equalTo: characterBackgroundView.topAnchor),
            charecterImage.leadingAnchor.constraint(equalTo: characterBackgroundView.leadingAnchor),
            charecterImage.trailingAnchor.constraint(equalTo: characterBackgroundView.trailingAnchor),
            
            characterNameLabel.topAnchor.constraint(equalTo: charecterImage.bottomAnchor, constant: 10),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterBackgroundView.leadingAnchor, constant: 5),
            
            characterStatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 10),
            characterStatusLabel.leadingAnchor.constraint(equalTo: characterBackgroundView.leadingAnchor, constant: 5)])
    }
}
