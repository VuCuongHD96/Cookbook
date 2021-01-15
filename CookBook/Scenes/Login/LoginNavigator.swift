//
//  LoginNavigator.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 1/4/21.
//  Copyright © 2021 Vu Xuan Cuong. All rights reserved.
//

import UIKit

protocol LoginNavigatorType {
    func toHomeScreen()
}

struct LoginNavigator: LoginNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toHomeScreen() {
        let viewController = HomeViewController.instantiate()
        let useCase = HomeUseCase()
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        let navigator = HomeNavigator(navigationController: navigationController)
        let viewModel = HomeViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
