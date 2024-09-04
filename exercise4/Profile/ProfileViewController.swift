//
//  ProfileViewController.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 19/07/24.
//

// ProfileViewController.swift

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private var viewModel: ProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ProfileViewModel()
        
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "profile_cell")
        tableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "notification_cell")
        
        setupBindings()
    }
    
    private func setupBindings() {
        // Bind profileItems to tableView
        viewModel.profileItems
            .bind(to: tableView.rx.items(cellIdentifier: "profile_cell", cellType: ProfileTableViewCell.self)) { row, item, cell in
                cell.profileLabel.text = item.profileLabel
                cell.profileDetailLabel.text = item.profileDetailLabel
                cell.profileIcon.image = UIImage(systemName: item.profileIcon)
            }
            .disposed(by: disposeBag)
        
        // Handle row selection
        tableView.rx.modelSelected(ProfileItem.self)
            .subscribe(onNext: { [weak self] profileItem in
                self?.handleProfileSelection(profileItem)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleProfileSelection(_ profileItem: ProfileItem) {
        if profileItem.profileLabel == "Profile Information" {
            let profileDetailVC = ProfileDetailViewController(nibName: "ProfileDetailViewController", bundle: nil)
            navigationController?.pushViewController(profileDetailVC, animated: true)
        } else if profileItem.profileLabel == "Change Password" {
            let changePasswordDetailVC = ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: nil)
            navigationController?.pushViewController(changePasswordDetailVC, animated: true)
        }
    }
}
