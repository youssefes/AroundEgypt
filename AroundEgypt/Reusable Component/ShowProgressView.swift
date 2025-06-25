//  SearchNavigationBarView.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 24/06/2025.
//

import SwiftUI

struct ShowProgressView: View {
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.75)
                .ignoresSafeArea()
        }
        VStack{
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.white)
                .scaleEffect(1)
            Spacer()
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
