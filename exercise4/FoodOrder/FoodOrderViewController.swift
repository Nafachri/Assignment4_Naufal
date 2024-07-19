//
//  FoodOrderViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 17/07/24.
//

import UIKit

class FoodOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  var upcomingData: [Food] = [
//    Food(name: "Ayam Kungpaw", description: "Ayam bakar madu buatan neng salsabilla", category: "Asian", price: 25000, isComplete: false, date: .now),
//    Food(name: "Kungpaw Chicken", description: "Ayam kungpaw buatan mas amin sedap", category: "Parung Panjang", price: 30000,isComplete: false, date: .now),
//    Food(name: "Pecel Ayam Gancit", description: "Rasa mantap harga murah", category: "Mongolian", price: 26000,isComplete: false, date: .now)
  ]
  var pastData =  [Food]()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(UINib(nibName: "FoodOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "food_order_cell")
    
    tableView.separatorStyle = .none
    title = "Your Orders"
    
    loadFoodData()
    
    NotificationCenter.default.addObserver(forName: PaymentItemViewController.chekcoutNotification, object: nil, queue: .main) { [weak self] _ in
      self?.loadFoodData()
    }
    
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: PaymentItemViewController.chekcoutNotification, object: self)
  }
  
  func loadFoodData() {
    let coredata = CoreDataManager.shared
    do{
      pastData = try coredata.fetch(entity: FoodModel.self)
        .map { $0.food() }
      
      tableView.reloadData()
    }
    catch {
      print(error.localizedDescription)
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
    
    //    MARK: Adding Label Into Header
    let label = UILabel()
    
    label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
    if section == 0 {
      label.text = "CART"
      let button = UIButton(frame: CGRect(x: headerView.frame.width - 90, y: 15, width: 85, height: 20))
      button.tag = section
      button.setTitle("CLEAR ALL", for: .normal)
      button.titleLabel?.font = .systemFont(ofSize: 12)
      button.setTitleColor(.systemGray2, for: .normal)
      button.titleLabel?.adjustsFontSizeToFitWidth = true
      button.titleLabel?.minimumScaleFactor = 0.5
      headerView.addSubview(button)
    } else {
      label.text = "PAST ORDERS"
    }
    label.font = .systemFont(ofSize: 16)
    label.textColor = .systemGray2
    
    headerView.addSubview(label)
    headerView.backgroundColor = .systemBackground
    
    
    headerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    return headerView
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
    
    let buttonTitle = "Proceed Payment"
    let font = UIFont.systemFont(ofSize: 14)
    let titleSize = (buttonTitle as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    let buttonWidth = titleSize.width + 20
    
    // MARK: Adding Label Into Footer
    let button = UIButton(frame: CGRect(x: footerView.frame.width - buttonWidth - 10, y: 15, width: buttonWidth, height: 20))
    
    
    if section == 0 {
      button.tag = section
      button.setTitle("Proceed Payment", for: .normal)
      button.titleLabel?.font = .systemFont(ofSize: 16)
      button.setTitleColor(UIColor(hex: "#F8B64C"), for: .normal)
      button.titleLabel?.adjustsFontSizeToFitWidth = true
      button.titleLabel?.minimumScaleFactor = 0.5
      button.addTarget(self, action: #selector(footerButtonTapped(_:)), for: .touchUpInside)
    }
    footerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    
    footerView.addSubview(button)
    footerView.backgroundColor = .systemBackground
    return footerView
  }
  
  @objc func footerButtonTapped(_ sender: UIButton) {
    let paymentVC = PaymentItemViewController(nibName: "PaymentItemViewController", bundle: nil)
    self.navigationController?.pushViewController(paymentVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 1 {
      return pastData.count
    } else {
      return upcomingData.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "food_order_cell", for: indexPath) as! FoodOrderTableViewCell
    let foodItem: Food
    if indexPath.section == 1 {
      let food = pastData[indexPath.row]
      cell.foodNameLabel.text = food.foodName
      cell.foodDescLabel.text = food.foodDescription
      cell.foodCategoryLabel.text = food.foodCategory
      cell.foodPriceLabel.text = food.foodPrice?.idr
      cell.createDateLabel.text = food.createDate?.formatted()
      
    }else {
      let upcomming = upcomingData[indexPath.row]
      cell.foodNameLabel.text = upcomming.foodName
      cell.foodDescLabel.text = upcomming.foodDescription
      cell.foodCategoryLabel.text = upcomming.foodCategory
      cell.foodPriceLabel.text = "\(upcomming.foodPrice)"
    }
    
    
    return cell
    
  }
  
}

extension UIView {
  class func fromNib<T: UIView>() -> T {
    return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
  }
}

extension UIColor {
  convenience init(hex: String) {
    var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if hexFormatted.hasPrefix("#") {
      hexFormatted.remove(at: hexFormatted.startIndex)
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
    
    let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
    let alpha = CGFloat(1.0)
    
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
