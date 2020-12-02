//
//  MealDetailUseCase.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 11/26/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

protocol MealDetailUseCaseType {
    func getMeal(meal: Meal) -> Observable<[Meal]>
}

struct MealDetailUseCase: MealDetailUseCaseType {
    
    func getMeal(meal: Meal) -> Observable<[Meal]> {
        let request = MealRequest(id: meal.id)
        let repository = MealRepository()
        return repository.getMeals(input: request)
    }
}
