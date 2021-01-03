//
//  LoginNavigator.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 1/4/21.
//  Copyright © 2021 Vu Xuan Cuong. All rights reserved.
//

import UIKit

protocol LoginNavigatorType {
    func toCategoryScreen()
    func toHomeScreen()
}

struct LoginNavigator: LoginNavigatorType {
    unowned let navigationController: UINavigationController

    func toCategoryScreen() {
        let viewController = CategoryViewController.instantiate()
        let useCase = CategoryUseCase()
        let navigator = CategoryNavigator(navigationController: navigationController)
        let viewModel = CategoryViewModel(navigator: navigator, useCase: useCase)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toHomeScreen() {
        let viewController = HomeViewController.instantiate()
        let useCase = HomeUseCase()
        let navigator = HomeNavigator(navigationController: navigationController)
        let viewModel = HomeViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
