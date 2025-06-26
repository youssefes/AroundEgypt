//
//  Endpoint.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

// MARK: - HTTP Method
import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

// MARK: - Endpoint

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]
    let queryItems: [URLQueryItem]
    let body: Encodable?

    init(path: String,
         method: HTTPMethod = .GET,
         headers: [String: String] = [:],
         queryItems: [URLQueryItem] = [],
         body: Encodable? = nil) {
        self.path = path
        self.method = method
        self.headers = headers
        self.queryItems = queryItems
        self.body = body
    }
}
