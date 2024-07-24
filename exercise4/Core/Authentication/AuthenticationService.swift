//
//  AuthenticationService.swift
//  PetCenter
//
//  Created by Phincon on 01/07/24.
//

import Foundation
import KeychainSwift

protocol AuthenticationServiceable {
  func signIn(email: String, password: String, onComplete: @escaping (Result<SignInResponse, PCError>) -> Void)
}

class AuthenticationService: AuthenticationServiceable {
  
  let requestor: Requestable
  let baseAPI = "http://localhost:3001"
  
  init(requestor: Requestable) {
    self.requestor = requestor
  }
  
  func signIn(email: String, password: String, onComplete: @escaping (Result<SignInResponse, PCError>) -> Void) {

    
    requestor.request(
      "\(baseAPI)/auth/signin", method: .post,
      params: [
        "email": email,
        "password": password]
    ) { (result: Result<SignInResponse, PCError>) in
      onComplete(result)
      switch result {
      case .success(let success):
        
        //keychain
        guard let userEmail = success.data?.email, let userToken = success.data?.token else {
          return
        }
        
        let keychain = KeychainSwift()
        keychain.set(userEmail, forKey: "userEmail")
        keychain.set(userToken, forKey: "userToken")

        break
      case .failure(_): break;
      }
    }
    
    
    
  }
  
  
}
