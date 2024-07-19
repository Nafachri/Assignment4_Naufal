//
//  HomeViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 17/07/24.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "home_cell")
    collectionView.register(UINib(nibName: "FeaturesPartnerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "features_collection_cell")
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(
        UINib(nibName: "FeaturesPartnerCollectionReusableView", bundle: Bundle(for: FeaturesPartnerCollectionReusableView.self)),
        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
        withReuseIdentifier: "FeaturesPartnerCollectionReusableView"
    )
    
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 8
    layout.minimumInteritemSpacing = 8
    collectionView.collectionViewLayout = layout
    
    title = "Dashboard"
  }
}

extension HomeViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    2
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else {
      return 6
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionHeader else {
      return UICollectionReusableView()
    }
    
    var isHideButton = indexPath.section == 1
    let headerView = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: "FeaturesPartnerCollectionReusableView",
      for: indexPath
    ) as! FeaturesPartnerCollectionReusableView
    
    if indexPath.section == 0 {
      headerView.headerLabel.text = "Features Restaurant".uppercased()
      headerView.headerButton.setTitle("SEE ALL", for: .normal)
    } else {
      headerView.headerLabel.text = "Best Restaurant".uppercased()
    }
    
    headerView.hideButton(isHideButton)
    
    return headerView
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.section == 1 {
      let foodDetailVC = FoodDetailViewController(nibName: "FoodDetailViewController", bundle: nil)
      self.navigationController?.pushViewController(foodDetailVC, animated: true)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "features_collection_cell", for: indexPath) as! FeaturesPartnerCollectionViewCell
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "home_cell", for: indexPath) as! HomeCollectionViewCell
      return cell
    }
    
  }
  
  
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.section == 0 {
      return CGSize(width: collectionView.frame.size.width, height: 270)
    } else {
      let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
      let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
      let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
      
      return CGSize(width: size, height: 348)
    }
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      CGSize(width: collectionView.frame.width, height: 40)
  }
}
