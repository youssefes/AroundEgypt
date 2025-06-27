//
//  ExperienceViewModelTests.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 26/06/2025.
//

import XCTest
@testable import AroundEgypt

// MARK: - Tests
final class LikeExperiencesRepositoryTests: XCTestCase {

    private var sut: LikeExperiencesRepository!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLikeExperiences_Success() async throws {
        // Arrange
        let expectedValue = BaseModel<Int>(meta: Meta(code: 200, errors: []), data: 100)
        let mockService = MockLikeNetworkService(shouldSucceed: true, returnedValue: expectedValue, thrownError: nil)
        sut = LikeExperiencesRepository(id: "123", service: mockService)
      
        // Act & Assert
        do {
            let result = try await sut.likeExperiences()
            XCTAssertEqual(result.data, expectedValue.data)
        } catch {
            XCTAssertNil(error)
        }
    }

    func testLikeExperiences_Failure() async {
        // Arrange
        let expectedValue = BaseModel<Int>(meta: Meta(code: 404, errors: [NetworkError.invalidURL.errorDescription ?? ""]), data: 100)
        
        let mockService = MockLikeNetworkService(shouldSucceed: false, returnedValue: expectedValue, thrownError: NetworkError.invalidURL)

        let repository = LikeExperiencesRepository(id: "123", service: mockService)

        // Act & Assert
        do {
            _ = try await repository.likeExperiences()
            XCTFail("Expected to throw an error but succeeded")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
