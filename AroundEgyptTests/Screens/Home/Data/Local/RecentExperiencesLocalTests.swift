//
//  RecentExperiencesLocalTests.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//

import XCTest
@testable import AroundEgypt
import CoreData


final class RecentExperiencesLocalTests: XCTestCase {

    var sut: RecentExperiencesLocal!

    override func setUpWithError() throws {
        sut = RecentExperiencesLocal()

        // Replace persistent store with in-memory
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        sut.container.persistentStoreDescriptions = [description]

        var loadError: Error?
        let exp = expectation(description: "load store")
        sut.container.loadPersistentStores { _, error in
            loadError = error
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        if let error = loadError {
            throw error
        }
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSaveAndLoadExperience() throws {
        // Arrange
        let experience = ExperiencesData(
            id: "1",
            title: "Title",
            coverPhoto: "photo.png",
            description: "Desc",
            viewsNo: 10,
            likesNo: 5,
            recommended: 1,
            isLiked: 1,
            address: "Cairo"
        )

        // Act
        try sut.save(experiences: [experience])
        let loaded = try sut.loadExperiences()

        // Assert
        XCTAssertEqual(loaded.first?.isLiked, experience.isLiked)
    }

    func testUpdateExperience() throws {
        // Arrange
        let initial = ExperiencesData(
            id: "2",
            title: "Old Title",
            coverPhoto: "old.png",
            description: "Old",
            viewsNo: 100,
            likesNo: 10,
            recommended: 0,
            isLiked: 0,
            address: "Old City"
        )
        try sut.save(experiences: [initial])

        let updated = ExperiencesData(
            id: "2",
            title: "Old Title", // Title remains unchanged
            coverPhoto: "old.png",
            description: "Old",
            viewsNo: 100,
            likesNo: 999,
            recommended: 0,
            isLiked: 1,
            address: "Old City"
        )

        // Act
        try sut.updateExperiences(experience: updated)
        let loaded = try sut.loadExperiences()

        // Assert
        XCTAssertEqual(loaded.first?.isLiked, updated.isLiked)
    }
}
