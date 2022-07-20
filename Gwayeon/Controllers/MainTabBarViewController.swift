//
//  MainTabBarViewController.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/18.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let homeViewController = UINavigationController(rootViewController: HomeViewController())
    
    private let myPageViewController = UINavigationController(rootViewController: MyPageViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewController.tabBarItem.image = UIImage(systemName: "doc.text.image")
        homeViewController.tabBarItem.title = "Home"
        
        myPageViewController.tabBarItem.image = UIImage(systemName: "person")
        myPageViewController.tabBarItem.title = "마이"
        
        tabBar.tintColor = .red
        tabBar.backgroundColor = .tabBarColor
        setViewControllers([homeViewController, myPageViewController], animated: true)
    }
    
}
