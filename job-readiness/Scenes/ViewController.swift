//
//  HomeViewController.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 16/09/22.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeViewController = HomeViewController()
        let favPageViewController = FavProductsViewController()
        let morePageViewController = SomethingViewController()
        
        homeViewController.title = "Home"
        favPageViewController.title = "Favorites"
        morePageViewController.title = "More"
        
        let controllers = [homeViewController, favPageViewController, morePageViewController]
        self.viewControllers = controllers
        
        guard let items = self.tabBar.items else { return }
        
        let icons = [Icons.home.rawValue, Icons.heart.rawValue, Icons.plus.rawValue]
        let selectedIcons = [Icons.homeFilled.rawValue, Icons.heartFilled.rawValue, Icons.plus.rawValue]
        
        for i in 0...2 {
            items[i].image = UIImage(systemName: icons[i])
            items[i].selectedImage = UIImage(systemName: selectedIcons[i])
        }
        
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = Colors.darkBlue
        
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)
        }
    }
}
