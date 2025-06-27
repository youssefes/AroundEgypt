//
//  RecommendedExperiencesRepository.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//
import Foundation

class RecommendedExperiencesRepository: GetExperiencesRepositoryProtocol {
    let service: NetworkService
    let experiencesLocal: ExperiencesLocalProtocol
    
    init(
        service: NetworkService = NetworkServiceImplementation(),
        experiencesLocal: ExperiencesLocalProtocol = RecommendedExperiencesLocal()
    ) {
        self.service = service
        self.experiencesLocal = experiencesLocal
    }
    
    func fetchExperiences() async throws -> [ExperiencesData] {
        let cached = try experiencesLocal.loadExperiences()
        if !cached.isEmpty {
            Task { try? await fetchAndRefreshIfNeeded(existing: cached) }
            return cached
        } else {
            return try await fetchRecentExperiencesRemote()
        }
    }
    
    func fetchRecentExperiencesRemote() async throws -> [ExperiencesData] {
        do {
            let quaryItems: [URLQueryItem] = [.init(name: "filter[recommended]", value: "true")]
            let experiencesEndpoint = Endpoint(path: APIUrls.getExperiences, queryItems: quaryItems)
            let resulte  = try await service.request(experiencesEndpoint, responseType: BaseModel<[ExperiencesData]>.self)
            let experiences = resulte.data ?? []
            try experiencesLocal.save(experiences: experiences)
            return experiences
        } catch {
            throw error
        }
    }
    
    private func fetchAndRefreshIfNeeded(existing: [ExperiencesData]) async throws {
        let remote = try await fetchRecentExperiencesRemote()
        let existing = try experiencesLocal.loadExperiences()
        guard remote != existing else {
            print("🔁 No data changes detected.")
            return
        }
        try experiencesLocal.save(experiences: remote)
    }
}

