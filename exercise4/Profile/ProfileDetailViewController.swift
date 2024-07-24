//
//  ProfileDetailViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 24/07/24.
//

import UIKit

class ProfileDetailViewController: UIViewController {

  @IBOutlet weak var changePasswordButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
    changePasswordButton.layer.cornerRadius = 8
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
