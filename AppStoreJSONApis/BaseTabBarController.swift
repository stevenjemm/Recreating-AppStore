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
        
        let redVC = UIViewController()
        redVC.view.backgroundColor = .white
        redVC.navigationItem.title = "Apps"
        
        let redNavController = UINavigationController(rootViewController: redVC)
        redNavController.tabBarItem.title = "Apps"
        redNavController.tabBarItem.image = #imageLiteral(resourceName: "apps")
        redNavController.navigationBar.prefersLargeTitles = true
        
        let blueVC = UIViewController()
        blueVC.view.backgroundColor = .white
        blueVC.navigationItem.title = "Search"
        
        let blueNavController = UINavigationController(rootViewController: blueVC)
        blueNavController.tabBarItem.title = "Search"
        blueNavController.tabBarItem.image = UIImage(named: "search")
        blueNavController.navigationBar.prefersLargeTitles = true
        
        viewControllers = [
            redNavController,
            blueNavController
        ]
    }
}
