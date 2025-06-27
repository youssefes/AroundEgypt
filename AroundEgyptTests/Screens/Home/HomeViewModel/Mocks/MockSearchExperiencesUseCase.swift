//
//  MockSearchExperiencesUseCase.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//

import Foundation
import XCTest
@testable import AroundEgypt

class MockSearchExperiencesUseCase: SearchExperiencesUseCaseProtocol {
    
    
    var result: Result<BaseModel<[ExperiencesData]>, Error>
    
    init(result: Result<BaseModel<[ExperiencesData]>, Error>) {
        self.result = result
    }
    
    func searchExperiences() async throws -> BaseModel<[ExperiencesData]> {
        switch result {
        case .success(let model): return model
        case .failure(let error): throw error
        }
    }
    
    func setSearchText(searchText: String) {}
}
