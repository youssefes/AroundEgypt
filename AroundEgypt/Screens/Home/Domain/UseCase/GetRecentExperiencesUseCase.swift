//
//  GetRecentExperiencesUseCase.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
import Combine

protocol GetRecentExperiencesUseCaseProtocol {
    func fetchRecentExperiences() async throws -> [ExperiencesData]
}

class GetRecentExperiencesUseCase: GetRecentExperiencesUseCaseProtocol {
    
    var repository: GetExperiencesRepositoryProtocol
    init(repository: GetExperiencesRepositoryProtocol = RecentExperiencesRepository()) {
        self.repository = repository
    }
    
    func fetchRecentExperiences() async throws -> [ExperiencesData] {
        return try await repository.fetchExperiences()
    }
    
}
