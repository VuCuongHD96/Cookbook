//
//  InstructionTableViewCell.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 12/2/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import Reusable

final class InstructionTableViewCell: UITableViewCell, NibReusable {

    // MARK: - Outlet
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var instructionName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Data
    func setContent(index: Int, data: String) {
        numberLabel.text = String(index + 1)
        instructionName.text = data
    }
}
