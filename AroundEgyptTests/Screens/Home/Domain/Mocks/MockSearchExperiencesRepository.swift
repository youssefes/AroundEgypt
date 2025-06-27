//
//  MockSearchExperiencesRepository.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//

import XCTest
@testable import AroundEgypt

class MockSearchExperiencesRepository: SearchExperiencesRepositoryProtocol {

    var resultToReturn: Result<BaseModel<[ExperiencesData]>, Error>
    
    init(resultToReturn: Result<BaseModel<[ExperiencesData]>, Error>) {
        self.resultToReturn = resultToReturn
    }
    
    func searchExperiences() async throws -> BaseModel<[ExperiencesData]> {
        switch resultToReturn {
        case .success(let model): return model
        case .failure(let error): throw error
        }
    }
}
