//
//  LoginViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 15/07/24.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var singinButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let viewModel: LoginViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupUI()
    }
    
    private func setupBindings() {
        // Bind inputs
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        singinButton.rx.tap
            .bind(to: viewModel.signInTapped)
            .disposed(by: disposeBag)
        
        // Bind outputs
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.showLoadingAlert()
                } else {
                    self?.dismissLoadingAlert(nil)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] message in
                self?.showErrorAlert(message: message)
            })
            .disposed(by: disposeBag)
        
        viewModel.signInSuccess
            .subscribe(onNext: { [weak self] in
                self?.navigateToMainScreen()
            })
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        singinButton.layer.cornerRadius = 8
        facebookButton.layer.cornerRadius = 8
        googleButton.layer.cornerRadius = 8
        navigationItem.title = "Sign In"
    }
    
    private func navigateToMainScreen() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let nav = appDelegate?.window?.rootViewController as? UINavigationController
        let tabBar = TabBarViewController()
        nav?.setViewControllers([tabBar], animated: true)
    }
    
    private func showErrorAlert(message: String) {
        let errorAlert = UIAlertController(title: "Sign In Failed", message: message, preferredStyle: .alert)
        errorAlert.view.tintColor = UIColor.black
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    private func showLoadingAlert() {
        let loadingAlert = UIAlertController(title: "Signing In", message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        loadingAlert.view.addSubview(loadingIndicator)
        self.present(loadingAlert, animated: true, completion: nil)
    }
    
    private func dismissLoadingAlert(_ completion: (() -> Void)?) {
        dismiss(animated: true, completion: completion)
    }
}
