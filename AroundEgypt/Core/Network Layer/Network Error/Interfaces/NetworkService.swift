//
//  Untitled.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

// MARK: - Network Service Protocol

protocol NetworkService {
    func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T
}
