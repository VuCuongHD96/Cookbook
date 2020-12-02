//
//  MealDetailViewModel.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 11/26/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MGArchitecture

struct MealDetailViewModel {
    let navigator: MealDetailNavigatorType
    let useCase: MealDetailUseCaseType
    let mealInput: Meal
}

extension MealDetailViewModel: ViewModelType {
    struct Input {
        var loadTrigger: Driver<Void>
    }
    
    struct Output {
        var mealName: Driver<String>
        var meal: Driver<Meal>
        var sections: Driver<[SectionDataMealDetail]>
    }
    
    func transform(_ input: Input) -> Output {
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        
        let meal = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getMeal(meal: self.mealInput)
                    .map { mealArray -> Meal in
                        return mealArray[0]
                }
                .trackActivity(indicator)
                .trackError(error)
                .asDriverOnErrorJustComplete()
        }
        
        let mealName = meal.map { meal -> String in
                meal.name
        }
        
        let sections = meal.map { meal -> [SectionDataMealDetail] in
            [
                SectionDataMealDetail(header: "AÄaaa", items: meal.getResourceArray()),
                SectionDataMealDetail(header: "BBBB", items: meal.getInstructions())
            ]
        }
        .asDriver()
        
        return Output(mealName: mealName,
                      meal: meal,
                      sections: sections)
    }
}
