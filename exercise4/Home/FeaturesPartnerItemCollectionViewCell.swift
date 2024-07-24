//
//  FeaturesPartnerItemCollectionViewCell.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 18/07/24.
//

import UIKit

class FeaturesPartnerItemCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var foodName: UILabel!
  
  @IBOutlet weak var addressLabel: UILabel!
  
  func populate(image: String?, food: String?, address: String?) {
    self.imageView.image = UIImage(named: image ?? "") ?? UIImage(named: "food 1")
    foodName.text = food
    addressLabel.text = address
  }

}
