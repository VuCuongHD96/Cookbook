//
//  GradientOrientation.swift
//  webview
//
//  Created by Vu Xuan Cuong on 11/17/20.
//

import UIKit

enum GradientOrientation {
    case topToBottom
    case leftToRight
    
    func getPoints() -> [CGPoint] {
        switch self {
        case .topToBottom:
            return [CGPoint(x: 0, y: 1),
                    CGPoint(x: 0,y: 0)]
        case .leftToRight:
            return [CGPoint(x: 0, y: 0),
                    CGPoint(x: 1, y: 0)]
        }
    }
}
