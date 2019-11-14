//
//  RecipeDetailView.swift
//  SwiftUITest
//
//  Created by Eric Yang on 14/11/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    private var subheadline: some View {
        Text("\(Int(recipe.calories)) kcal ") +
            Text("\(Int(recipe.totalWeight)) g")
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(recipe.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading) {
                        Text(recipe.title)
                            .font(.title)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        subheadline
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    //ForEach loops views inside the SwiftUI, id: \.self is required to identify each view
                    ForEach(recipe.ingredients, id: \.self) { ingridient in
                        Text(". \(ingridient)")
                        .fixedSize(horizontal: false, vertical: true)
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(
            recipe: .mock
        )
    }
}
