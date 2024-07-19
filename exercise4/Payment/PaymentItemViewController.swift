//
//  PaymentItemViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 18/07/24.
//

import UIKit

class PaymentItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CardSuccessViewControllerDelegate {
  
  
  
  @IBOutlet weak var tableView: UITableView!
  var data = ["Cookies Sandwitch", "Combo Burger", "Oyster Dish"]
  var pastOrder = [Food]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(UINib(nibName: "PaymentItemTableViewCell", bundle: nil), forCellReuseIdentifier: "payment_cell")
    
    tableView.register(UINib(nibName: "PaymentTotalTableViewCell", bundle: nil), forCellReuseIdentifier: "payment_total_cell")
    
    tableView.register(UINib(nibName: "AddMoreItemTableViewCell", bundle: nil), forCellReuseIdentifier: "payment_add_more_item_cell")
    
//    do {
//      let coredata = CoreDataManager.shared
//      let tasks: [Food] = try coredata.fetch(entity: Food.self)
//      print(tasks)
//    }catch {
//      print("CoreData error: \(error.localizedDescription)")
//    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count + 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.row == data.count {
      //MARK: subtotal
      let cell = tableView.dequeueReusableCell(withIdentifier: "payment_total_cell", for: indexPath) as! PaymentTotalTableViewCell
      return cell
    } else if indexPath.row == data.count + 1 {
      // MARK: add more item
      let cell = tableView.dequeueReusableCell(withIdentifier: "payment_add_more_item_cell", for: indexPath) as! AddMoreItemTableViewCell
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "payment_cell", for: indexPath) as! PaymentItemTableViewCell
      return cell
    }
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == data.count + 1 {
      print("add more item clicked")
      navigationController?.popViewController(animated: true)
    }
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70))
    
    let buttonTitle = "Checkout (AUD $30)"
    let font = UIFont.systemFont(ofSize: 16)
    
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout for the button
    
    if section == 0 {
      button.tag = section
      button.setTitle(buttonTitle, for: .normal)
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
    
    // Auto Layout constraints
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
    do {
      let coredata = CoreDataManager.shared
      
      let data = [
        Food(
          foodName: "Chicken Masala",
          foodDescription: "Best Chicken Masala in Town!",
          foodCategory: "Asian",
          foodPrice: 25000,
          isComplete: true,
          createDate: .now
        ),
        Food(
          foodName: "Kebab",
          foodDescription: "Best Kebab in Town!",
          foodCategory: "Asian",
          foodPrice: 20000,
          isComplete: true,
          createDate: .now
        )
      
      ]
      
      for item in data {
        try coredata.create(entity: FoodModel.self, properties: item.toDictionary())
      }
      
      let vc = CardSuccessViewController(nibName: "CardSuccessViewController", bundle: nil)
      vc.modalPresentationStyle = .overCurrentContext
      let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
      appDelegate?.window?.rootViewController?.present(vc, animated: true)
      vc.delegate = self
      NotificationCenter.default.post(
        name: PaymentItemViewController.chekcoutNotification,
        object: nil)
      
    } catch {
      print("CoreData error: \(error.localizedDescription)")
    }
  }
  
  func cardSuccessDismiss() {
    self.navigationController?.popViewController(animated: true)
  }
  
}

extension PaymentItemViewController {
  static var chekcoutNotification: NSNotification.Name {
    NSNotification.Name("")
  }
}
