//
//  LoginViewModel.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 12/21/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import RxSwift
import RxCocoa

struct LoginViewModel {
    let navigator: LoginNavigatorType
    let useCase: LoginUseCaseType
}

extension LoginViewModel: ViewModelType {
    struct Input {
        var loadTrigger: Driver<Void>
        var emailTrigger: Driver<String>
        var passTrigger: Driver<String>
        var loginTrigger: Driver<Void>
    }
    
    struct Output {
        var isValid: Driver<Bool>
        var opacityButton: Driver<Float>
        var loginTapped: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let emailOutput = input.emailTrigger
        let passOutput = input.passTrigger
        
        let isValid = Driver.combineLatest(emailOutput, passOutput) { email, pass in
            email.count > 3 && pass.count > 3
        }
        
        let opacityButton = isValid.map { (value) -> Float in
            value ? 1 : 0.2
        }
        
        let loginTapped = input.loginTrigger
            .do(onNext: {
                self.navigator.toHomeScreen()
            })
            .mapToVoid()
        
        return Output(isValid: isValid,
                      opacityButton: opacityButton,
                      loginTapped: loginTapped
        )
    }
}
