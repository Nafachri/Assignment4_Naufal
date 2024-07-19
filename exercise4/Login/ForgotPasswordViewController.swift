//
//  ForgotPasswordViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 19/07/24.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

  @IBOutlet weak var resetUIButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
    resetUIButton.layer.cornerRadius = 8

    }

  @IBAction func resetButtonHandler(_ sender: UIButton) {
    let successChangePasswordVC = SuccessChangePasswordViewController(nibName: "SuccessChangePasswordViewController", bundle: nil)
    successChangePasswordVC.modalPresentationStyle = .overCurrentContext
    
    let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
    appDelegate?.window?.rootViewController?.present(successChangePasswordVC, animated: true)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      self?.navigationController?.popToRootViewController(animated: true)
    }
    
  }
    
    
}
