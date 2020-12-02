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
import RxDataSources

final class MealDetailViewController: UIViewController, BindableType {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MealDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 470
        tableView.delegate = self
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
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionDataMealDetail>(
            configureCell: { dataSource, tableView, indexPath, item in
                var cell = UITableViewCell()
                let section = indexPath.section
                switch section {
                case 0:
                    cell = tableView.dequeueReusableCell(withIdentifier: "CellA", for: indexPath)
                case 1:
                    cell = tableView.dequeueReusableCell(withIdentifier: "CellB", for: indexPath)
                default: break
                }
                cell.textLabel?.text = item
                return cell
        })
        
        dataSource.titleForHeaderInSection = { dataSource, section in
            return dataSource.sectionModels[section].header
        }
        
        output.sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }
}

extension MealDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MealDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = StoryBoards.mealDetail
}
