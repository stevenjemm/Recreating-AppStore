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
        redVC.view.backgroundColor = .red
        redVC.navigationItem.title = "APPS"
        
        let redNavController = UINavigationController(rootViewController: redVC)
        redNavController.tabBarItem.title = "RED NAV"
        redNavController.navigationBar.prefersLargeTitles = true
        
        let blueVC = UIViewController()
        blueVC.view.backgroundColor = .blue
        blueVC.navigationItem.title = "SEARCH"
        
        let blueNavController = UINavigationController(rootViewController: blueVC)
        blueNavController.tabBarItem.title = "BLUE NAV"
        blueNavController.navigationBar.prefersLargeTitles = true
        
        viewControllers = [
            redNavController,
            blueNavController
        ]
    }
}
