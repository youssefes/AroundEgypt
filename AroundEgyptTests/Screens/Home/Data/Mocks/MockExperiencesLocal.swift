//
//  MockExperiencesLocal.swift
//  AroundEgyptTests
//
//  Created by Asset's Macbook Pro on 27/06/2025.
//
import XCTest
@testable import AroundEgypt
class MockExperiencesLocal: ExperiencesLocalProtocol {
    var cached: [ExperiencesData] = []
    var didSave = false
    var savedExperiences: [ExperiencesData] = []

    func loadExperiences() throws -> [ExperiencesData] {
        return cached
    }

    func updateExperiences(experience: ExperiencesData) throws {
        // not needed for this test
    }

    func save(experiences: [ExperiencesData]) throws {
        didSave = true
        savedExperiences = experiences
    }
}

