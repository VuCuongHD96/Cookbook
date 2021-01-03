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
    func saveMeal(meal: Meal)
    func getHeartOrange() -> String
    func openYoutube(with urlString: String) 
}

struct MealDetailUseCase: MealDetailUseCaseType {
    func getMeal(meal: Meal) -> Observable<[Meal]> {
        let request = MealRequest(id: meal.id)
        let repository = MealRepository()
        return repository.getMeals(input: request)
    }
    
    func saveMeal(meal: Meal) {
        print("Save Meal")
    }
    
    func getHeartOrange() -> String {
        let imageName = "FavoriteOrange"
        return imageName
    }
    
    func openYoutube(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
