//
//  SigninResponse.swift
//  PetCenter
//
//  Created by Phincon on 01/07/24.
//

import Foundation


struct SignInResponse: Responseable {
  var data: SignInResponse.UserToken?
  var message: String
  var success: Bool
}

extension SignInResponse {
  struct UserToken: Decodable {
    let email: String
    let token: String
  }
}

