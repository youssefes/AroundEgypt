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
    private var experiencesLocal: ExperiencesLocalProtocol?
    init(placeCardModel: PlaceCardModel,likeExperiencesUseCase: LikeExperiencesUseCaseProtocol? = nil,experiencesLocal: ExperiencesLocalProtocol? = nil) {
        self.likeExperiencesUseCase = likeExperiencesUseCase
        self.placeCardModel = placeCardModel
        self.experiencesLocal = experiencesLocal
    }
    
    // MARK: - Like Experiences
    func likeExperiences() {
        likeExperiencesUseCase = LikeExperiencesUseCase(id: placeCardModel.id)
        Task {  @MainActor [weak self] in
            guard let self else { return }
            do {
                let resulte = try await likeExperiencesUseCase?.likeExperiences()
                placeCardModel.likeCount = resulte?.data ?? 0
                placeCardModel.isliked = true
                updateLocal()
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
    
    func updateLocal() {
        if placeCardModel.isRecommended {
            self.experiencesLocal = RecommendedExperiencesLocal()
        } else {
            self.experiencesLocal = RecentExperiencesLocal()
        }
        
        if let localData = self.experiencesLocal {
            try? localData.updateExperiences(
                experience: ExperiencesData(
                    id: placeCardModel.id,
                    title: placeCardModel.name,
                    coverPhoto: placeCardModel.image,
                    description: placeCardModel.description,
                    viewsNo: placeCardModel.seenNumber,
                    likesNo: placeCardModel.likeCount,
                    recommended: (placeCardModel.isRecommended ? 1 : 0),
                    isLiked: (placeCardModel.isliked ? 1 : 0),
                    address: placeCardModel.address
                )
            )
        }
    }
}
