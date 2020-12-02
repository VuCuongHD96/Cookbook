//
//  Meal.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/27/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

struct FoodResource: Hashable {
    var ingredient: String
    var measure: String
}

protocol MealType {
    func getResourceArray() -> [String]
    func getInstructions() -> [String]
}

struct Meal {
    struct Constants {
        static let endArray = 20
    }
        
    var id: String
    var name: String
    var imageString: String
    var description: String
    var area: String
    var category: String
    var instructions: String
    var resources: [FoodResource]
}

extension Meal: MealType {
    func getResourceArray() -> [String] {
        resources.map { foodResource -> String in
            return foodResource.measure + " " + foodResource.ingredient
        }
    }
    
    func getInstructions() -> [String] {
        let instructionArray = instructions.components(separatedBy: .newlines)
            .filter { $0 != "" }
        return instructionArray
    }
}

extension Meal {
    init() {
        self.init(
            id: "",
            name: "",
            imageString: "",
            description: "",
            area: "",
            category: "",
            instructions: "",
            resources: [FoodResource]()
        )
    }
}

extension Meal: Hashable {
}

extension Meal: BaseModel {

    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        id <- map["idMeal"]
        name <- map["strMeal"]
        imageString <- map["strMealThumb"]
        description <- map[""]
        area <- map["strArea"]
        category <- map["strCategory"]
        instructions <- map["strInstructions"]
        imageString <- map["strMealThumb"]
        (1...Constants.endArray).forEach { index in
            var ingredient = ""
            var measure = ""
            ingredient <- map["strIngredient\(index)"]
            measure <- map["strMeasure\(index)"]
            if ingredient != "" {
                resources.append(FoodResource(ingredient: ingredient, measure: measure))
            }
        }
    }
}
