//
//  ContentView.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 24/06/2025.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var viewModel: HomeViewModel = .init()
    var body: some View {
        BaseView(state: $viewModel.state) {
            VStack(alignment: .leading,spacing: Dimensions.d16){
                
                SearchNavigationBarView(searchText: $viewModel.searchText)
                if !viewModel.searchText.isEmpty {
                    List(viewModel.searchItems, id: \.id) { item in
                        PlaceCardView(placeCardModel: item)
                            .padding(.vertical, Dimensions.d8)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .padding(.top, Dimensions.d8)
                } else {
                    ScrollView(showsIndicators: false){
                        welcomeView
                        recommendedExperiencesView
                        mostRecent
                    }
                }
            }
            .padding(Dimensions.d16)
        }
        .task {
            viewModel.getRecommendedExperiences()
            viewModel.getRecentexperiences()
        }
    }
}

#Preview {
    HomeScreen()
}
