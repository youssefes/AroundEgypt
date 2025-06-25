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
                SearchNavigationBarView(searchText: $viewModel.searchText, performSearch: {
                    viewModel.searchExperiences()
                })
                
                if !viewModel.searchText.isEmpty {
                    listOfSearch
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
