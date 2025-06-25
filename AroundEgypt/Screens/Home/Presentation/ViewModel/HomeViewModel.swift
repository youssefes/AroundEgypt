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
    
    private var getRecommendedExperiencesUseCase: GetRecommendedExperiencesUseCase
    private var getRecentExperiencesUseCase: GetRecentExperiencesUseCase
    private var searchExperiencesUseCase: SearchExperiencesUseCase?
    init(getRecommendedExperiencesUseCase: GetRecommendedExperiencesUseCase = GetRecommendedExperiencesUseCase(),
         getRecentExperiencesUseCase: GetRecentExperiencesUseCase = GetRecentExperiencesUseCase(),
         searchExperiencesUseCase: SearchExperiencesUseCase? =  nil) {
        self.getRecommendedExperiencesUseCase = getRecommendedExperiencesUseCase
        self.getRecentExperiencesUseCase = getRecentExperiencesUseCase
        self.searchExperiencesUseCase = searchExperiencesUseCase
        super.init()
        observeToSearch()
    }
    
    // MARK: - observe To Search Text Change
    func observeToSearch() {
        $searchText
            .dropFirst()
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main) // to avoid rapid firing
            .sink { newValue in
                // Check if text is empty before calling search
                if !newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.searchExperiences(searchText: newValue)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - get  Recommended Experiences
    func getRecommendedExperiences() {
        getRecommendedExperiencesUseCase.willProcess = { [weak self] in
            guard let self = self else {return}
            self.state = .loading()
        }
        getRecommendedExperiencesUseCase.execute(RecommendedExperiencesModel.self)
            .receive(on: RunLoop.main)
            .sink { [weak self] complition in
                guard let self = self  else {return}
                self.state = .successful
                switch complition {
                case .finished:
                    print("finish")
                case .failure(let error):
                    self.state = .failed(.requestFailed(error: error))
                }
            } receiveValue: {[weak self]  resulte in
                guard let self = self else {return}
                
                if (resulte.meta?.code ?? 0) == 200 {
                    self.recommendedExperiencesItems =  resulte.mapToPlaceCardModel()
                } else {
                    self.state = .failed(.server(statusCode: (resulte.meta?.code ?? 0), data: nil))
                }
                
            }.store(in: &cancellables)
    }
    
    
    // MARK: - get  Recommended Experiences
    func getRecentexperiences() {
        getRecentExperiencesUseCase.willProcess = { [weak self] in
            guard let self = self else {return}
            self.state = .loading()
        }
        getRecentExperiencesUseCase.execute(RecommendedExperiencesModel.self)
            .receive(on: RunLoop.main)
            .sink { [weak self] complition in
                guard let self = self  else {return}
                self.state = .successful
                switch complition {
                case .finished:
                    print("finish")
                case .failure(let error):
                    self.state = .failed(.requestFailed(error: error))
                }
            } receiveValue: {[weak self]  resulte in
                guard let self = self else {return}
                
                if (resulte.meta?.code ?? 0) == 200 {
                    self.mostRecent =  resulte.mapToPlaceCardModel()
                } else {
                    self.state = .failed(.server(statusCode: (resulte.meta?.code ?? 0), data: nil))
                }
                
            }.store(in: &cancellables)
    }
    
    // MARK: - get  Recommended Experiences
    func searchExperiences(searchText: String) {
        searchExperiencesUseCase = SearchExperiencesUseCase(searchText: searchText)
        searchExperiencesUseCase?.willProcess = { [weak self] in
            guard let self = self else {return}
            self.state = .loading()
        }
        searchExperiencesUseCase?.execute(RecommendedExperiencesModel.self)
            .receive(on: RunLoop.main)
            .sink { [weak self] complition in
                guard let self = self  else {return}
                
                self.state = .successful
                switch complition {
                case .finished:
                    print("finish")
                case .failure(let error):
                    self.state = .failed(.requestFailed(error: error))
                }
            } receiveValue: {[weak self]  resulte in
                guard let self = self else {return}
                
                if (resulte.meta?.code ?? 0) == 200 {
                    self.searchItems =  resulte.mapToPlaceCardModel()
                } else {
                    self.state = .failed(.server(statusCode: (resulte.meta?.code ?? 0), data: nil))
                }
                
            }.store(in: &cancellables)
    }
}
