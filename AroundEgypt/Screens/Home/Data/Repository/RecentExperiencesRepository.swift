//
//  RecentExperiencesREpository.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//
import Foundation

protocol RecentExperiencesRepositoryProtocol {
    func fetchRecentExperiences() async throws -> BaseModel<[ExperiencesData]>
}

class RecentExperiencesRepository: RecentExperiencesRepositoryProtocol{
    
    let service: NetworkService
    init(service: NetworkService =  NetworkServiceImplementation()) {
        self.service = service
    }
    
    func fetchRecentExperiences() async throws -> BaseModel<[ExperiencesData]> {
        let RecentExperiencesEndpoint = Endpoint(path: APIUrls.getExperiences)
        return try await service.request(RecentExperiencesEndpoint, responseType: BaseModel<[ExperiencesData]>.self)
    }
}
