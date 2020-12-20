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
import SkeletonView

final class MealDetailViewController: UIViewController, BindableType {
    
    // MARK: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var mealImageView: UIImageView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var mealNameLabel: UILabel!
    @IBOutlet private weak var youtubeButton: UIButton!
    
    // MARK: - Properties
    var viewModel: MealDetailViewModel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
    }
    
    // MARK: - View
    private func setupView() {
        mealImageView.showAnimatedGradientSkeleton()
    }
    
    // MARK: - Data
    private func setupData() {
        tableView.do {
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 100
            $0.register(cellType: IngredientTableViewCell.self)
            $0.register(cellType: InstructionTableViewCell.self)
        }
    }
    
    func bindViewModel() {
        let input = MealDetailViewModel.Input(loadTrigger: Driver.just(Void()),
                                              backTrigger: backButton.rx.tap.asDriver(),
                                              favoriteTrigger: favoriteButton.rx.tap.asDriver(),
                                              youtubeTrigger: youtubeButton.rx.tap.asDriver())
        let output = viewModel.transform(input)
        
        output.mealName
            .drive(mealNameLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        output.mealCategory
            .drive(categoryLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        output.mealImage
            .drive(avatarBinding)
            .disposed(by: rx.disposeBag)
        
        output.backed
            .drive()
            .disposed(by: rx.disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionDataMealDetail>(
            configureCell: { dataSource, tableView, indexPath, item in
                let section = indexPath.section
                let row = indexPath.row
                switch section {
                case 0:
                    let cell: IngredientTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                    cell.setContent(data: item)
                    return cell
                case 1:
                    let cell: InstructionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                    cell.setContent(index: row, data: item)
                    return cell
                default: break
                }
                return UITableViewCell()
        })
        
        dataSource.titleForHeaderInSection = { dataSource, section in
            return dataSource.sectionModels[section].header 
        }
        
        output.sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        output.favorited
            .drive(favoriteBinding)
            .disposed(by: rx.disposeBag)
        
        output.openYoutube
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension MealDetailViewController {
    var avatarBinding: Binder<String> {
        return Binder(self) { viewcontroller, imageUrl in
            let url = URL(string: imageUrl)
            viewcontroller.mealImageView.sd_setImage(with: url) { [weak self] (_, _, _, _) in
                guard let self = self else { return }
                self.mealImageView.hideSkeleton()
            }
        }
    }
    
    var favoriteBinding: Binder<String> {
        return Binder(self) { viewcontroller, imageName in
            let image = UIImage(named: imageName)
            viewcontroller.favoriteButton.setImage(image, for: .normal)
        }
    }
}

extension MealDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = StoryBoards.mealDetail
}
