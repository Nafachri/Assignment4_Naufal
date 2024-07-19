//
//  AuthenticationService.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 16/07/24.
//

import Foundation
import RxSwift

protocol AuthenticationService {
  func signIn(username: String, password: String) -> Single<SignInResponse>
}
