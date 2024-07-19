//
//  CardSuccessViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 19/07/24.
//

import UIKit
protocol CardSuccessViewControllerDelegate: AnyObject {
  func cardSuccessDismiss()
}

class CardSuccessViewController: UIViewController {
  
  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var uiButton: UIButton!
  @IBOutlet weak var containerCenterConstraint: NSLayoutConstraint!
  weak var delegate: CardSuccessViewControllerDelegate?
  override func viewDidLoad() {
    super.viewDidLoad()
  
    cardView.clipsToBounds = true
    containerView.layer.shadowColor = UIColor.black.cgColor
    containerView.layer.shadowOffset = CGSize(width: 10, height: 15)
    containerView.layer.shadowOpacity = 3
    containerView.layer.shadowRadius = 8
    cardView.layer.cornerRadius = 10
    cardView.layer.masksToBounds = true
    
    containerBottomConstraint.constant = -containerView.frame.height
    
//    containerCenterConstraint.constant = (view.frame.size.height / 2) + (containerView.frame.size.height / 2)
//
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeCardView)))
    view.backgroundColor = .black.withAlphaComponent(0)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
    UIView.animate(withDuration: 0.3) {
      self.view.backgroundColor = .black.withAlphaComponent(0.5)
      self.containerBottomConstraint.constant = 0
//      self.containerCenterConstraint.constant = 0
      self.view.layoutIfNeeded()
      
    }
  }
  
  @objc func closeCardView(){
    print("clicked")
    UIView.animate(withDuration: 0.3) {
      self.view.backgroundColor = .black.withAlphaComponent(0)
      self.containerBottomConstraint.constant = -self.containerView.frame.size.height
//      self.containerCenterConstraint.constant = (self.view.frame.size.height / 2) + (self.containerView.frame.size.height / 2)
      self.view.layoutIfNeeded()
    } completion:  { _ in
      self.dismiss(animated: false)
      self.delegate?.cardSuccessDismiss()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
  @IBAction func keepBrowsingButtonHandler(_ sender: UIButton) {
    closeCardView()
  }
}
