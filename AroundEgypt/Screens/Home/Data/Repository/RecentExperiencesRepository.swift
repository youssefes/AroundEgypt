//
//  RecentExperiencesREpository.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//
import Foundation

protocol RecentExperiencesRepositoryProtocol {
    func fetchRecentExperiences() async throws -> [ExperiencesData]
}

class RecentExperiencesRepository: RecentExperiencesRepositoryProtocol{
    let experiencesLocal: ExperiencesLocalProtocol
    let service: NetworkService
    init(
        service: NetworkService =  NetworkServiceImplementation(),
        experiencesLocal: ExperiencesLocalProtocol = RecentExperiencesLocal()
    ) {
        self.service = service
        self.experiencesLocal = experiencesLocal
    }
    
    func fetchRecentExperiences() async throws -> [ExperiencesData] {
        let cached = try experiencesLocal.loadExperiences()
        if  !cached.isEmpty {
            Task { try? await fetchAndRefreshIfNeeded(existing: cached) }
            return cached
        } else {
            return try await fetchRecentExperiencesRemote()
        }
    }
    
    func fetchRecentExperiencesRemote() async throws -> [ExperiencesData] {
        let RecentExperiencesEndpoint = Endpoint(path: APIUrls.getExperiences)
        do {
            let resulte = try await service.request(RecentExperiencesEndpoint, responseType: BaseModel<[ExperiencesData]>.self)
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
        try  experiencesLocal.save(experiences: remote)
    }
}
