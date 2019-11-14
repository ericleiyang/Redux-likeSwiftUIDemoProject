//
//  RecipesView.swift
//  SwiftUITest
//
//  Created by Eric Yang on 14/11/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import Grid
import SwiftUI
import KingfisherSwiftUI

struct RecipesView: View {
    let recipes: [Recipe]
    
    private var grid: some View {
        Grid {
            ForEach(recipes, id: \.self) { recipe in
                NavigationLink(destination: RecipeDetailsContainerView(recipe: recipe)) {
                    ZStack(alignment: .bottomLeading) {
                        KFImage(recipe.image)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                        
                        LinearGradient (
                            gradient: .init(colors: [.clear, .gray]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        
                        Text(recipe.title)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
        }.gridStyle(FixedColumnsGridStyle(columns: 2, itemHeight: 200, spacing: 0))
    }
    
    var body: some View {
        Group {
            if recipes.isEmpty {
                ActivityView()
            }else {
                grid
            }
        }
    }
}

struct RecipesView_Preview: PreviewProvider {
    static var previews: some View {
        RecipesView(recipes: [.mock, .mock, .mock, .mock])
    }
}
