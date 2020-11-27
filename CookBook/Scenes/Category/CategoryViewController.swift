//
//  CategoryViewController.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/26/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import NSObject_Rx
import Then

final class CategoryViewController: UIViewController, BindableType {
    
    // Mark: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    // Mark: - Properties
    var viewModel: CategoryViewModel!
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    // MARK: - Views
    private func setupView() {
        tableView.do {
            $0.rowHeight = 300
            $0.register(cellType: CategoryCell.self)
        }
    }
    
    // Mark: - Data
    func bindViewModel() {
        let useCase = CategoryUseCase()
        let categoryNavigator = CategoryNavigator(navigationController: navigationController!)
        let viewModel = CategoryViewModel(navigator: categoryNavigator, useCase: useCase)
        
        let input = CategoryViewModel.Input(loadTrigger: Driver.just(Void()),
                                            selectTrigger: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        output.categories
            .drive(tableView.rx.items) { tableView, index, category in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: CategoryCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setContent(data: category)
                return cell
        }
        .disposed(by: rx.disposeBag)
        
        output.selected
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension CategoryViewController: StoryboardSceneBased {
    static var sceneStoryboard = StoryBoards.main
}
