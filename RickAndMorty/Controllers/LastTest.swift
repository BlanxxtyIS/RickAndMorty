//
//  LastTest.swift
//  RickAndMorty
//
//  Created by Марат Хасанов on 19.06.2024.
//

import UIKit
import FirebaseRemoteConfig

class LastTest: UIViewController {
    
    var remoteConfig = RemoteConfig.remoteConfig()
        
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "DSDSDSD"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = RemoteConfigSettings()
        //каждый раз при запросе интервал 0 секунс
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        remoteConfig.fetchAndActivate { status, error in
            if error != nil {
                print("Ошибка при загрузке\(error?.localizedDescription)")
            } else {
                if status != .error {
                    if let stringURL = self.remoteConfig["needForceUpdate"].stringValue {
                        print("SUCCSESS: \(stringURL)")
                        self.label.text = stringURL
                    }
                }
            }
        }
    }
}
