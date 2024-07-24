//
//  NotificationTableViewCell.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 20/07/24.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
  
  @IBOutlet weak var darkModeSwitch: UISwitch!
  @IBOutlet weak var notificationIcon: UIImageView!
  @IBOutlet weak var notificationDetailLabel: UILabel!
  @IBOutlet weak var notificationLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
    darkModeSwitch.isOn = darkModeEnabled
    updateAppearance(isDarkMode: darkModeEnabled)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  @IBAction func switchButton(_ sender: UISwitch) {
    let isDarkMode = sender.isOn
    UserDefaults.standard.set(isDarkMode, forKey: "darkModeEnabled")
    updateAppearance(isDarkMode: isDarkMode)
  }
  
  private func updateAppearance(isDarkMode: Bool) {
      let style: UIUserInterfaceStyle = isDarkMode ? .dark : .light
      
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
          for window in windowScene.windows {
              window.overrideUserInterfaceStyle = style
          }
      }
  }
  
}
