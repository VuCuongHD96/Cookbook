//
//  GradientOrientation.swift
//  CookBook
//
//  Created by KIMOCHI on 1/3/21.
//  Copyright © 2021 Vu Xuan Cuong. All rights reserved.
//

import UIKit

enum GradientOrientation {
    case topToBottom
    case leftToRight

    func getPoints() -> [CGPoint] {
        switch self {
        case .topToBottom:
            return [CGPoint(x: 0, y: 1),
                    CGPoint(x: 0, y: 0)]
        case .leftToRight:
            return [CGPoint(x: 0, y: 0),
                    CGPoint(x: 1, y: 0)]
        }
    }
}
