//
//  PaymentTableViewCell.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 18/07/24.
//

import UIKit

class PaymentItemTableViewCell: UITableViewCell {

  @IBOutlet weak var foodItemUIView: UIView!
  override func awakeFromNib() {
        super.awakeFromNib()
    foodItemUIView.layer.borderWidth = 1
    foodItemUIView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
