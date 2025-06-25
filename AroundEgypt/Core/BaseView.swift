//
//  BaseView.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 24/06/2025.
//

import SwiftUI

public enum ViewModelState<Error> {
    case idle
    case loading(message: String? = nil)
    case successful
    case failed(APIRequestProviderError)
}

struct BaseView<Content>: View where Content: View {
    // MARK: - PROPERTIES
    let content: Content
    @Binding private var state: ViewModelState<BaseError>
    // MARK: - INIT
    public init(
        state: Binding<ViewModelState<BaseError>>,
        @ViewBuilder content: () -> Content
    ) {
        self._state = state
        self.content = content()
    }

    public var body: some View {
        ZStack {
            content
            if case .loading = state {
                Spacer()
                ShowProgressView()
                Spacer()
            }
        }
    }
}
