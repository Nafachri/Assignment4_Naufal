//
//  FoodDetailViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 18/07/24.
//

import UIKit

class FoodDetailViewController: UIViewController {
  var selectedItem: FoodModel?
  
  @IBOutlet weak var foodCategoryLabel: UILabel!
  @IBOutlet weak var foodNameLabel: UILabel!
  @IBOutlet weak var foodImageView: UIImageView!
  @IBOutlet weak var foodDescriptionLabel: UILabel!
  @IBOutlet weak var takeAwayUIButton: UIButton!
  
  init(selectedItem: FoodModel) {
    self.selectedItem = selectedItem
    super.init(nibName: "FoodDetailViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    takeAwayUIButton.layer.borderWidth = 1
    takeAwayUIButton.layer.borderColor = UIColor(hex: "#EEA734").cgColor
    takeAwayUIButton.layer.cornerRadius = 8
    title = "Food Detail"
    setupUI()
  }
  
  
  @IBAction func foorOrderTapped(_ sender: UIButton) {
    if let selectedItem = selectedItem {
      do {
        try CoreDataManager.shared.create(entity: Cart.self, properties: [
          "quantity": 1,
          "food": selectedItem
        ])
        NotificationCenter.default.post(
          name: PaymentItemViewController.chekcoutNotification,
          object: nil)
        
        let alertController = UIAlertController(title: "Order Placed", message: "Your order has been placed successfully.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler:{_ in
          self.alertButtonHandler()
        }))
        self.present(alertController, animated: true, completion: nil)
      } catch {
        print("Failed to create data: \(error.localizedDescription)")
        let alertController = UIAlertController(title: "Error", message: "Failed to place the order. Please try again.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
      }
    }
  }
  
  func alertButtonHandler(){
    
    let foodOrderVC = FoodOrderViewController(nibName: "FoodOrderViewController", bundle: nil)
    _ = UINavigationController(rootViewController: foodOrderVC)
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let nav = appDelegate?.window?.rootViewController as? UINavigationController
    nav?.popToRootViewController(animated: true)
  }
  
  
  
  func setupUI() {
    guard let item = selectedItem else { return }
    foodImageView.image = UIImage(named: item.image!)
    foodNameLabel.text = item.foodName
    foodCategoryLabel.text = item.foodCategory
    foodDescriptionLabel.text = item.foodDescription
  }}



