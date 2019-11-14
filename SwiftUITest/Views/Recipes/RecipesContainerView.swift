//
//  RecipesContainerView.swift
//  SwiftUITest
//
//  Created by Eric Yang on 14/11/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import SwiftUI

struct RecipesContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    let query: String
    
    var body: some View {
        RecipesView(recipes: store.state.recipes)
            .navigationBarTitle(Text(query.capitalized), displayMode: .inline)
            .onAppear(perform: fetch)
    }
    
    private func fetch() {
        store.send(SideEffect.search(query: query))
    }
}
