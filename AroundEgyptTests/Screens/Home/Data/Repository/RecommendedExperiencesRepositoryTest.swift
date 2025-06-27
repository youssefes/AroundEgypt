
//
//  RecommendedExperiencesRepositoryTest.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//

import XCTest
@testable import AroundEgypt

// MARK: - Tests
final class RecommendedExperiencesRepositoryTest: XCTestCase {
    
    private var sut: RecommendedExperiencesRepository!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchRecentExperiences_ReturnsCached_WhenExists() async throws {
        // Arrange
        let cachedExperience = ExperiencesData(id: "1", title: "Cached", coverPhoto: "", description: "", viewsNo: 1, likesNo: 1, recommended: 0, isLiked: 0, address: "")
        let mockLocal = MockExperiencesLocal()
        mockLocal.cached = [cachedExperience]
        let expectedValue = BaseModel<[ExperiencesData]>(meta: Meta(code: 200, errors: []), data: [ExperiencesData(id: "1", title: "", coverPhoto: "", description: "", viewsNo: 1, likesNo: 1, recommended: 1, isLiked: 1, address: "")])
        
        let mockService = MockGetExperienceNetworkService(shouldSucceed: true, returnedValue: expectedValue, thrownError: nil)
        
        let repository = RecommendedExperiencesRepository(service: mockService, experiencesLocal: mockLocal)
        
        // Act
        let result = try await repository.fetchExperiences()
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, cachedExperience.id)
    }
    
    func testFetchRecentExperiences_ReturnsRemote_WhenCacheEmpty() async throws {
        // Arrange
        let remoteExperience = ExperiencesData(id: "1", title: "Remote", coverPhoto: "", description: "", viewsNo: 5, likesNo: 3, recommended: 1, isLiked: 1, address: "")
        
        let mockLocal = MockExperiencesLocal()
        mockLocal.cached = []
        
        let expectedValue = BaseModel<[ExperiencesData]>(meta: Meta(code: 200, errors: []), data: [ExperiencesData(id: "1", title: "", coverPhoto: "", description: "", viewsNo: 1, likesNo: 1, recommended: 1, isLiked: 1, address: "")])
        
        let mockService = MockGetExperienceNetworkService(shouldSucceed: true, returnedValue: expectedValue, thrownError: nil)
        
        let repository = RecommendedExperiencesRepository(service: mockService, experiencesLocal: mockLocal)
        
        // Act
        let result = try await repository.fetchExperiences()
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, remoteExperience.id)
        XCTAssertTrue(mockLocal.didSave)
        XCTAssertEqual(mockLocal.savedExperiences.first?.id, remoteExperience.id)
    }
    
    func testFetchRecentExperiencesRemote_ThrowsOnNetworkError() async {
        // Arrange
        let mockLocal = MockExperiencesLocal()
        let expectedValue = BaseModel<[ExperiencesData]>(meta: Meta(code: 404, errors: [NetworkError.invalidURL.errorDescription ?? ""]), data: nil)
        
        let mockService = MockGetExperienceNetworkService(shouldSucceed: false, returnedValue: expectedValue, thrownError: NetworkError.invalidURL)
        
        let repository = RecommendedExperiencesRepository(service: mockService, experiencesLocal: mockLocal)
        
        // Act + Assert
        do {
            _ = try await repository.fetchExperiences()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}

