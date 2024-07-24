//
//  ProfileViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 19/07/24.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  var profile: [[String: Any]] = [
    ["profileLabel": "Profile Information", "profileDetailLabel": "Change your account information", "profileIcon":"person.fill"],
    ["profileLabel": "Change Password", "profileDetailLabel": "Change your password", "profileIcon":"lock.fill"],
  ]
  
  var notification: [[String: Any]] = [
    ["notificationLabel": "Dark Mode", "notificationDetailLabel": "Choose your preference", "profileIcon":"bell.fill"],
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "profile_cell")
    
    tableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "notification_cell")
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(withIdentifier: "profile_cell", for: indexPath) as! ProfileTableViewCell
          let data = profile[indexPath.row]
          cell.profileLabel.text = "\(data["profileLabel"]!)"
          cell.profileDetailLabel.text = "\(data["profileDetailLabel"]!)"
          cell.profileIcon.image = UIImage(systemName: "\(data["profileIcon"]!)")
          return cell
      } else {
          let cell = tableView.dequeueReusableCell(withIdentifier: "notification_cell", for: indexPath) as! NotificationTableViewCell
          return cell
      }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
      return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return profile.count
    } else {
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 1 {
      return
    }
    
    let selectedProfile = profile[indexPath.row]
    

    if let profileLabel = selectedProfile["profileLabel"] as? String, profileLabel == "Profile Information" {
        let profileDetailVC = ProfileDetailViewController(nibName: "ProfileDetailViewController", bundle: nil)
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let nav = appDelegate?.window?.rootViewController as? UINavigationController
        
        nav?.pushViewController(profileDetailVC, animated: true)
    } else if let passwordLabel = selectedProfile["profileLabel"] as? String, passwordLabel == "Change Password" {
      let changePasswordDetailVC = ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: nil)
      
      let appDelegate = UIApplication.shared.delegate as? AppDelegate
      let nav = appDelegate?.window?.rootViewController as? UINavigationController
      nav?.pushViewController(changePasswordDetailVC, animated: true)
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
    headerView.backgroundColor = .systemBackground
    let label = UILabel()
    label.frame = CGRect.init(x: 16, y: -8, width: headerView.frame.width-10, height: headerView.frame.height-10)
    label.textColor = .systemGray2
    if section == 0{
      label.text = "PERSONAL"
    }else {
      label.text = "NOTIFICATION"
    }
    headerView.addSubview(label)

    return headerView
  }
  
}
