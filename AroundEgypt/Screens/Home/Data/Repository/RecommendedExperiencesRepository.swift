//
//  RecommendedExperiencesRepository.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//
import Foundation
protocol RecommendedExperiencesRepositoryProtocol {
    func fetchRecommendedExperiences() async throws -> BaseModel<[ExperiencesData]>
}

class RecommendedExperiencesRepository: RecommendedExperiencesRepositoryProtocol{
    
    let service: NetworkService
    init(service: NetworkService =  NetworkServiceImplementation()) {
        self.service = service
    }
    
    func fetchRecommendedExperiences() async throws -> BaseModel<[ExperiencesData]>{
        let quaryItems: [URLQueryItem] = [.init(name: "filter[recommended]", value: "true")]
        let RecentExperiencesEndpoint = Endpoint(path: APIUrls.getExperiences, queryItems: quaryItems)
        return try await service.request(RecentExperiencesEndpoint, responseType: BaseModel<[ExperiencesData]>.self)
    }
}

