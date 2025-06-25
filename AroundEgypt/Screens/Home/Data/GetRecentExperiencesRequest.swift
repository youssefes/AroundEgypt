//
//  GetRecentExperiences.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
class GetRecentExperiencesRequest: BaseAPIRequest {
    override init() {
        super.init()
        method = .get
        path = APIUrls.getRecommendedExperiences
    }
}
