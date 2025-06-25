//
//  HomeViewModel.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 24/06/2025.
//

import Foundation
import Combine

class HomeViewModel: BaseViewModel, ObservableObject {
    @Published var searchText = ""
    @Published var recommendedExperiencesItems: [PlaceCardModel] = []
    @Published var mostRecent: [PlaceCardModel] = []
    @Published var searchItems: [PlaceCardModel] = []
    
    private var getRecommendedExperiencesUseCase: GetRecommendedExperiencesUseCaseprotocol
    private var getRecentExperiencesUseCase: GetRecentExperiencesUseCaseProtocol
    private var searchExperiencesUseCase: SearchExperiencesUseCaseProtocol?
    init(
        getRecommendedExperiencesUseCase: GetRecommendedExperiencesUseCaseprotocol = GetRecommendedExperiencesUseCase(),
        getRecentExperiencesUseCase: GetRecentExperiencesUseCaseProtocol = GetRecentExperiencesUseCase(),
        searchExperiencesUseCase: SearchExperiencesUseCaseProtocol? =  nil
    ) {
        self.getRecommendedExperiencesUseCase = getRecommendedExperiencesUseCase
        self.getRecentExperiencesUseCase = getRecentExperiencesUseCase
        self.searchExperiencesUseCase =  searchExperiencesUseCase
        super.init()
    }
    
    // MARK: - get  Recommended Experiences
    func getRecommendedExperiences() {
        self.state = .loading()
        Task { @MainActor in
            do {
                let experiences = try await self.getRecommendedExperiencesUseCase.fetchRecommendedExperiences()
                self.recommendedExperiencesItems = (experiences.data ?? []) .map({$0.mapToPlaceCardModel()})
                self.state = .successful
            } catch {
                if let networkError = error as? NetworkError {
                    state = .failed(networkError)
                } else {
                    state = .failed(NetworkError.requestFailed(error))
                }
            }
        }
    }
    
    
    // MARK: - get  Recent Experiences
    func getRecentexperiences() {
        self.state = .loading()
        Task { @MainActor in
            do {
                let experiences = try await getRecentExperiencesUseCase.fetchRecentExperiences()
                self.mostRecent = (experiences.data ?? []).map({$0.mapToPlaceCardModel()})
                self.state = .successful
            } catch {
                if let networkError = error as? NetworkError {
                    state = .failed(networkError)
                } else {
                    state = .failed(NetworkError.requestFailed(error))
                }
            }
        }
    }
    
    // MARK: - search Experiences
    func searchExperiences() {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {return}
        searchExperiencesUseCase = SearchExperiencesUseCase(searchText: searchText)
        Task { @MainActor in
            do {
                let experiences = try await searchExperiencesUseCase?.searchExperiences()
                self.searchItems = (experiences?.data ?? []).map({$0.mapToPlaceCardModel()})
                self.state = .successful
            } catch {
                if let networkError = error as? NetworkError {
                    state = .failed(networkError)
                } else {
                    state = .failed(NetworkError.requestFailed(error))
                }
            }
        }
    }
}
