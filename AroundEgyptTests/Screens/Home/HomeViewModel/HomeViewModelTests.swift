//
//  HomeViewModelTests.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//
import XCTest
@testable import AroundEgypt

final class HomeViewModelTests: XCTestCase {
    
    private var sut: HomeViewModel!
    private var initialModel: ExperiencesData!
    override func setUp() {
        initialModel =  ExperiencesData(id: "1", title: "", coverPhoto: "", description: "", viewsNo: 1, likesNo: 1, recommended: 1, isLiked: 1, address: "")
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        initialModel = nil
        super.tearDown()
    }
    
    func testGetRecommendedExperiences_Success() async {
        // Arrange
        let mockGetRecommendedExperiencesUseCase = MockGetRecommendedExperiencesUseCase(result: .success([initialModel]))
        
        sut = HomeViewModel(getRecommendedExperiencesUseCase: mockGetRecommendedExperiencesUseCase)
        
        // Act
        sut.getRecommendedExperiences()
        try? await Task.sleep(nanoseconds: 200_000_000) // wait 0.2s
        
        // Assert
        XCTAssertEqual(sut.recommendedExperiencesItems, [initialModel.mapToPlaceCardModel()])
    }

    func testGetRecommendedExperiences_Failure() async {
        // Arrange
        let mockGetRecommendedExperiencesUseCase = MockGetRecommendedExperiencesUseCase(result: .failure(NetworkError.invalidResponse))
        
        sut = HomeViewModel(getRecommendedExperiencesUseCase: mockGetRecommendedExperiencesUseCase)
        // Act + Assert
        sut.getRecommendedExperiences()
        try? await Task.sleep(nanoseconds: 200_000_000)
        XCTAssertEqual(sut.state, .failed(NetworkError.invalidResponse))
    }
    
    
    func testGetRecentExperiences_Success() async {
        // Arrange
        let mockGetRecentExperiencesUseCase = MockGetRecentExperiencesUseCase(result: .success([initialModel]))
        
        sut = HomeViewModel(getRecentExperiencesUseCase: mockGetRecentExperiencesUseCase)
        
        // Act
        sut.getRecentexperiences()
        try? await Task.sleep(nanoseconds: 200_000_000) // wait 0.2s
        
        // Assert
        XCTAssertEqual(sut.mostRecent, [initialModel.mapToPlaceCardModel()])
    }

    func testGetRecentExperiences_Failure() async {
        // Arrange
        let mockGetRecentExperiencesUseCase = MockGetRecentExperiencesUseCase(result: .failure(NetworkError.invalidResponse))
        
        sut = HomeViewModel(getRecentExperiencesUseCase: mockGetRecentExperiencesUseCase)
        // Act + Assert
        sut.getRecentexperiences()
        try? await Task.sleep(nanoseconds: 200_000_000)
        XCTAssertEqual(sut.state, .failed(NetworkError.invalidResponse))
    }
    
    func testSearchExperiences_WithResults_ShouldSetSearchItemsAndStateSuccess() async throws {
        // Arrange
        let initialModel =  ExperiencesData(id: "1", title: "", coverPhoto: "", description: "", viewsNo: 1, likesNo: 1, recommended: 1, isLiked: 1, address: "")
        let expectedModel: BaseModel<[ExperiencesData]> = .init(meta:  Meta(code: 200, errors: nil), data: [initialModel])
        
        let mockSearchExperiencesUseCase = MockSearchExperiencesUseCase(result: .success(expectedModel))
        
        sut = HomeViewModel(searchExperiencesUseCase: mockSearchExperiencesUseCase)
       
        // Act
        sut.searchText = "success"
        sut.searchExperiences()
        try? await Task.sleep(nanoseconds: 400_000_000)
        
        // Assert
        XCTAssertEqual(sut.state, .successful)
    }
    
    func testSearchExperiences_WithFailure_ShouldSetStateFailed() async throws {
        let mockSearchExperiencesUseCase = MockSearchExperiencesUseCase(result: .failure(NetworkError.invalidResponse))
        
        sut = HomeViewModel(searchExperiencesUseCase: mockSearchExperiencesUseCase)
    
        // Act
        sut.searchText = "fail"
        sut.searchExperiences()
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        // Assert
        if case .failed(let error) = sut.state {
            XCTAssertEqual(error, NetworkError.invalidResponse)
        } else {
            XCTFail("Expected .failed state")
        }
    }

}
