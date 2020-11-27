//
//  CategoryDetailNavigator.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/27/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit

protocol CategoryDetailNavigatorType {
    func toMealDetail(mealInput: Meal)
    func goBack()
}

struct CategoryDetailNavigator: CategoryDetailNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toMealDetail(mealInput: Meal) {
        let viewController = MealDetailViewController.instantiate()
        let useCase = MealDetailUseCase()
        let navigator = MealDetailNavigator(navigationController: navigationController)
        let viewModel = MealDetailViewModel(navigator: navigator,
                                            useCase: useCase,
                                            mealInput: mealInput)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
