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
    let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil) 
    let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
    let foodOrderVC = FoodOrderViewController(nibName: "FoodOrderViewController", bundle: nil)

    loginVC.tabBarItem = UITabBarItem(title: "Login", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
    homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    foodOrderVC.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "book.pages"), selectedImage: UIImage(systemName: "book.pages.fill"))
    
    viewControllers = [
      UINavigationController(rootViewController: loginVC),
      UINavigationController(rootViewController: homeVC),
      UINavigationController(rootViewController: foodOrderVC)
    ]
    
    
  }

}

extension TabBarViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    let nav = viewController as? UINavigationController
    nav?.popToRootViewController(animated: false)
    print(viewController)
  }
}
