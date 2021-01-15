//
//  HomeViewController.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 1/4/21.
//  Copyright © 2021 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import Reusable

final class HomeViewController: UITabBarController, BindableType {
    
    // MARK: - Properties
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItemViewController()
        setupView()
    }
    
    func bindViewModel() {
        print("ddddd")
    }

    private func setupItemViewController() {
        guard let navigationController = navigationController else {
            return
        }
        
        
        let controllers = [categoryViewController]
        viewControllers = controllers
    }
    
    private func setupView() {
        
    }
}

extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = StoryBoards.main
}
