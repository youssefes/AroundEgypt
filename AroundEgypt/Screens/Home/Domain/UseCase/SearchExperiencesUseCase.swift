//
//  SearchExperiencesUseCase.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
import Combine
class SearchExperiencesUseCase: BaseUseCase {
    var searchText: String
    init(searchText: String) {
        self.searchText = searchText
    }
    override func process<T: Codable>(_ outputType: T.Type) -> Future<T, Error> {
        return perfrom(outputType)
    }

    private func perfrom<T: Codable>(_ outputType: T.Type) -> Future<T, Error> {
        let request = SearchExperiencesRequest(searchText: searchText)
        return perform(apiRequest: request)
    }

}
