//
//  FeaturesPartnerCollectionViewCell.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 18/07/24.
//

import UIKit

class FeaturesPartnerCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  func setup() {
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UINib(nibName: "FeaturesPartnerItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "features_item_cell")
  }
}

extension FeaturesPartnerCollectionViewCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "features_item_cell", for: indexPath) as! FeaturesPartnerItemCollectionViewCell
    return cell
  }
  
  
}

extension FeaturesPartnerCollectionViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: 200, height: 254)
  }
}
