//
//  LikeExperiencesRequest.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
class LikeExperiencesRequest: BaseAPIRequest {
    init(id: String) {
        super.init()
        method = .post
        path = APIUrls.getRecommendedExperiences + "/\(id)/like"
    }
}
