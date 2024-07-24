//
//  FeaturesPartnerCollectionViewCell.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 18/07/24.
//

import UIKit

class FeaturesPartnerCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var collectionView: UICollectionView!
  
  var foods: [FoodModel] = [] {
    didSet {
      collectionView.reloadData()
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    foods = []
    collectionView.reloadData()
  }
  
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
    return foods.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let food = foods[indexPath.row]
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "features_item_cell", for: indexPath) as! FeaturesPartnerItemCollectionViewCell
    cell.populate(image: food.image, food: food.foodName, address: food.address)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let selectedItem = foods[indexPath.row]
    let foodDetailVC = FoodDetailViewController(selectedItem: selectedItem)
    _ = UINavigationController(rootViewController: foodDetailVC)
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let nav = appDelegate?.window?.rootViewController as? UINavigationController
    nav?.pushViewController(foodDetailVC, animated: true)
  }
  
  
}

extension FeaturesPartnerCollectionViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: 200, height: 254)
  }
}
