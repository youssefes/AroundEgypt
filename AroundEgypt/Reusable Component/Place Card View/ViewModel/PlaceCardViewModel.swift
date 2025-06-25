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
    private var likeExperiencesUseCase: LikeExperiencesUseCase?
    
    init(placeCardModel: PlaceCardModel,likeExperiencesUseCase: LikeExperiencesUseCase? = nil) {
        self.likeExperiencesUseCase = likeExperiencesUseCase
        self.placeCardModel = placeCardModel
    }
    
    // MARK: - Like Experiences
    func likeExperiences() {
        likeExperiencesUseCase = LikeExperiencesUseCase(id: placeCardModel.id)
        likeExperiencesUseCase?.execute(BaseModel<Int>.self)
            .receive(on: RunLoop.main)
            .sink { [weak self] complition in
                guard let self = self  else {return}
                self.state = .successful
                switch complition {
                case .finished:
                    print("finish")
                case .failure(let error):
                    self.state = .failed(.requestFailed(error: error))
                }
            } receiveValue: {[weak self]  resulte in
                guard let self = self else {return}
                if (resulte.meta.code ?? 0) == 200 {
                    self.placeCardModel.likeCount = resulte.data ?? 0
                    self.placeCardModel.isliked = true
                } else {
                    self.state = .failed(.server(statusCode: (resulte.meta.code ?? 0), data: nil))
                }
                
            }.store(in: &cancellables)
    }
}
