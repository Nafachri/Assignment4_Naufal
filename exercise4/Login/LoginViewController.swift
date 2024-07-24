//
//  LoginViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 15/07/24.
//

import UIKit
import RxRelay


class LoginViewController: UIViewController {
  
  
  @IBOutlet weak var googleButton: UIButton!
  @IBOutlet weak var facebookButton: UIButton!
  @IBOutlet weak var singinButton: UIButton!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  let authService: AuthenticationServiceable
  let progressLayer = CAShapeLayer()

  
  init(authService: AuthenticationServiceable = AuthenticationService(requestor: NetworkRequest())) {
    self.authService = authService
    super.init(nibName: "LoginViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let loadingAlert = UIAlertController(title: "Signing In", message: "Please wait...", preferredStyle: .alert)
  let errorAlert = UIAlertController(title: "Sign In Failed", message: "Username or Password Wrong", preferredStyle: .alert)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    singinButton.layer.cornerRadius = 8
    facebookButton.layer.cornerRadius = 8
    googleButton.layer.cornerRadius = 8
    navigationItem.title = "Sign In"
  }
  
  
  @IBAction func signInButtonTapped(_ sender: UIButton) {
    
    showLoadingAlert()
    authService.signIn(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") {[weak self] result in
      self?.dismissLoadingAlert{
        switch result {
        case .success:
          self?.navigateToMainScreen()
        case .failure(let error):
          self?.showErrorAlert()
        }
      }
    }
  }
  
  func navigateToMainScreen() {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let nav = appDelegate?.window?.rootViewController as? UINavigationController
    
    let tabBar = TabBarViewController()
    nav?.setViewControllers([tabBar], animated: true)
  }
  
  @IBAction func forgotPasswordHandler(_ sender: UIButton) {
    let forgotPasswordVC = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
    self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
  }
  
  @objc func backButtonHandler(){
    self.navigationController?.popViewController(animated: true)
    let viewController = ViewController()
    self.navigationController?.pushViewController(viewController, animated: true)  }
  
  func showErrorAlert(){
    errorAlert.view.tintColor = UIColor.black
    self.present(errorAlert, animated: true)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {[weak self] in
      self?.dismissErrorAlert{[weak self] in
        self?.emailTextField.text = nil
        self?.passwordTextField.text = nil
      }
    }
  }
  
  func dismissErrorAlert(_ completion: (() -> Void)?){
    errorAlert.dismiss(animated: true, completion: completion)
  }
  
  func showLoadingAlert(){
    loadingAlert.view.tintColor = UIColor.black
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10,y: 5,width: 50, height: 50)) as UIActivityIndicatorView
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.style = .medium
    loadingIndicator.startAnimating();

    loadingAlert.view.addSubview(loadingIndicator)
    self.present(loadingAlert, animated: true)
  }
  
  func dismissLoadingAlert(_ completion: (() -> Void)?){
    loadingAlert.dismiss(animated: true, completion: completion)
  }
  
  
}
