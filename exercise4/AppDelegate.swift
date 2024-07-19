//
//  AppDelegate.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 15/07/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let tabBar = TabBarViewController()
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let navigation = UINavigationController(rootViewController: tabBar)

    window?.rootViewController = navigation
    window?.makeKeyAndVisible()
    
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    print(paths[0])

    return true
  }
  
  
}

