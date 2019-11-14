//
//  HomeView.swift
//  SwiftUITest
//
//  Created by Eric Yang on 14/11/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    let category: Category
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(category.query)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
            
            LinearGradient (
                //.secondary, .primary color are for auto light/dark mode.
                gradient: .init(colors: [.clear, .secondary]),
                startPoint: .center,
                endPoint: .bottom
            )
            
            Text(category.title)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
            
        }
    }
}

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(0..<Home.categories.count) { index in
                    NavigationLink(destination: RecipesContainerView(query: Home.categories[index].query)) {
                        CategoryView(category: Home.categories[index])
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
