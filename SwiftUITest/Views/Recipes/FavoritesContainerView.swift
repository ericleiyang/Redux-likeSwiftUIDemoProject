//
//  FavoritesContainerView.swift
//  SwiftUITest
//
//  Created by Eric Yang on 14/11/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import SwiftUI

struct FavoritesContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    var body: some View {
        RecipesView(recipes: store.state.favorited)
            .navigationBarTitle("Favorites")
    }
}
