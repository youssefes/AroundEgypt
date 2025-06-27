//
//  MockLikeExperiencesRepository.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 26/06/2025.
//

import XCTest
@testable import AroundEgypt

class MockLikeExperiencesRepository: LikeExperiencesRepositoryProtocol {
    var resultToReturn: Result<BaseModel<Int>, Error>
    
    init(resultToReturn: Result<BaseModel<Int>, Error>) {
        self.resultToReturn = resultToReturn
    }
    
    func likeExperiences() async throws -> BaseModel<Int> {
        switch resultToReturn {
        case .success(let model): return model
        case .failure(let error): throw error
        }
    }
}
