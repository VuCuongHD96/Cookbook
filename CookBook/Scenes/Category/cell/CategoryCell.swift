//
//  CategoryCell.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/27/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import SDWebImage
import Reusable
import SkeletonView

final class CategoryCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var namelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAnimation()
    }
    
    private func showAnimation() {
        categoryImageView.showAnimatedGradientSkeleton()
    }

    func setContent(data: Category) {
        namelabel.text = data.name
        categoryImageView.sd_setImage(with: URL(string: data.imageString)) { [weak self] (_, _, _, _) in
            guard let self = self else { return }
            self.categoryImageView.hideSkeleton()
        }
    }
}
