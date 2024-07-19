//
//  LoginViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 15/07/24.
//

import UIKit

class LoginViewController: UIViewController {


  override func viewDidLoad() {
        super.viewDidLoad()
      
      navigationItem.title = "Sign In"
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonHandler))
    }
  
  
  @IBAction func forgotPasswordHandler(_ sender: UIButton) {
    let forgotPasswordVC = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
    self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
  }
  
  @objc func backButtonHandler(){
    self.navigationController?.popViewController(animated: true)
    let viewController = ViewController()
    self.navigationController?.pushViewController(viewController, animated: true)  }

}
