//
//  Environment.swift
//  SwiftUITest
//
//  Created by Eric Yang on 13/11/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import Foundation

struct Environment {
    var counter = LaunchCounter()
    var decoder = JSONDecoder()
    var encoder = JSONEncoder()
    var fetch = RecipeService().fetch
    var files = FileManager.default
}

let Current = Environment()

class LaunchCounter {
    private enum Launcher {
        static let first = "launcher_first.v1.1"
        static let count = "launcher_count"
        static let minLaunchCount = 7
        static let minDays = 2
    }
    
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    var isReadyToRate: Bool {
        let count = defaults.integer(forKey: Launcher.count)
        let first = defaults.object(forKey: Launcher.first) as? Date ?? Date(timeIntervalSince1970: 0)
        let days = Calendar.current.dateComponents([.day], from: first, to: Date()).day ?? 0
        
        return days > Launcher.minDays && count > Launcher.minLaunchCount
    }
    
    @discardableResult
    func launch() -> Int {
        if defaults.object(forKey: Launcher.first)  == nil {
            defaults.set(Date(), forKey: Launcher.first)
        }
        
        var count = defaults.integer(forKey: Launcher.count)
        count += 1
        defaults.set(count, forKey: Launcher.count)
        
        return count
    }
}
