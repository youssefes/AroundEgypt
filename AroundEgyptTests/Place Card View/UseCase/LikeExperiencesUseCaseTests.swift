//
//  LikeExperiencesRepositoryTests.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 26/06/2025.
//

import XCTest
@testable import AroundEgypt

final class LikeExperiencesUseCaseTests: XCTestCase {
    
    private var sut: LikeExperiencesUseCase!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLikeExperiences_Success() async throws {
        // Arrange
        let expectedModel = BaseModel<Int>(meta: Meta(code: 200, errors: []), data: 100)
        let mockRepo = MockLikeExperiencesRepository(resultToReturn: .success(expectedModel))
        sut = LikeExperiencesUseCase(id: "123", repository: mockRepo)

        // Act
        let result = try await sut.likeExperiences()

        // Assert
        XCTAssertEqual(result.data, expectedModel.data)
    }

    func testLikeExperiences_Failure() async {
        // Arrange
        let mockRepo = MockLikeExperiencesRepository(resultToReturn: .failure(NetworkError.invalidResponse))
        sut = LikeExperiencesUseCase(id: "123", repository: mockRepo)

        // Act & Assert
        do {
            _ = try await sut.likeExperiences()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}
