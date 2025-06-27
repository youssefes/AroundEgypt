//
//  MockLikeExperiencesUseCase.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 26/06/2025.
//

import Foundation
@testable import AroundEgypt

class MockLikeExperiencesUseCase: LikeExperiencesUseCaseProtocol {
    var result: Result<BaseModel<Int>, Error>
    
    init(result: Result<BaseModel<Int>, Error>) {
        self.result = result
    }
    
    func likeExperiences() async throws -> BaseModel<Int> {
        switch result {
        case .success(let model): return model
        case .failure(let error): throw error
        }
    }
}
