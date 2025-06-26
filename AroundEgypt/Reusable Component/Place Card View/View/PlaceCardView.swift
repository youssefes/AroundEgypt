//
//  PlaceCardView.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 24/06/2025.
//

import SwiftUI

struct PlaceCardModel {
    var id: String
    var name: String
    var image: String
    var seenNumber: Int
    var likeCount: Int
    var isRecommended: Bool = false
    var isliked: Bool = false
    var address: String
    var description: String
}

struct PlaceCardView: View {
    var placeCardModel: PlaceCardModel
    @State var showExperienceScreen: Bool = false
    @StateObject var viewModel: PlaceCardViewModel
    init(placeCardModel: PlaceCardModel) {
        self.placeCardModel = placeCardModel
        _viewModel = StateObject(wrappedValue: PlaceCardViewModel(placeCardModel: placeCardModel))
    }
    
    var body: some View {
        VStack(spacing: Dimensions.d16) {
            AsyncImageView(url: URL(string: viewModel.placeCardModel.image))
                .frame(height: Dimensions.d155)
                .cornerRadius(Dimensions.d7)
                .overlay {
                    overlayItems
                        .frame(height: Dimensions.d155)
                }
            nameWithlikeCount
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.showExperienceScreen = true
        }
        .onTapGesture {self.showExperienceScreen = true}
        .sheet(isPresented: $showExperienceScreen, content: {
            ExperienceScreen(viewModel: ExperienceViewModel(placeCardModel: viewModel.placeCardModel), showSheet: $showExperienceScreen)
        })
    }
    
    var nameWithlikeCount: some View {
        HStack(alignment: .center) {
            Text(viewModel.placeCardModel.name)
                .font(.custom(AppFont.bold.name, size: Dimensions.d14))
            
            Spacer()
            
            HStack {
                Button {
                    viewModel.likeExperiences()
                } label: {
                    if viewModel.placeCardModel.isliked {
                        Image(.like)
                    } else {
                        Image(.dislike)
                    }
                }
                .buttonStyle(.plain)
                .disabled(viewModel.placeCardModel.isliked)
                
                Text("\(viewModel.placeCardModel.likeCount)")
                    .font(.custom(AppFont.medium.name, size: Dimensions.d14))
            }
        }
    }
    
    var overlayItems: some View {
        VStack {
            HStack(alignment: .top) {
                if viewModel.placeCardModel.isRecommended {
                    HStack{
                        Image(.favorite)
                        Text("RECOMMENDED")
                            .foregroundStyle(.white)
                            .font(.custom(AppFont.bold.name, size: Dimensions.d10))
                    }
                    .frame(width: Dimensions.d110, height: Dimensions.d18)
                    .background(.black.opacity(0.50))
                    .cornerRadius(Dimensions.d9)
                }
                
                Spacer()
                
                Button {} label: {
                    Image(.info)
                }
            }
            .frame(height: Dimensions.d16)
            .padding(.horizontal, Dimensions.d8)
            
            Spacer()
            Image(.world)
            Spacer()
            
            HStack(alignment: .bottom) {
                HStack(spacing: Dimensions.d6){
                    Image(.eye)
                    Text("\(viewModel.placeCardModel.seenNumber)")
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
}

#Preview {
    PlaceCardView(placeCardModel: PlaceCardModel(id: "1", name: "Nubian House", image: "", seenNumber: 333, likeCount: 234, address: "Aswan, Egypt.", description: ""))
}
