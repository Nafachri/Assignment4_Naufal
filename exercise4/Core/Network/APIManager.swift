//
//  APIManager.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 16/07/24.
//

import RxSwift
import Alamofire

enum APIManagerError: Error {
  case noValue
  case alamofire(AFError)
}

class APIManager: APIService {
  
  func request<T: Decodable>(_ api: any API, of: T.Type) -> Single<T> {
    Single<T>.create { single in
      
      let req = AF.request(api.url, method: api.method, parameters: api.params).responseDecodable(of: T.self) { response in
        switch response.result {
        case .success(let value):
          single(.success(value))
        case .failure(let error):
          single(.failure(error))
        }
      }
      
      return Disposables.create {
        req.cancel()
      }
    }
  }
  
  func request<T>(_ api: any API) -> Single<T> where T : Decodable {
    request(api, of: T.self)
  }
  
}
