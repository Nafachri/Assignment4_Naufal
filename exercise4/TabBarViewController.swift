//
//  TabBarViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 15/07/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      setup()
      view.backgroundColor = .white
      delegate = self
    }
  
  func setup() {
    let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
    let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
    let foodOrderVC = FoodOrderViewController(nibName: "FoodOrderViewController", bundle: nil)

    profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
    homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    foodOrderVC.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "book.pages"), selectedImage: UIImage(systemName: "book.pages.fill"))
    
    viewControllers = [
      UINavigationController(rootViewController: homeVC),
      UINavigationController(rootViewController: foodOrderVC),
      UINavigationController(rootViewController: profileVC)
    ]
  }
}

extension TabBarViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    let nav = viewController as? UINavigationController
    nav?.popToRootViewController(animated: false)
  }
}
