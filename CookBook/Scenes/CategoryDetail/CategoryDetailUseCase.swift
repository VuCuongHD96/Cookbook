//
//  CategoryDetailUseCase.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/27/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CategoryDetailUseCaseType {
    func getMeal(by category: Category) -> Observable<[Meal]>
}

struct CategoryDetailUseCase: CategoryDetailUseCaseType {
    func getMeal(by category: Category) -> Observable<[Meal]> {
        let request = MealByCategoryRequest(category: category.name)
        let repository = MealRepository()
        return repository.getMeals(input: request)
    }
}
