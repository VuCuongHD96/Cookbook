//
//  LoginViewController.swift
//  CookBook
//
//  Created by KIMOCHI on 12/20/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import RxSwift
import Reusable
import RxCocoa

final class LoginViewController: UIViewController, BindableType {
    
    // MARK: - Outlet
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var emailTextField: MarginLeftTextField!
    @IBOutlet private weak var passTextField: MarginLeftTextField!
    
    // MARK: - Properties
    var viewModel: LoginViewModel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Data
    func bindViewModel() {
        let input = LoginViewModel.Input(loadTrigger: Driver.just(Void()),
                                         emailTrigger: emailTextField.rx.myText.orEmpty.asDriver(),
                                         passTrigger: passTextField.rx.myText.orEmpty.asDriver(),
                                         loginTrigger: loginButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input)
        
        output.isValid
            .drive(loginButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        
        output.opacityButton
            .drive(loginButtonOpacity)
            .disposed(by: rx.disposeBag)
        
        output.loginTapped
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    // MARK: - Views
    private func setupView() {
        let leftColor = UIColor(named: "LeftOrange")
        let rightColor = UIColor(named: "RightOrange")
        loginButton.setGradientColor(colorOne: leftColor, colorTwo: rightColor, orientation: .leftToRight)
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        navigationController?.navigationBar.isHidden = true
    }
}

extension LoginViewController: StoryboardSceneBased {
    static var sceneStoryboard = StoryBoards.login
}

extension LoginViewController {
    var loginButtonOpacity: Binder<Float> {
        return Binder(self) { viewController, opacityValue in
            viewController.loginButton.layer.opacity = opacityValue
        }
    }
}
