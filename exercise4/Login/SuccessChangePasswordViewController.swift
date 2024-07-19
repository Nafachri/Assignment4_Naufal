//
//  SuccessChangePasswordViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 19/07/24.
//

import UIKit

class SuccessChangePasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let navVC = appDelegate?.window?.rootViewController as? UINavigationController
        let tabBar = navVC?.topViewController as? TabBarViewController
        tabBar?.selectedIndex = 1
        self?.dismiss(animated: true)
      }
      
    }
}
