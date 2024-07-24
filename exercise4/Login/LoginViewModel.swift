//
//  LoginViewModel.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 15/07/24.
//

import Foundation
import RxCocoa

class LoginViewModel : NSObject {
  let name: Driver<String>
  let password: Driver<String>
  
  init(name: Driver<String>, password: Driver<String>) {
    self.name = name
    self.password = password
  }
}

