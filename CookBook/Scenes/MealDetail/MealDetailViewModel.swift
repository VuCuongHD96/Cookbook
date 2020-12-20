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
        var backTrigger: Driver<Void>
        var favoriteTrigger: Driver<Void>
        var youtubeTrigger: Driver<Void>
    }
    
    struct Output {
        var mealName: Driver<String>
        var mealCategory: Driver<String>
        var meal: Driver<Meal>
        var mealImage: Driver<String>
        var backed: Driver<Void>
        var sections: Driver<[SectionDataMealDetail]>
        var favorited: Driver<String>
        var openYoutube: Driver<Void>
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
        }.startWith("Meal Name")
        
        let mealCategory = meal.map { meal -> String in
            meal.category
        }.startWith("Meal Category")
        
        let mealImage = meal
            .map { meal -> String in
                meal.imageString
        }
        
        let backed = input.backTrigger
            .map { _ in
                self.navigator.goBack()
        }
        
        let sections = meal.map { meal -> [SectionDataMealDetail] in
            [SectionDataMealDetail(header: "Ingredients", items: meal.getResourceArray()),
                SectionDataMealDetail(header: "Instructions", items: meal.getInstructions())
            ]
        }
        .asDriver()
        
        let favorited = input.favoriteTrigger
            .withLatestFrom(meal)
            .do(onNext: { meal in
                self.useCase.saveMeal(meal: meal)
            })
            .map { _ in
                self.useCase.getHeartOrange()
        }
        
        let openYoutube = input.youtubeTrigger
            .withLatestFrom(meal)
            .do(onNext: { meal in
                self.useCase.openYoutube(with: meal.youtubeURL)
            })
            .mapToVoid()
        
        return Output(mealName: mealName,
                      mealCategory: mealCategory,
                      meal: meal,
                      mealImage: mealImage,
                      backed: backed,
                      sections: sections,
                      favorited: favorited,
                      openYoutube: openYoutube)
    }
}
