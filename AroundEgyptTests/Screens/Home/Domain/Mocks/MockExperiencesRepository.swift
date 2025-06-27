//
//  MockExperiencesRepository.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//

import XCTest
@testable import AroundEgypt

class MockExperiencesRepository: GetExperiencesRepositoryProtocol {
    var resultToReturn: Result<[ExperiencesData], Error>
    
    init(resultToReturn: Result<[ExperiencesData], Error>) {
        self.resultToReturn = resultToReturn
    }
    
    func fetchExperiences() async throws -> [ExperiencesData] {
        switch resultToReturn {
        case .success(let model): return model
        case .failure(let error): throw error
        }
    }
}
