//
//  MarginLeftTextField.swift
//  CookBook
//
//  Created by KIMOCHI on 1/3/21.
//  Copyright © 2021 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class MarginLeftTextField: UITextField {
    
    //    public var myText: String!
    
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension Reactive where Base: MarginLeftTextField {
    var myText: ControlProperty<String?> {
        return base.rx.controlProperty(
            editingEvents: .allEditingEvents,
            getter: { textField in
                return textField.text
        }) { textField, newText in
            textField.text = newText
        }
    }    
}
