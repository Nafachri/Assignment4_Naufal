//
//  ProfileViewModel.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 04/09/24.
//

import Foundation
import RxSwift

class ProfileViewModel {
    
    // Outputs
    let profileItems: Observable<[ProfileItem]>
    let notificationItems: Observable<[NotificationItem]>
    
    // Initialization
    init() {
        // Mock data setup
        let profileData: [ProfileItem] = [
            ProfileItem(profileLabel: "Profile Information", profileDetailLabel: "Change your account information", profileIcon: "person.fill"),
            ProfileItem(profileLabel: "Change Password", profileDetailLabel: "Change your password", profileIcon: "lock.fill")
        ]
        
        let notificationData: [NotificationItem] = [
            NotificationItem(notificationLabel: "Dark Mode", notificationDetailLabel: "Choose your preference", profileIcon: "bell.fill")
        ]
        
        profileItems = Observable.just(profileData)
        notificationItems = Observable.just(notificationData)
    }
    
    func didSelectProfileItem(at index: Int) -> ProfileItem {
        let profileData: [ProfileItem] = [
            ProfileItem(profileLabel: "Profile Information", profileDetailLabel: "Change your account information", profileIcon: "person.fill"),
            ProfileItem(profileLabel: "Change Password", profileDetailLabel: "Change your password", profileIcon: "lock.fill")
        ]
        return profileData[index]
    }
}
