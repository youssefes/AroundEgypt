//
//  ExperienceScreen+Properties.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import SwiftUI

extension ExperienceScreen {
    
    var topView: some View {
        VStack {
            AsyncImageView(url: URL(string: viewModel.placeCardModel.image))
                .frame(height: Dimensions.d285)
                .frame(maxWidth: .infinity)
                .clipped()
                .overlay {
                    overlayItems
                }
        }
        .frame(maxWidth: UIScreen.screenWidth)
    }
    
    private var overlayItems: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Text("EXPLORE NOW")
                    .font(.custom(AppFont.bold.name, size: Dimensions.d14))
                    .foregroundStyle(DesignSystem.Colors.main.color)
                    .padding(Dimensions.d16)
                    .background(.white)
                    .cornerRadius(Dimensions.d7)
            }
            .frame(height: Dimensions.d46)
            
            Spacer()
            
            HStack(alignment: .bottom) {
                HStack(spacing: Dimensions.d6){
                    Image(.eye)
                    Text("\(viewModel.placeCardModel.seenNumber) views")
                        .foregroundStyle(.white)
                        .font(.custom(AppFont.medium.name, size: Dimensions.d14))
                }
               
                Spacer()
                Button {} label: {
                    Image(.multiplePictures)
                }
            }
            .frame(height: Dimensions.d16)
            .padding(.horizontal, Dimensions.d8)
           
        }
        .padding(.vertical, Dimensions.d16)
    }
    
    
    var nameAndAddressView: some View {
        VStack(alignment: .leading,spacing: Dimensions.d16) {
            HStack {
                Text(viewModel.placeCardModel.name)
                    .font(.custom(AppFont.bold.name, size: Dimensions.d16))
                Spacer()
                HStack(spacing: Dimensions.d10) {
                    Image(.share)
                    Button {
                        viewModel.likeExperiences()
                    } label: {
                        if viewModel.placeCardModel.isliked {
                            Image(.like)
                        } else {
                            Image(.dislike)
                        }
                    }
                    .disabled(viewModel.placeCardModel.isliked)

                    Text("\(viewModel.placeCardModel.likeCount)")
                        .font(.custom(AppFont.medium.name, size: Dimensions.d14))
                }
            }
            Text("\(viewModel.placeCardModel.address)")
                .foregroundStyle(DesignSystem.Colors.subtitle.color)
                .font(.custom(AppFont.medium.name, size: Dimensions.d16))
        }
    }
    
    var descriptionView: some View {
        VStack(alignment: .leading,spacing: Dimensions.d6){
            Text("Description")
                .foregroundStyle(DesignSystem.Colors.title.color)
                .font(.custom(AppFont.bold.name, size: Dimensions.d22))
            Text("\(viewModel.placeCardModel.description)")
                .foregroundStyle(DesignSystem.Colors.title.color)
                .font(.custom(AppFont.medium.name, size: Dimensions.d14))
        }
    }
}
