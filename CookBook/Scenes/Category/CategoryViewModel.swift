//
//  CategoryViewModel.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/26/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MGArchitecture

struct CategoryViewModel {
    let navigator: CategoryNavigatorType
    let useCase: CategoryUseCaseType
}

extension CategoryViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let categories: Driver<[Category]>
        let selected: Driver<Void>
        let error: Driver<Error>
        let indicator: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        
        let categories = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getCategories()
                    .trackActivity(indicator)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }
        
        let selected = input.selectTrigger
            .withLatestFrom(categories) { indexPath, repos in
                return repos[indexPath.row]
            }
            .do(onNext: { category in
                self.navigator.toCategoryDetail(category: category)
            })
            .mapToVoid()
        
        return Output(
            categories: categories,
            selected: selected,
            error: error.asDriver(),
            indicator: indicator.asDriver()
        )
    }
}
