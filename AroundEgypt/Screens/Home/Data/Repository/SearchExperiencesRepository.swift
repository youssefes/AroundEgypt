//
//  SearchExperiencesRepository.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
protocol SearchExperiencesRepositoryProtocol {
    func searchExperiences() async throws -> BaseModel<[ExperiencesData]>
}

class SearchExperiencesRepository: SearchExperiencesRepositoryProtocol {

    let service: NetworkService
    var searchText: String
    init(service: NetworkService =  NetworkServiceImplementation(),searchText: String) {
        self.service = service
        self.searchText = searchText
    }
    
    func searchExperiences() async throws -> BaseModel<[ExperiencesData]> {
        let quaryItems: [URLQueryItem] = [.init(name: "filter[title]", value: "{\(searchText)}")]
        let RecentExperiencesEndpoint = Endpoint(path: APIUrls.getExperiences, queryItems: quaryItems)
        return try await service.request(RecentExperiencesEndpoint, responseType: BaseModel<[ExperiencesData]>.self)
    }
}
