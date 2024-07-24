//
//  Requestable.swift
//  PetCenter
//
//  Created by Phincon on 01/07/24.
//

import Alamofire

typealias Method = HTTPMethod
typealias URLConvertible = Alamofire.URLConvertible
typealias PCError = AFError

protocol Requestable {
  func request<T: Responseable>(_ url: URLConvertible, method: Method, params: [String: Any], onComplete: @escaping (Result<T, PCError>) -> Void)
}

class NetworkRequest: Requestable {
  func request<T>(_ url: any URLConvertible, method: Method, params: [String : Any], onComplete: @escaping (Result<T, PCError>) -> Void) where T : Responseable {
    
    AF.request(url, method: method, parameters: params)
      .responseDecodable(of: T.self) { dataResponse in
        switch dataResponse.result {
        case .success(let value):
          if value.success == false {
            onComplete(.failure(PCError.responseValidationFailed(reason: .unacceptableStatusCode(code: 0))))
          } else {
            onComplete(.success(value))
          }
        case .failure(let error):
          onComplete(.failure(error))
        }
      }
    
  }
}
