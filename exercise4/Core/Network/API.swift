//
//  API.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 16/07/24.
//

import Alamofire

protocol API {
  var url: URLConvertible { get }
  var method: HTTPMethod { get }
  var params: Parameters? { get }
}
