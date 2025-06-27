//
//  SearchExperiencesUseCase.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
import Combine

protocol SearchExperiencesUseCaseProtocol {
    func searchExperiences() async throws -> BaseModel<[ExperiencesData]>
    func setSearchText(searchText: String)
}

class SearchExperiencesUseCase: SearchExperiencesUseCaseProtocol {
    var searchText: String
    let repository: SearchExperiencesRepositoryProtocol?
    
    init(searchText: String, repository: SearchExperiencesRepositoryProtocol? = nil) {
        self.searchText = searchText
        self.repository = repository ?? SearchExperiencesRepository(searchText: self.searchText)
    }
    
    func setSearchText(searchText: String) {
        self.searchText = searchText
    }
    
    func searchExperiences() async throws -> BaseModel<[ExperiencesData]> {
        return try await repository?.searchExperiences() ??  BaseModel<[ExperiencesData]>(meta: Meta(code: 0, errors: []), data: [])
    }
    
}
