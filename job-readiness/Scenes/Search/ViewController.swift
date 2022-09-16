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

        let home = HomeViewController()
        let favPage = FavProductsViewController()
        let morePage = SomethingViewController()
        
        home.title = "Home"
        favPage.title = "Favorites"
        morePage.title = "More"
        
        self.setViewControllers([home, favPage, morePage], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        let icons = ["house", "heart", "plus"]
        let selectedIcons = ["house.fill", Icons.heartFilled.rawValue, "plus"]
        
        for i in 0...2 {
            items[i].image = UIImage(systemName: icons[i])
            items[i].selectedImage = UIImage(systemName: selectedIcons[i])
        }
        
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = Colors.darkBlue
    }

}

