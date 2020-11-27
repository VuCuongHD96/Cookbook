//
//  CategoryDetailViewModel.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/27/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MGArchitecture

struct CategoryDetailViewModel {
    let navigator: CategoryDetailNavigatorType
    let useCase: CategoryDetailUseCaseType
    let category: Category
}

extension CategoryDetailViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
        let backTrigger: Driver<Void>
    }
    
    struct Output {
        let meals: Driver<[Meal]>
        let selected: Driver<Void>
        let categoryName: Driver<String>
        let categoryImage: Driver<String>
        let error: Driver<Error>
        let indicator: Driver<Bool>
        let backed: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        
        let meals = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getMeal(by: self.category)
                    .trackActivity(indicator)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
        }
        
        let selected = input.selectTrigger
            .withLatestFrom(meals) { indexPath, mealArray in
                return mealArray[indexPath.row]
        }
        .do(onNext: { meal in
            self.navigator.toMealDetail(mealInput: meal)
        })
            .mapToVoid()
        
        let categoryName = input.loadTrigger
            .map { _ in
                return self.category.name
        }
        
        let categoryImage = input.loadTrigger
            .map { _ in
                return self.category.imageString
        }
        
        let backed = input.backTrigger
            .do(onNext: { _ in
                self.navigator.goBack()
            })
            .mapToVoid()
        
        return Output(
            meals: meals,
            selected: selected,
            categoryName: categoryName,
            categoryImage: categoryImage,
            error: error.asDriver(),
            indicator: indicator.asDriver(),
            backed: backed
        )
    }
}

