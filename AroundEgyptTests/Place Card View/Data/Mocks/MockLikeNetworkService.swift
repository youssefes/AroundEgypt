//
//  NetworkServiceTests.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 26/06/2025.
//

import XCTest
@testable import AroundEgypt

// MARK: - Mock NetworkService
class MockLikeNetworkService: NetworkService {
    var shouldSucceed: Bool
    var returnedValue: BaseModel<Int>
    var thrownError: Error?

    init(shouldSucceed: Bool, returnedValue: BaseModel<Int>, thrownError: Error?) {
        self.shouldSucceed = shouldSucceed
        self.returnedValue = returnedValue
        self.thrownError = thrownError
    }

    func request<T>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T where T: Decodable {
        if shouldSucceed {
            if let result = returnedValue as? T {
                return result
            } else {
                throw NetworkError.invalidResponse  // 🛑 this is your actual error
            }
        } else if let error = thrownError {
            throw error
        } else {
            throw NetworkError.invalidURL
        }
    }
}

