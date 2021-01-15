//
//  HomeViewController.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 1/4/21.
//  Copyright © 2021 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift

final class HomeViewController: UITabBarController, BindableType {
    
    // MARK: - Properties
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        let input = HomeViewModel.Input(loadTrigger: Driver.just(Void()))
        
        let output = viewModel.transform(input)
        
        let categoryScreen = output.categoryScreen
        viewControllers = [categoryScreen]
    }
}

extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = StoryBoards.main
}
