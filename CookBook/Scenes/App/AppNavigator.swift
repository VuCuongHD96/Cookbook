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
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow
    
    func toMain() {
        let viewController = CategoryViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: viewController)
        let navigator = CategoryNavigator(navigationController: navigationController)
        let useCase = CategoryUseCase()
        let viewModel = CategoryViewModel(navigator: navigator, useCase: useCase)
        
        viewController.bindViewModel(to: viewModel)
        window.rootViewController = navigationController
    }
}
