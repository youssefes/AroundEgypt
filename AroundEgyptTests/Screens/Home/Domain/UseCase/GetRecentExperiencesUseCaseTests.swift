//
//  GetRecentExperiencesUseCaseTests.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//

import XCTest
@testable import AroundEgypt

final class GetRecentExperiencesUseCaseTests: XCTestCase {
    
    private var sut: GetRecentExperiencesUseCase!

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
        sut = GetRecentExperiencesUseCase(repository: mockRepo)

        // Act
        let result = try await sut.fetchRecentExperiences()

        // Assert
        XCTAssertEqual(result, expectedModel)
    }

    func testLikeExperiences_Failure() async {
        // Arrange
        let mockRepo = MockExperiencesRepository(resultToReturn: .failure(NetworkError.invalidResponse))
        sut = GetRecentExperiencesUseCase(repository: mockRepo)

        // Act & Assert
        do {
            _ = try await sut.fetchRecentExperiences()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}
