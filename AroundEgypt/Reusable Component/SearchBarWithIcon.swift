//
//  SearchBar.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 24/06/2025.
//

import SwiftUI

struct SearchBarWithIcon: View {
    @Binding var searchText: String
    var placholder: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placholder, text: $searchText)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(.custom(AppFont.light.name, size: Dimensions.d17))
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(Dimensions.d8)
        .background(.searchBackground.opacity(0.12))
        .cornerRadius(Dimensions.d10)
    }
}

#Preview {
    SearchBarWithIcon(searchText: .constant(""), placholder: "Try “Luxor”")
}
