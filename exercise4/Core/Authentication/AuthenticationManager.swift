//
//  AuthenticationManager.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 16/07/24.
//

import RxSwift

class AuthenticationManager: AuthenticationService {
  
  let apiManager: APIService
  
  init(apiManager: APIService) {
    self.apiManager = apiManager
  }
  
  func signIn(username: String, password: String) -> Single<SignInResponse> {
    apiManager.request(AuthenticationAPI.signin(username: username, password: password))
  }
  
  
}
