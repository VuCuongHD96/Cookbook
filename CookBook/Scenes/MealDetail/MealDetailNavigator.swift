//
//  MealDetailNavigator.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 11/26/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit

protocol MealDetailNavigatorType {
    func goBack()
}

struct MealDetailNavigator: MealDetailNavigatorType {
    unowned let navigationController: UINavigationController

    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
