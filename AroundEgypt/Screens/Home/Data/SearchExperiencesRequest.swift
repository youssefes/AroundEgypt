//
//  SearchExperiencesRequest.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
class SearchExperiencesRequest: BaseAPIRequest {
    var searchText: String
    init(searchText: String) {
        self.searchText = searchText
        super.init()
        method = .get
        path = APIUrls.getRecommendedExperiences
    }
    
    override func queryParams() -> [String : String]? {
        return ["filter[title]": "{\(searchText)}"]
    }
}
