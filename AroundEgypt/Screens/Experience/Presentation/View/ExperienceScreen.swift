//
//  ExperienceScreen.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import SwiftUI

struct ExperienceScreen: View {
    @ObservedObject var viewModel: ExperienceViewModel
    @Binding var showSheet: Bool
    var body: some View {
        VStack(alignment: .leading,spacing: Dimensions.d10){
            topView
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading, spacing: Dimensions.d20){
                    nameAndAddressView
                    Divider()
                    descriptionView
                }
            }
            .padding(.horizontal, Dimensions.d16)
        }
    }
}

#Preview {
    ExperienceScreen(viewModel: ExperienceViewModel(placeCardModel: PlaceCardModel(id: "", name: "name", image: "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg", seenNumber: 44, likeCount: 44, isRecommended: false, address: "Aswan, Egypt.", description: "")), showSheet: .constant(false))
}
