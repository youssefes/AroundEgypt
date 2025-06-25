//
//  HomeScreen+.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 24/06/2025.
//

import SwiftUI

extension HomeScreen {
    var welcomeView: some View {
        VStack(alignment: .leading,spacing: Dimensions.d4) {
            Text("Welcome!")
                .font(.custom(AppFont.roundedBold.name, size: Dimensions.d22))
            Text("Now you can explore any experience in 360 degrees and get all the details about it all in one place.")
                .font(.custom(AppFont.medium.name, size: Dimensions.d15))
        }
    }
    
    var recommendedExperiencesView: some View {
        VStack(alignment: .leading) {
            Text("Recommended Experiences")
                .font(.custom(AppFont.bold.name, size: Dimensions.d22))
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: Dimensions.d16) {
                    ForEach(viewModel.recommendedExperiencesItems, id: \.id) { item in
                        PlaceCardView(placeCardModel: item,width: UIScreen.screenWidth * 0.80)
                    }
                }
                .padding(.vertical,Dimensions.d10)
            }
        }
        .padding(.top,Dimensions.d16)
        .padding(.horizontal,Dimensions.d4)
    }
    
    var mostRecent: some View {
        LazyVStack(alignment: .leading, spacing: Dimensions.d10) {
            Text("Most Recent")
                .font(.custom(AppFont.bold.name, size: Dimensions.d22))
            ForEach(viewModel.mostRecent, id: \.id) { item in
                PlaceCardView(placeCardModel: item)
            }
        }
    }
    
    var listOfSearch: some View {
        List(viewModel.searchItems, id: \.id) { item in
            PlaceCardView(placeCardModel: item)
            .padding(.vertical, Dimensions.d8)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .padding(.top, Dimensions.d8)
    }
}
