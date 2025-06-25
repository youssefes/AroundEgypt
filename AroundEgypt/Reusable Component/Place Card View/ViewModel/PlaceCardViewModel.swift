//
//  PlaceCardViewModel.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
import Foundation
import Combine

class PlaceCardViewModel: BaseViewModel, ObservableObject {
    
    @Published var placeCardModel: PlaceCardModel
    private var likeExperiencesUseCase: LikeExperiencesUseCaseProtocol?
    
    init(placeCardModel: PlaceCardModel,likeExperiencesUseCase: LikeExperiencesUseCaseProtocol? = nil) {
        self.likeExperiencesUseCase = likeExperiencesUseCase
        self.placeCardModel = placeCardModel
    }
    
    // MARK: - Like Experiences
    func likeExperiences() {
        likeExperiencesUseCase = LikeExperiencesUseCase(id: placeCardModel.id)
        Task { @MainActor in 
            do {
                let resulte = try await self.likeExperiencesUseCase?.likeExperiences()
                self.placeCardModel.likeCount = resulte?.data ?? 0
                self.placeCardModel.isliked = true
            } catch {
                print("❌ Error: \(error.localizedDescription)")
                if let networkError = error as? NetworkError {
                    state = .failed(networkError)
                } else {
                    state = .failed(NetworkError.requestFailed(error))
                }
            }
        }
    }
}
