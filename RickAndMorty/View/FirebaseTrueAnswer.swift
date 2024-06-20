//
//  LastTest.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 19.06.2024.
//

import UIKit
import WebKit

class FirebaseTrueAnswer: UIViewController {
    
    private var webView: WKWebView! = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private lazy var goWebViewButton: UIButton = {
       let button = UIButton()
        button.setTitle("\u{1F310} GO TO WEB", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(goWebViewBottonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(webView)
        view.addSubview(goWebViewButton)
        view.addSubview(updateNow)
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            goWebViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goWebViewButton.bottomAnchor.constraint(equalTo: updateNow.topAnchor, constant: -15),
            goWebViewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            goWebViewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            updateNow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateNow.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            updateNow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            updateNow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)])
    }
    
    private func setupWebView() {
        if let url = URL(string: "https://rickandmortyapi.com/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @objc
    private func goWebViewBottonTapped() {
        print("Go to Web")
        setupWebView()
        goWebViewButton.isHidden = true
    }
    
    @objc
    private func updateButtonTapped() {
        let tabBar = TabBarViewController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
}
