//
//  LastTest.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 19.06.2024.
//

import UIKit

class FirebaseTrueAnswer: UIViewController {
    
    private lazy var updateNow: UIButton = {
       let button = UIButton()
        button.setTitle("\u{26A0}\u{FE0F} UPDATE NOW", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(updateNow)
        NSLayoutConstraint.activate([
            updateNow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateNow.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            updateNow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            updateNow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)])
    }
    
    @objc
    private func updateButtonTapped() {
        let tabBar = TabBarViewController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
}
