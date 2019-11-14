//
//  Category.swift
//  SwiftUITest
//
//  Created by Eric Yang on 14/11/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import Foundation

struct Home {
    static let categories = [
        Category(title: "Breakfast", query: "breakfast"),
        Category(title: "Lunch", query: "lunch"),
        Category(title: "Dinner", query: "dinner"),
        Category(title: "Smoothie", query: "smoothie"),
        Category(title: "Dessert", query: "dessert")
    ]
}

struct Category {
    let title: String
    let query: String
}
