//
//  MealResponse.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/27/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

final class MealResponse : Mappable {
    var meals = [Meal]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        meals <- map["meals"]
    }
}
