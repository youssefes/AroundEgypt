//
//  AsyncImageView.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import SwiftUI
import Kingfisher

public struct AsyncImageView: View {
    let url: URL?
    let placeholder: Image?
    let contentMode: SwiftUI.ContentMode

    public init(
        url: URL?,
        placeholder: Image? = nil,
        contentMode: SwiftUI.ContentMode = .fill
    ) {
        self.url = url
        self.placeholder = placeholder
        self.contentMode = contentMode
    }
    
    public init(
        url: String?,
        placeholder: Image? = nil,
        loadingView: AnyView? = nil,
        contentMode: SwiftUI.ContentMode = .fill,
        isLoaded: Binding<Bool> = .constant(false)
    ) {
        self.url = URL(string: url ?? "")
        self.placeholder = placeholder
        self.contentMode = contentMode
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            kingFisherImageView
        }
    }
    
    @MainActor var kingFisherImageView: some View {
        KFImage.url(url)
            .placeholder {
                ZStack(alignment: .center) {
                    if let placeholder = self.placeholder {
                        placeholder.resizable()
                    }
                }
            }
            .cacheOriginalImage()
            .fromMemoryCacheOrRefresh()
            .loadDiskFileSynchronously()
            .fade(duration: 0.2)
            .resizable()
            .onProgress { _, _ in
                // Intentionally unimplemented...
            }
            .onFailure { _ in
                if let placeholder = self.placeholder {
                    _ = placeholder.resizable()
                }
            }
            .aspectRatio(contentMode: contentMode)
    }
}
