//
//  SideEffect.swift
//  SwiftUITest
//
//  Created by Eric Yang on 14/11/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import Combine

enum SideEffect: Effect {
    case search(query: String, page: Int = 0)
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case let .search(query, page):
            return Current.fetch(query, page)
                .replaceError(with: [])
                .map{ .append(recipes: $0, nextPage: page + 1) }
                .prepend(.set(loading: true))
                .eraseToAnyPublisher()
        }
    }
}
