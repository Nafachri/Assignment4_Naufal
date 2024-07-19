//
//  FoodDetailViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 18/07/24.
//

import UIKit

class FoodDetailViewController: UIViewController {

  @IBOutlet weak var takeAwayUIButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
    takeAwayUIButton.layer.borderWidth = 1
    takeAwayUIButton.layer.borderColor = UIColor(hex: "#EEA734").cgColor
    takeAwayUIButton.layer.cornerRadius = 8
    }
}



