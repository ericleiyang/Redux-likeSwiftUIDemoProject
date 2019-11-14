//
//  Store.swift
//  SwiftUITest
//
//  Created by Eric Yang on 13/11/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import Foundation
import Combine

protocol Effect {
    associatedtype Action
    func mapToAction() -> AnyPublisher<Action, Never>
}

struct Reducer<State, Action> {
    let reduce: (inout State, Action) -> Void
}

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State

    private let reducer: Reducer<State, Action>
    private var cancellables: Set<AnyCancellable> = []

    init(initialState: State, reducer: Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }

    func send(_ action: Action) {
        reducer.reduce(&state, action)
    }

    func send<E: Effect>(_ effect: E) where E.Action == Action {
        effect
            .mapToAction()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: send)
            .store(in: &cancellables)
    }
}

extension Store where State: Codable {
    func save() {
        let customisedQueue = DispatchQueue(label: "Redux-like queue", qos: .utility)
        customisedQueue.async {
            guard let documentURL = Current.files.urls(for: .applicationSupportDirectory, in: .userDomainMask).first,
                let data = try? Current.encoder.encode(self.state)
                else {
                    return
            }
            
            try? Current.files.createDirectory(at: documentURL, withIntermediateDirectories: true, attributes: nil)
            let stateURL = documentURL.appendingPathComponent("state.json")
            if Current.files.fileExists(atPath: stateURL.absoluteString) {
                try? Current.files.removeItem(at: stateURL)
            }
            
            try? data.write(to: stateURL, options: .atomic)
        }
    }
    
    func load() {
        let customisedQueue = DispatchQueue(label: "Redux-like queue", qos: .utility)
        customisedQueue.async {
            guard let documentURL = Current.files.urls(for: .applicationSupportDirectory, in: .userDomainMask).first,
                let data = try? Data(contentsOf: documentURL.appendingPathComponent("state.json")),
                let state = try? Current.decoder.decode(State.self, from: data)
                else {
                    return
            }
            
            DispatchQueue.main.async {
                self.state = state
            }
        }
    }
}
