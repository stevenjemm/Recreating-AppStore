//
//  BaseTabBarController.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 11/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
            createNavController(viewController: UIViewController(), title: "Apps", imageName: "apps"),
            createNavController(viewController: UIViewController(), title: "Search", imageName: "search")
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
}