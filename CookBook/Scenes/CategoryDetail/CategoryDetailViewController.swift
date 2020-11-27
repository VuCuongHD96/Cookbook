//
//  CategoryDetailViewController.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/27/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import RxDataSources

final class CategoryDetailViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    var viewModel: CategoryDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Views
    private func setupView() {
        navigationItem.title = "Category Detail"
        tableView.dequeueReusableCell(for: TestTableViewCell.self)
    }
    
    // MARK: - Data
    func bindViewModel() {
        let input = CategoryDetailViewModel.Input(loadTrigger: Driver.just(Void()),
                                                  selectTrigger: tableView.rx.itemSelected.asDriver(),
                                                  backTrigger: rightButton.rx.tap.asDriver())
        let output = viewModel.transform(input)
        output.meals
            .drive(tableView.rx.items(cellIdentifier: "cell")) { row, element, cell in
                //                let indexPath = IndexPath(item: index, section: 0)
                //                let cell: CategoryCell = tableView.dequeueReusableCell(for: indexPath)
                //                cell.setContent(data: category)
                //                return cell
                cell.textLabel?.text = element.name
        }
        .disposed(by: rx.disposeBag)
        
        output.categoryName
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        output.categoryImage
            .drive(avatarBinding)
            .disposed(by: rx.disposeBag)
        
        output.selected
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.indicator
            .drive(indicator.rx.isAnimating)
            .disposed(by: rx.disposeBag)
        
        output.indicator
            .drive(indicator.rx.customHidden)
            .disposed(by: rx.disposeBag)
        
        output.backed
            .drive()
            .disposed(by: rx.disposeBag)
        
        
        // Start Test
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(
          configureCell: { dataSource, tableView, indexPath, item in
            let cell: TestTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textLabel?.text = "Item \(item.anInt): \(item.aString) - \(item.aCGPoint.x):\(item.aCGPoint.y)"
            return cell
        }) 
        // End Test
    }
}

extension CategoryDetailViewController {
    var avatarBinding: Binder<String> {
        return Binder(self) { viewController, imageUrl in
            let url = URL(string: imageUrl)
            viewController.categoryImageView.sd_setImage(with: url, completed: nil)
        }
    }
}

extension Reactive where Base: UIActivityIndicatorView {
    var customHidden: Binder<Bool> {
        return Binder(base) { indicator, newStatus in
            indicator.isHidden = !newStatus
        }
    }
}

extension CategoryDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = StoryBoards.categoryDetail
}
