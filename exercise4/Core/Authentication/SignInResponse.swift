//
//  SignInResponse.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 16/07/24.
//

import Foundation

struct SignInResponse: Decodable {
  var message: String
  var isSuccess: Bool
}
