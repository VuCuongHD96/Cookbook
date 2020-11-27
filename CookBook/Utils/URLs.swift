//
//  URLs.swift
//  SimpleDemoCleanArchitecture
//
//  Created by trinh.giang.dong on 2/22/19.
//  Copyright © 2019 trinh.giang.dong. All rights reserved.
//

import Foundation

struct URLs {
    private static var APIBaseUrl = "https://www.themealdb.com/api/json/v1/1/"
    public static let categories = APIBaseUrl + "categories.php"
    public static let mealByCategory = APIBaseUrl + "filter.php"
    public static let mealDetail = APIBaseUrl + "lookup.php"
}
