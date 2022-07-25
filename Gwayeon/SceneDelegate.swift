//
//  SceneDelegate.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
//        window?.rootViewController = DetailViewController()
        window?.rootViewController = MainTabBarViewController()
    ()
        window?.makeKeyAndVisible()
    }
    
}

