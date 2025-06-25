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
}

struct PlaceCardView: View {
    var placeCardModel: PlaceCardModel
    var width: CGFloat?
    var body: some View {
        VStack(spacing: Dimensions.d16) {
            AsyncImageView(url: URL(string: placeCardModel.image)!)
                .frame(width: width,height: Dimensions.d155)
                .frame(maxWidth: width ?? .infinity)
                .cornerRadius(Dimensions.d7)
                .overlay {
                    overlayItems
                }
            
            nameWithlikeCount
        }
    }
    
    var nameWithlikeCount: some View {
        HStack(alignment: .center) {
            Text(placeCardModel.name)
                .font(.custom(AppFont.bold.name, size: Dimensions.d14))
            Spacer()
            HStack {
                Image(.like)
                Text("\(placeCardModel.likeCount)")
                    .font(.custom(AppFont.medium.name, size: Dimensions.d14))
            }
        }
    }
    
    var overlayItems: some View {
        VStack {
            HStack(alignment: .top) {
                if placeCardModel.isRecommended {
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
                    Text("\(placeCardModel.seenNumber)")
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
    PlaceCardView(placeCardModel: PlaceCardModel(id: "1", name: "Nubian House", image: "", seenNumber: 333, likeCount: 234))
}
