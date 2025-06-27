//
//  ExperienceViewModelTests.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//
import XCTest
@testable import AroundEgypt

final class ExperienceViewModelTests: XCTestCase {
    
    private var sut: ExperienceViewModel!
    private var initialModel: PlaceCardModel!
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        initialModel = nil
        super.tearDown()
    }
    
    func testLikeExperiences_Success() async {
        // Arrange
        initialModel = PlaceCardModel(
            id: "1", name: "Test", image: "", seenNumber: 0,
            likeCount: 0, isRecommended: false, isliked: false,
            address: "", description: ""
        )

        let expectedLikeCount = 42
        let mockUseCase = MockLikeExperiencesUseCase(result: .success(
            BaseModel(meta: Meta(code: 200, errors: nil), data: expectedLikeCount)
        ))
        sut = ExperienceViewModel(
            placeCardModel: initialModel,
            likeExperiencesUseCase: mockUseCase
        )

        // Act
        sut.likeExperiences()
        try? await Task.sleep(nanoseconds: 200_000_000) // wait 0.2s

        // Assert
        XCTAssertEqual(sut.placeCardModel.likeCount, expectedLikeCount)
        XCTAssertTrue(sut.placeCardModel.isliked)
    }

    func testLikeExperiences_Failure() async {
        // Arrange
        let expectedModel = BaseModel<Int>(meta: Meta(code: 404, errors: []), data: nil)
        let mockUseCase = MockLikeExperiencesUseCase(result: .success(expectedModel))
        let paceCardModel = PlaceCardModel(id: "1", name: "", image: "", seenNumber: 1, likeCount: 1, address: "", description: "")
        
        sut = ExperienceViewModel(placeCardModel: paceCardModel, likeExperiencesUseCase: mockUseCase)
        // Act + Assert
        sut.likeExperiences()
        try? await Task.sleep(nanoseconds: 200_000_000)
        XCTAssertFalse(paceCardModel.isliked)
    }
}
