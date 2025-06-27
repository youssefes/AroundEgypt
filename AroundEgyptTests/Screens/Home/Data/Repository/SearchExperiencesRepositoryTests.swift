//
//  SearchExperiencesRepositoryTests.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//

import XCTest

@testable import AroundEgypt

// MARK: - Tests
final class SearchExperiencesRepositoryTests: XCTestCase {
    
    private var sut: SearchExperiencesRepository!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSsearchExperiences_ReturnsSuccess() async throws {
        // Arrange
        let expectedValue = BaseModel<[ExperiencesData]>(meta: Meta(code: 200, errors: []), data: [ExperiencesData(id: "1", title: "", coverPhoto: "", description: "", viewsNo: 1, likesNo: 1, recommended: 1, isLiked: 1, address: "")])
        
        let mockService = MockGetExperienceNetworkService(shouldSucceed: true, returnedValue: expectedValue, thrownError: nil)
        
        let repository = SearchExperiencesRepository(service: mockService, searchText: "tom")
        
        // Act
        let result = try await repository.searchExperiences()
        
        // Assert
        XCTAssertNotNil(result.data)
    }
    
   
    func testSsearchExperiences_ThrowsOnNetworkError() async {
        // Arrange
       
        let expectedValue = BaseModel<[ExperiencesData]>(meta: Meta(code: 404, errors: [NetworkError.invalidURL.errorDescription ?? ""]), data: nil)
        
        let mockService = MockGetExperienceNetworkService(shouldSucceed: false, returnedValue: expectedValue, thrownError: NetworkError.invalidURL)
        
        let repository = SearchExperiencesRepository(service: mockService, searchText: "tom")
        
        // Act + Assert
        do {
            _ = try await repository.searchExperiences()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}
