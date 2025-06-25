//
//  likeExperiencesUseCase.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
import Combine

protocol LikeExperiencesUseCaseProtocol{
    func likeExperiences() async throws -> BaseModel<Int>
}

class LikeExperiencesUseCase: LikeExperiencesUseCaseProtocol {
    var id: String
    var repository: LikeExperiencesRepositoryProtocol
    
    init(id: String, repository: LikeExperiencesRepositoryProtocol?  = nil) {
        self.id = id
        self.repository = repository ?? LikeExperiencesRepository(id: id)
    }
    
    func likeExperiences() async throws -> BaseModel<Int>{
        return try await repository.likeExperiences()
    }

}
