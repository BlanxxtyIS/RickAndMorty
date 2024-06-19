//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 18.06.2024.
//

import UIKit
import FirebaseRemoteConfig

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        firebase { needForceUpdate in
            DispatchQueue.main.async {
                if needForceUpdate {
                    self.window?.rootViewController = FirebaseTrueAnswer()
                } else {
                    self.window?.rootViewController = TabBarViewController()
                }
                self.window?.makeKeyAndVisible()
            }
        }
    }
    
    func firebase(completion: @escaping (Bool) -> Void) {
        var remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.fetchAndActivate { status, error in
            if let error = error {
                print("Ошибка при загрузке Remote Config: \(error.localizedDescription)")
                completion(false)
            } else {
                if status != .error {
                    let needForceUpdate = remoteConfig["needForceUpdate"].boolValue
                    print("Успешно получили значение из Remote Config: \(needForceUpdate)")
                    completion(needForceUpdate)
                } else {
                    completion(false)
                }
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

