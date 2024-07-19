//
//  FoodOrderTableViewCell.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 17/07/24.
//

import UIKit

class FoodOrderTableViewCell: UITableViewCell {

  @IBOutlet weak var foodNameLabel: UILabel!
  
  @IBOutlet weak var createDateLabel: UILabel!
  @IBOutlet weak var foodPriceLabel: UILabel!
  @IBOutlet weak var foodCategoryLabel: UILabel!
  @IBOutlet weak var foodDescLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
  
//  func populate(model: Food) {
//    foodNameLabel.text = model.foodName
//  }
    
  override func prepareForReuse() {
    super.prepareForReuse()
    createDateLabel.text = "-"
  }
}
