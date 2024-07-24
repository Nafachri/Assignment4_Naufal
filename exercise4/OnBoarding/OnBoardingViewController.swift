//
//  OnBoardingViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 22/07/24.
//

import UIKit

class OnBoardingViewController: UIViewController {

  @IBOutlet weak var uiButton: UIButton!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var collectionView: UICollectionView!
  var data: [OnBoarding] = [
    OnBoarding(image: "onboarding1", title: "Welcome", subTitle: "It’s a pleasure to meet you. We are excited that you’re here so let’s get started!"),
    OnBoarding(image: "onboarding2", title: "All your favorites", subTitle: "Order from the best local restaurants with easy, on-demand delivery."),
    OnBoarding(image: "onboarding3", title: "Free delivery offers", subTitle: "Free delivery for new customers via Apple Pay and others payment methods."),
    OnBoarding(image: "onboarding4", title: "Choose your food", subTitle: "Easily find your type of food craving and you’ll get delivery in wide range.")
  ]
  override func viewDidLoad() {
        super.viewDidLoad()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    uiButton.layer.cornerRadius = 8
    
    collectionView.register(UINib(nibName: "OnBoardingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "onboarding_cell")

    collectionView.isPagingEnabled = true
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    layout.scrollDirection = .horizontal
    collectionView.collectionViewLayout = layout
    
    pageControl.numberOfPages = data.count
    pageControl.currentPage = 0
    }
  @IBAction func gettingStartedButtonTapped(_ sender: UIButton) {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    appDelegate?.window?.rootViewController =  UINavigationController(rootViewController: LoginViewController())
    }
}

extension OnBoardingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboarding_cell", for: indexPath) as! OnBoardingCollectionViewCell
    let item = data[indexPath.row]
    cell.populate(item)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    collectionView.frame.size
  }
}

extension OnBoardingViewController: UIScrollViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let x = scrollView.contentOffset.x
    let w = scrollView.bounds.size.width
    let currentPage = Int(ceil(x/w))
    pageControl.currentPage = currentPage
    uiButton.isHidden = currentPage != data.count - 1
  }
}
