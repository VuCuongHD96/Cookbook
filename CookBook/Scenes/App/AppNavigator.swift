//
//  AppNavigator.swift
//  SimpleDemoCleanArchitecture
//
//  Created by trinh.giang.dong on 2/22/19.
//  Copyright © 2019 trinh.giang.dong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AppNavigatorType {
    func toLogin()
    func toCategory()
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow
    
    func toLogin() {
        let viewController = LoginViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: viewController)
        let useCase = LoginUseCase()
        let navigator = LoginNavigator(navigationController: navigationController)
        let viewModel = LoginViewModel(navigator: navigator, useCase: useCase)
        viewController.bindViewModel(to: viewModel)
        window.rootViewController = navigationController
    }
    
    func toCategory() {
        let viewController = CategoryViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: viewController)
        let useCase = CategoryUseCase()
        let navigator = CategoryNavigator(navigationController: navigationController)
        let viewModel = CategoryViewModel(navigator: navigator, useCase: useCase)
        viewController.bindViewModel(to: viewModel)
        window.rootViewController = navigationController
    }
}
