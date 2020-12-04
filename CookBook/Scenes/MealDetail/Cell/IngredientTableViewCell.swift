//
//  IngredientTableViewCell.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 12/2/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import Reusable

final class IngredientTableViewCell: UITableViewCell, NibReusable {

    // MARK: - Outlet
    @IBOutlet private weak var ingredientsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Data
    func setContent(data: String) {
        ingredientsLabel.text = data
    }
}
