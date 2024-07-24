//
//  FeaturesPartnerCollectionReusableView.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 18/07/24.
//

import UIKit

class FeaturesPartnerCollectionReusableView: UICollectionReusableView {
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var headerButton: UIButton!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
  func hideButton(_ hide: Bool) {
//    headerButton.isHidden = hide
  }
}
