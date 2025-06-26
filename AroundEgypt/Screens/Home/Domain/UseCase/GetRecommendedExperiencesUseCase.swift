//
//  GetRecommendedExperiencesUseCase.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
import Combine
protocol GetRecommendedExperiencesUseCaseprotocol {
    func fetchRecommendedExperiences() async throws -> [ExperiencesData]
}

class GetRecommendedExperiencesUseCase: GetRecommendedExperiencesUseCaseprotocol {

    let repository: RecommendedExperiencesRepositoryProtocol
    
    init(repository: RecommendedExperiencesRepositoryProtocol =  RecommendedExperiencesRepository()) {
        self.repository = repository
    }
    
    func fetchRecommendedExperiences() async throws -> [ExperiencesData] {
        return try await repository.fetchRecommendedExperiences()
    }
}
