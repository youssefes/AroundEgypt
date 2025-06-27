//
//  MockGetRecommendedExperiencesUseCase.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//

import XCTest
@testable import AroundEgypt
class MockGetRecommendedExperiencesUseCase: GetRecommendedExperiencesUseCaseprotocol {
    var result: Result<[ExperiencesData], Error>
    
    init(result: Result<[ExperiencesData], Error>) {
        self.result = result
    }
    
    func fetchRecommendedExperiences() async throws -> [ExperiencesData] {
        switch result {
        case .success(let model): return model
        case .failure(let error): throw error
        }
    }
}
