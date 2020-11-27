//
//  MealDetailViewController.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/29/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift

final class MealDetailViewController: UIViewController, BindableType {
    
    var viewModel: MealDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Meal Detail"
    }
    
    func bindViewModel() {
        let input = MealDetailViewModel.Input(loadTrigger: Driver.just(Void()))
        let output = viewModel.transform(input)
        
        output.mealName
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        output.meal
            .drive(onNext: { (meal) in
                print(meal)
            })
            .disposed(by: rx.disposeBag)
    }
}

extension MealDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = StoryBoards.mealDetail
}
