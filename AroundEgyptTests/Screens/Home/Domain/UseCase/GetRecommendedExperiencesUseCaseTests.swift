//
//  GetRecommendedExperiencesUseCaseTests.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//

import XCTest
@testable import AroundEgypt

final class GetRecommendedExperiencesUseCaseTests: XCTestCase {
    
    private var sut: GetRecommendedExperiencesUseCase!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLikeExperiences_Success() async throws {
        // Arrange
        let expectedModel = [ExperiencesData(id: "1", title: "", coverPhoto: "", description: "", viewsNo: 1, likesNo: 1, recommended: 1, isLiked: 1, address: "")]
        let mockRepo = MockExperiencesRepository(resultToReturn: .success(expectedModel))
        sut = GetRecommendedExperiencesUseCase(repository: mockRepo)

        // Act
        let result = try await sut.fetchRecommendedExperiences()

        // Assert
        XCTAssertEqual(result, expectedModel)
    }

    func testLikeExperiences_Failure() async {
        // Arrange
        let mockRepo = MockExperiencesRepository(resultToReturn: .failure(NetworkError.invalidResponse))
        sut = GetRecommendedExperiencesUseCase(repository: mockRepo)

        // Act & Assert
        do {
            _ = try await sut.fetchRecommendedExperiences()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}
