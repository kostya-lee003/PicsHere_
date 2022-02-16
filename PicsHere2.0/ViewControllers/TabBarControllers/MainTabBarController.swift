//
//  MainTabBarController.swift
//  PicsHere2.0
//
//  Created by Kostya Lee on 30/12/21.
//

import UIKit
import SwiftUI

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let rc = RecommendationsViewController()
        let generatedNVC = generateNavigationController(rootViewController: rc, title: "Recommendeations")
        viewControllers = [
            generatedNVC, SearchViewController()
        ]
        
        viewControllers?.first?.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        viewControllers?.last?.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        return navigationVC
    }
}
