//
//  GetRecommendedExperiencesUseCase.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
import Combine
class GetRecommendedExperiencesUseCase: BaseUseCase {
    override func process<T: Codable>(_ outputType: T.Type) -> Future<T, Error> {
        return perfrom(outputType)
    }

    private func perfrom<T: Codable>(_ outputType: T.Type) -> Future<T, Error> {
        let request = GetRecommendedExperiencesRequest()
        return perform(apiRequest: request)
    }

}
