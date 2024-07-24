//
//  HomeViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 17/07/24.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var featuredFoods = [FoodModel]()
  var bestFoods = [FoodModel]()
  var indonesianFoods = [FoodModel]()
  
  let coredata = CoreDataManager.shared
  
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
    
    loadCoreData()
  }
  
  func loadCoreData() {
    guard let foods = try? coredata.fetch(entity: FoodModel.self),
    foods.count > 6 else { return }
    featuredFoods = Array(foods[0...3])
    bestFoods = Array(foods[4...7])
    indonesianFoods = Array(foods[8..<foods.count])
    collectionView.reloadData()
  }
}

extension HomeViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    3
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else if section == 1 {
      return bestFoods.count
    } else {
      return 1
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionHeader else {
      return UICollectionReusableView()
    }
    
    let isHideButton = indexPath.section == 1
    let headerView = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: "FeaturesPartnerCollectionReusableView",
      for: indexPath
    ) as! FeaturesPartnerCollectionReusableView
    
    if indexPath.section == 0 {
      headerView.headerLabel.text = "Features Restaurant".uppercased()
//      headerView/*.*/headerButton.setTitle("SEE ALL", for: .normal)
    } else if indexPath.section == 1 {
      headerView.headerLabel.text = "Best Restaurant".uppercased()
    } else {
      headerView.headerLabel.text = "Indonesian Restaurant".uppercased()
//      headerView.headerButton.setTitle("SEE ALL", for: .normal)
    }
    
    headerView.hideButton(isHideButton)
    
    return headerView
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      switch indexPath.section {
      case 1:
          if indexPath.row < bestFoods.count {
            let selectedItem = bestFoods[indexPath.row]
            let foodDetailVC = FoodDetailViewController(selectedItem: selectedItem)
            let navigationController = UINavigationController(rootViewController: foodDetailVC)
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let nav = appDelegate?.window?.rootViewController as? UINavigationController
            nav?.pushViewController(foodDetailVC, animated: true)
          }
      default : break
      }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "features_collection_cell", for: indexPath) as! FeaturesPartnerCollectionViewCell
      cell.foods = featuredFoods
      return cell
    } else if indexPath.section == 1 {
      let food = bestFoods[indexPath.row]
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "home_cell", for: indexPath) as! HomeCollectionViewCell
      cell.foodImageView.image = UIImage(named: food.image ?? "") ?? UIImage(named: "food 1")
      cell.foodNameLabel.text = food.foodName
      cell.foodCategoryLabel.text = food.foodCategory
      return cell
    }else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "features_collection_cell", for: indexPath) as! FeaturesPartnerCollectionViewCell
      cell.foods = indonesianFoods
      return cell
    }
  }
  
  
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.section == 0 {
      return CGSize(width: collectionView.frame.size.width, height: 270)
    } else if indexPath.section == 1 {
      let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
      let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
      let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
      
      return CGSize(width: size, height: 348)
    } else {
      return CGSize(width: collectionView.frame.size.width, height: 270)
    }
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      CGSize(width: collectionView.frame.width, height: 40)
  }
}
