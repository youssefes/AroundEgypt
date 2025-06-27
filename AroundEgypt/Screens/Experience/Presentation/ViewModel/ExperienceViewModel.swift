//
//  ExperienceViewModel.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
import Combine

class ExperienceViewModel: BaseViewModel, ObservableObject {
    
    @Published var placeCardModel: PlaceCardModel
    private var likeExperiencesUseCase: LikeExperiencesUseCaseProtocol?
    init(placeCardModel: PlaceCardModel,likeExperiencesUseCase: LikeExperiencesUseCaseProtocol? = nil) {
        self.placeCardModel = placeCardModel
        self.likeExperiencesUseCase = likeExperiencesUseCase ?? LikeExperiencesUseCase(id: placeCardModel.id)
    }
    
    // MARK: - Like Experiences
    func likeExperiences() {
        Task { @MainActor in 
            do {
                let resulte = try await self.likeExperiencesUseCase?.likeExperiences()
                self.placeCardModel.likeCount = resulte?.data ?? 0
                self.placeCardModel.isliked = true
            } catch {
                if let networkError = error as? NetworkError {
                    state = .failed(networkError)
                } else {
                    state = .failed(NetworkError.requestFailed(error))
                }
            }
        }
    }
}
