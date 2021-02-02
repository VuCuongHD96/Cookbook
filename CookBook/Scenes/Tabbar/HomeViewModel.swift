//
//  HomeViewModel.swift
//  CookBook
//
//  Created by Apple on 1/14/21.
//  Copyright © 2021 Vu Xuan Cuong. All rights reserved.
//

import RxSwift
import RxCocoa
import MGArchitecture

struct HomeViewModel {
    let useCase: HomeUseCase
    let navigator: HomeNavigator
}

extension HomeViewModel: ViewModelType {
    struct Input {
        var loadTrigger: Driver<Void>
    }
    
    struct Output {
        var categoryScreen: UIViewController
    }
    
    func transform(_ input: Input) -> Output {
        let categoryScreen = navigator.getCategoryScreen()
        return Output(categoryScreen: categoryScreen)
    }
}
