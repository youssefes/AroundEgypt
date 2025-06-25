//
//  LikeExperiencesRepositoryProtocol.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
protocol LikeExperiencesRepositoryProtocol {
    func likeExperiences() async throws -> BaseModel<Int>
}

class LikeExperiencesRepository: LikeExperiencesRepositoryProtocol{
    
    let service: NetworkService
    let id: String
    init(id: String, service: NetworkService =  NetworkServiceImplementation()) {
        self.id = id
        self.service = service
    }
    
    func likeExperiences() async throws -> BaseModel<Int>{
        let likeExperiencesEndpoint = Endpoint(path: APIUrls.getExperiences + "/\(id)/like", method: .POST)
        return try await service.request(likeExperiencesEndpoint, responseType: BaseModel<Int>.self)
    }
}
