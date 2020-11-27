//
//  CategoryNavigator.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/26/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol CategoryNavigatorType {
    func toCategoryDetail(category: Category)
}

struct CategoryNavigator: CategoryNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toCategoryDetail(category: Category) {
        let viewController = CategoryDetailViewController.instantiate()
        let useCase = CategoryDetailUseCase()
        let navigator = CategoryDetailNavigator(navigationController: navigationController)
        let viewModel = CategoryDetailViewModel(navigator: navigator,
                                                useCase: useCase,
                                                category: category)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
