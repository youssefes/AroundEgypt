//
//  SearchNavigationBarView.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 24/06/2025.
//

import SwiftUI

struct SearchNavigationBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack(spacing: Dimensions.d15) {
            Image(.menu)
                .resizable()
                .frame(width: Dimensions.d18, height: Dimensions.d12)
            SearchBarWithIcon(searchText: $searchText, placholder: "Try “Luxor”")
            Image(.filter)
                .resizable()
                .frame(width: Dimensions.d18, height: Dimensions.d12)
        }
    }
}

#Preview {
    SearchNavigationBarView(searchText: .constant(""))
}
