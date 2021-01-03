//
//  HomeNavigator.swift
//  CookBook
//
//  Created by Apple on 1/14/21.
//  Copyright © 2021 Vu Xuan Cuong. All rights reserved.
//

import UIKit

protocol HomeNavigatorType {
    func getCategoryScreen() -> UIViewController 
}

struct HomeNavigator: HomeNavigatorType {
    unowned let navigationController: UINavigationController

    func getCategoryScreen() -> UIViewController {
        let categoryViewController = CategoryViewController.instantiate()
        let useCase = CategoryUseCase()
        let navigator = CategoryNavigator(navigationController: navigationController)
        let viewModel = CategoryViewModel(navigator: navigator,
                                          useCase: useCase)
        
        categoryViewController.bindViewModel(to: viewModel)
        let categoryIcon = UITabBarItem(title: "Category",
                                 image: UIImage(named: "HomeGrey.png"),
                                 selectedImage: UIImage(named: "HomeOrange.png"))
        categoryViewController.tabBarItem = categoryIcon
        return categoryViewController
    }
}
