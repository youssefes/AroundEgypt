//
//  GetRecommendedExperiences.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
class GetRecommendedExperiencesRequest: BaseAPIRequest {
    override init() {
        super.init()
        method = .get
        path = APIUrls.getRecommendedExperiences
    }
    
    override func queryParams() -> [String : String]? {
        return ["filter[recommended]" : "true"]
    }
}
