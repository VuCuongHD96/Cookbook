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
}
