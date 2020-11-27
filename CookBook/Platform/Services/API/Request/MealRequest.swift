//
//  MealRequest.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 11/26/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import Foundation
import Alamofire

final class MealRequest: BaseRequest {
    
    required init(id: String) {
        let body: [String: Any]  = [
            "i" : id
        ]
        super.init(url: URLs.mealDetail, requestType: .get, body: body)
    }
}
