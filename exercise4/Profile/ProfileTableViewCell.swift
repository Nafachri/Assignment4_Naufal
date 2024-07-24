//
//  ProfileTableViewCell.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 19/07/24.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

  @IBOutlet weak var profileLabel: UILabel!
  @IBOutlet weak var profileDetailLabel: UILabel!
  @IBOutlet weak var profileIcon: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
