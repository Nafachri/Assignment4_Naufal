//
//  OnBoardingCollectionViewCell.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 22/07/24.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

  func populate(_ onboarding: OnBoarding){
    imageView.image = UIImage(named: onboarding.image)
    titleLabel.text = onboarding.title
    subtitleLabel.text = onboarding.subTitle
  }
}
