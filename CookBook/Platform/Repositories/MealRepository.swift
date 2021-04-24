//
//  MealRepository.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/27/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import Foundation
import RxSwift

protocol MealRepositoryType {
    func getMeals(input: MealByCategoryRequest) -> Observable<[Meal]>
//    func getMeal(input: MealRequest) -> Observable<Meal>
    func getMeals(input: MealRequest) -> Observable<[Meal]>
}

class MealRepository: MealRepositoryType {
    private let api: APIService = APIService.share
    
    func getMeals(input: MealByCategoryRequest) -> Observable<[Meal]> {
        return api.request(input: input)
            .map { (response: MealResponse) -> [Meal] in
                return response.meals
        }
    }

    func getMeals(input: MealRequest) -> Observable<[Meal]> {
        return api.request(input: input)
            .map { (response: MealResponse) -> [Meal] in
                return response.meals
        }
    }
}
