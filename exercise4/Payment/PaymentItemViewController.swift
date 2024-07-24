//
//  PaymentItemViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 18/07/24.
//

import UIKit

class PaymentItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CardSuccessViewControllerDelegate {
  
  
  
  @IBOutlet weak var tableView: UITableView!
  var cart: [Cart]?
  var pastOrder = [FoodModel]()
  
  init(cartItem: [Cart]) {
    self.cart = cartItem
    super.init(nibName: "PaymentItemViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(UINib(nibName: "PaymentItemTableViewCell", bundle: nil), forCellReuseIdentifier: "payment_cell")
    
    tableView.register(UINib(nibName: "PaymentTotalTableViewCell", bundle: nil), forCellReuseIdentifier: "payment_total_cell")
    
    tableView.register(UINib(nibName: "AddMoreItemTableViewCell", bundle: nil), forCellReuseIdentifier: "payment_add_more_item_cell")
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let numberOfRows = (cart?.count ?? 0) + 2
    return numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let numberOfItems = cart?.count ?? 0
    
    if indexPath.row == numberOfItems {
      // MARK: Subtotal
      let cell = tableView.dequeueReusableCell(withIdentifier: "payment_total_cell", for: indexPath) as! PaymentTotalTableViewCell
      let subtotal = calculateSubtotal(cart: cart)
      let total = calculateTotal(subtotal: subtotal, deliveryCost: 0)
      cell.subtotalPriceLabel.text = formatToIDR(subtotal)
      cell.totalPriceLabel.text = formatToIDR(total)
      return cell
    } else if indexPath.row == numberOfItems + 1 {
      // MARK: Add more item
      let cell = tableView.dequeueReusableCell(withIdentifier: "payment_add_more_item_cell", for: indexPath) as! AddMoreItemTableViewCell
      return cell
    } else {
      // MARK: Payment item
      let cell = tableView.dequeueReusableCell(withIdentifier: "payment_cell", for: indexPath) as! PaymentItemTableViewCell
      if let cartItems = cart, indexPath.row < cartItems.count {
        let cartItem = cartItems[indexPath.row]
        cell.foodNameLabel.text = cartItem.food?.foodName
        cell.foodPriceLabel.text = cartItem.food?.foodPrice.idr
        cell.foodDescriptionLabel.text = cartItem.food?.foodDescription
      }
      
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let numberOfItems = cart?.count ?? 0
    
    if indexPath.row == numberOfItems + 1 {
      navigationController?.popViewController(animated: true)
    }
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70))
    let subtotal = calculateSubtotal(cart: cart)
    let total = calculateTotal(subtotal: subtotal, deliveryCost: 0)
    let font = UIFont.systemFont(ofSize: 16)
    
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    
    if section == 0 {
      button.tag = section
      button.setTitle("CHECKOUT \(formatToIDR(total))", for: .normal)
      button.titleLabel?.font = font
      button.backgroundColor = UIColor(hex: "#EEA734")
      button.setTitleColor(.white, for: .normal)
      button.titleLabel?.adjustsFontSizeToFitWidth = true
      button.titleLabel?.minimumScaleFactor = 0.5
      button.addTarget(self, action: #selector(checkoutButtonClicked(_:)), for: .touchUpInside)
      button.layer.cornerRadius = 8
      button.layer.masksToBounds = true
    }
    footerView.backgroundColor = .systemBackground
    footerView.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 8),
      button.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -8),
      button.heightAnchor.constraint(equalToConstant: 48),
      button.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -16),
      button.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 16)
    ])
    
    return footerView
  }
  
  @objc func checkoutButtonClicked(_ sender: UIButton) {
    guard let cartItems = cart else {
      print("Cart is empty or nil.")
      return
    }
    
    var creationSucceeded = true
    
    for cartItem in cartItems {
      guard let food = cartItem.food else {
        print("Cart item has no food.")
        continue
      }
      
      do {
        try CoreDataManager.shared.create(entity: OrderHistory.self, properties: [
          "orderDate": Date(),
          "food": food
        ])
      } catch {
        print("CoreData error: \(error.localizedDescription)")
        creationSucceeded = false
      }
    }
    
    if creationSucceeded {
      let vc = CardSuccessViewController(nibName: "CardSuccessViewController", bundle: nil)
      vc.modalPresentationStyle = .overCurrentContext
      vc.delegate = self
      
      if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
         let rootViewController = appDelegate.window?.rootViewController {
        rootViewController.present(vc, animated: true) { [self] in
          do {
            try cartItems.forEach { cartItem in
              try CoreDataManager.shared.delete(entity: cartItem)
            }
            cart = []
            NotificationCenter.default.post(name: PaymentItemViewController.chekcoutNotification, object: nil)
            tableView.reloadData()
          } catch {
            print("Failed to delete Cart items: \(error.localizedDescription)")
          }
        }
      }
    } else {
      print("One or more OrderHistory entries could not be created.")
    }
  }
  
  func cardSuccessDismiss() {
    self.navigationController?.popViewController(animated: true)
  }
  
  func calculateSubtotal(cart: [Cart]?) -> Float {
    let subtotal = cart?.compactMap { $0.food?.foodPrice }.reduce(0, +) ?? 0
    return subtotal
  }
  
  func calculateTotal(subtotal: Float, deliveryCost: Float) -> Float {
    return subtotal + deliveryCost
  }
  
  
  func formatToIDR(_ amount: Float) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.currencySymbol = "Rp"
    numberFormatter.locale = Locale(identifier: "id_ID")
    numberFormatter.currencyGroupingSeparator = "."
    numberFormatter.maximumFractionDigits = 0
    
    return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
  }}


extension PaymentItemViewController {
  static var chekcoutNotification: NSNotification.Name {
    NSNotification.Name("")
  }
}
