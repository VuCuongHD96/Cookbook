//
//  LoginViewController.swift
//  CookBook
//
//  Created by KIMOCHI on 12/20/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import RxSwift

final class LoginViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet private weak var loginButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Views
    private func setupView() {
        let leftColor = UIColor(named: "LeftOrange")
        let rightColor = UIColor(named: "RightOrange")
        loginButton.setGradientColor(colorOne: leftColor, colorTwo: rightColor, orientation: .leftToRight)
    }
}
