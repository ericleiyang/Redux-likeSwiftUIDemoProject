//
//  Recipe.swift
//  SwiftUITest
//
//  Created by Eric Yang on 13/11/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import Foundation

struct Recipe: Codable, Hashable {
    let title: String
    let ingredients: [String]
    let image: URL
    let calories: Double
    let totalWeight: Double
    let url: URL
    let cautions: [String]
    
    enum CodingKeys: String, CodingKey {
        case title = "label"
        case ingredients = "ingredientLines"
        case image
        case calories
        case totalWeight
        case url
        case cautions
    }
}

extension Recipe {
    static let mock = Recipe(
        title: "Breakfast",
        ingredients: ["123",
                      "123",
                      "123"],
        image: URL(string: "https://www.edamam.com/web-img/70a/70aaa8022bf8706c375551c44718eaab.jpg")!,
        calories: 10,
        totalWeight: 10,
        url: URL(string: "http://www.seriouseats.com/recipes/2008/03/sack-lunch-fairytale-picnic-fresh-pickled-vegetables-recipe.html")!,
        cautions: []
    )
}
