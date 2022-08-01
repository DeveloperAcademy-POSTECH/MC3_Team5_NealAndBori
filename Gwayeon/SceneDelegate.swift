//
//  SceneDelegate.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/14.
//

import UIKit

import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if Auth.auth().currentUser != nil {
            window?.rootViewController = MainTabBarViewController()
        } else {
            let navigationController = UINavigationController(rootViewController: UsernameSettingViewController())
            window?.rootViewController = navigationController
        }
        
        window?.makeKeyAndVisible()
    }
    
}
