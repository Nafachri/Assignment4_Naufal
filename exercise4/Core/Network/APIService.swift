//
//  APIService.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 16/07/24.
//

import RxSwift

protocol APIService {
  func request<T: Decodable>(_ api: any API, of: T.Type) -> Single<T>
  func request<T: Decodable>(_ api: any API) -> Single<T>
}
