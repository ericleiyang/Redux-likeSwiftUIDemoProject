//
//  HomeContainer.swift
//  SwiftUITest
//
//  Created by Eric Yang on 14/11/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import SwiftUI

// @State: The property wrapper to ask SWiftUI to manage the memory.
//         State is great for simple properties that belong to a specific view and never get used outside that view.
//         Important to be private.
//         Simple local property like: String, Integer

// @ObservedObject: More complex property, might have multiple properties and methods, might be shared accross multiple views
//         External reference, should confirm ObservableObjec protocol
//         use @Published property wrapper for an observed object to notifiy views that data has changed (must be on the main thread)

// @EnvironmentObject: The value is made available to the views through the application itself. It's a shared data that every view can read.


struct HomeContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @State private var favoritesShown = false
    
    private var hasFavorites: Bool {
        !store.state.favorited.isEmpty
    }
    
    // Some is an opaque key work to reverse a generic type
    // Can do return a specify
    var body: some View {
        HomeView()
            .onAppear{ self.store.send(.resetState) }
            .navigationBarTitle("Recipes")
            .navigationBarItems(
                trailing: hasFavorites ? Button(action: {self.favoritesShown = true}){
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .accessibility(label: Text("Favorites"))
                } : nil
        ).sheet(isPresented: $favoritesShown) {
            FavoritesContainerView()
                .environmentObject(self.store)
                .embedInNavigation()
        }
    }
}


extension View {
    func embedInNavigation() -> some View {
        NavigationView { self }
    }
}
