//
//  AppDelegate.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 15/07/24.
//

import UIKit
import KeychainSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  let keychain = KeychainSwift()

  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    print(paths[0])
    
    if keychain.get("userToken") != nil {
      let tabBar = TabBarViewController()
      let navigation = UINavigationController(rootViewController: tabBar)
      window?.rootViewController = navigation
    } else {
      let onboardingVC = OnBoardingViewController(nibName: "OnBoardingViewController", bundle: nil)
      window?.rootViewController = onboardingVC
    }
    
//    let food = try! CoreDataManager
//      .shared
//      .create(entity: FoodModel.self, properties: [
//        "foodName": "TestFoodName2"
//      ])
//    
//    let orderHistory = try? CoreDataManager
//      .shared
//      .create(entity: OrderHistory.self, properties: [
//        "orderDate": Date.now,
//        "food": food
//      ])

//    print(orderHistory)
    
    let coreData = CoreDataManager.shared
//    if let cartList = try? coreData.fetch(entity: Cart.self) {
//      for cart in cartList {
//        print(cart.id)
//      }
//    }
    
    
    
    
    do {
      let foodList = try coreData.fetch(entity: FoodModel.self)
      if foodList.count <= 0 {
        let foodsJson = loadData()
        for foodJson in foodsJson {
          var newJson = foodJson
          newJson["createDate"] = Date.now
          try coreData.create(entity: FoodModel.self, properties: newJson)
        }
      }
    } catch {
      
    }
    
    do {
      let foodList = try coreData.fetch(entity: FoodModel.self)
      for food in foodList {
        print(food.id)
      }
      
    } catch {
      
    }
    
    
    
    
    window?.makeKeyAndVisible()
    
    
    
    let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
    if darkModeEnabled {
      UIWindow.appearance().overrideUserInterfaceStyle = .dark
    } else {
      UIWindow.appearance().overrideUserInterfaceStyle = .light
    }
    
    return true
  }
  
  func loadData() -> [[String: Any]] {
    guard let path = Bundle.main.path(forResource: "foods", ofType: "json") else {
      return []
    }
    
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [[String: Any]]
      return jsonResult ?? []
    } catch {
      // handle error
      print(error.localizedDescription)
    }
    return []
    
  }
  
  
}

