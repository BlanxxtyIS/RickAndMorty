//
//  TabBarViewController.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 19.06.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let charactersViewController = createNewViewController(for: CharactersViewController(),
                                                               title: "Characters", 
                                                               imageName: "person")
        let locationsViewController = createNewViewController(for: LocationsViewController(),
                                                              title: "Locations",
                                                              imageName: "globe")
        let episodeViewController = createNewViewController(for: EpisodesViewController(),
                                                            title: "Episodes", 
                                                            imageName: "tv")
        let settingsViewController = createNewViewController(for: SettingsViewController(),
                                                             title: "Settings", 
                                                             imageName: "gear")
        
        let rickAndMortyManager = RickAndMortyManager()
        rickAndMortyManager.delegate = CharactersViewController()
        
        viewControllers = [charactersViewController,
                           locationsViewController,
                           episodeViewController,
                           settingsViewController]
    }
    
    private func createNewViewController(for rootViewController: UIViewController,
                                         title: String,
                                         imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        return navController
    }
}
