//
//  MealByCategoryRequest.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/27/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import Foundation
import Alamofire

final class MealByCategoryRequest: BaseRequest {
    
    required init(category: String) {
        let body: [String: Any]  = [
            "c" : category
        ]
        super.init(url: URLs.mealByCategory, requestType: .get, body: body)
    }
}
