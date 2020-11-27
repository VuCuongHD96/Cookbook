//
//  CategoryDetailViewController+.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/29/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit

extension CategoryDetailViewController {
    func showMealDetail() {
        let mealDetailScreen = MealDetailViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: mealDetailScreen)
        present(navigationController, animated: true, completion: nil)
    }
}
