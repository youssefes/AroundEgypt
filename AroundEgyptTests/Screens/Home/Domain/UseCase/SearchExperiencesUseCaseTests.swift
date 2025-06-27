//
//  SearchExperiencesUseCaseTests.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//

import XCTest
@testable import AroundEgypt

final class SearchExperiencesUseCaseTests: XCTestCase {
    
    private var sut: SearchExperiencesUseCase!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLikeExperiences_Success() async throws {
        // Arrange
        let expectedModel: BaseModel<[ExperiencesData]> = .init(meta:  Meta(code: 200, errors: nil), data: [ExperiencesData(id: "1", title: "", coverPhoto: "", description: "", viewsNo: 1, likesNo: 1, recommended: 1, isLiked: 1, address: "")])
        
        let mockRepo = MockSearchExperiencesRepository(resultToReturn: .success(expectedModel))
        sut = SearchExperiencesUseCase(searchText: "", repository: mockRepo)

        // Act
        let result = try await sut.searchExperiences()

        // Assert
        XCTAssertNotNil(result.data)
    }

    func testLikeExperiences_Failure() async {
        // Arrange
        let mockRepo = MockSearchExperiencesRepository(resultToReturn: .failure(NetworkError.invalidResponse))
        sut = SearchExperiencesUseCase(searchText: "", repository: mockRepo)

        // Act & Assert
        do {
            _ = try await sut.searchExperiences()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}
