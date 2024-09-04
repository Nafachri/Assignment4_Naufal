//
//  LoginViewModel.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 15/07/24.
//

import Foundation
import RxSwift
import RxRelay

class LoginViewModel {
    
    // Input
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let signInTapped = PublishRelay<Void>()
    
    // Output
    let isLoading = BehaviorRelay<Bool>(value: false)
    let errorMessage = PublishRelay<String?>()
    let signInSuccess = PublishRelay<Void>()
    
    private let authService: AuthenticationServiceable
    private let disposeBag = DisposeBag()

    init(authService: AuthenticationServiceable = AuthenticationService(requestor: NetworkRequest())) {
        self.authService = authService
        bindActions()
    }

  private func bindActions() {
      signInTapped
          .flatMapLatest { [weak self] _ -> Observable<Result<Void, Error>> in
              guard let self = self else { return .empty() }
              
              self.isLoading.accept(true)
              
              return Observable.create { observer in
                  self.authService.signIn(email: self.email.value, password: self.password.value) { result in
                      self.isLoading.accept(false)
                      
                      switch result {
                      case .success:
                          observer.onNext(.success(()))
                          observer.onCompleted()
                      case .failure(let error):
                          observer.onNext(.failure(error))
                          observer.onCompleted()
                      }
                  }
                  return Disposables.create()
              }
          }
          .observe(on: MainScheduler.instance)
          .subscribe(onNext: { [weak self] result in
              switch result {
              case .success:
                  self?.signInSuccess.accept(())
              case .failure(let error):
                  self?.errorMessage.accept(error.localizedDescription)
              }
          })
          .disposed(by: disposeBag)
  }

}
