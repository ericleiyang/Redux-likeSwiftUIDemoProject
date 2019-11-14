//
//  RecipeService.swift
//  SwiftUITest
//
//  Created by Eric Yang on 13/11/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import Foundation
import Combine

class RecipeService {
    private struct RecipeResponse: Decodable {
        let hits: [Hit]
        
        struct Hit: Decodable {
            let recipe: Recipe
        }
    }
    
    private enum Constants {
        static let count = 100
    }
    
    func fetch(query: String, page: Int) -> AnyPublisher<[Recipe], Error> {
        let from = page * Constants.count
        let to = from + Constants.count
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.edamam.com"
        components.path = "/search"
        
        components.queryItems = [
            .init(name: "q", value: query),
            .init(name: "from", value: String(from)),
            .init(name: "to", value: String(to)),
            .init(name: "app_id", value: "af1dd513"),
            .init(name: "app_key", value: "14d7fdc54649351cd3531103e09fc830"),
            .init(name: "health", value: "vegan")
        ]
        
        guard let url = components.url else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: RecipeResponse.self, decoder: Current.decoder)
            .map { $0.hits.map{ $0.recipe } }
            .eraseToAnyPublisher()
    }
}
