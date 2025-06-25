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
    init(
        getRecommendedExperiencesUseCase: GetRecommendedExperiencesUseCase = GetRecommendedExperiencesUseCase(),
        getRecentExperiencesUseCase: GetRecentExperiencesUseCase = GetRecentExperiencesUseCase(),
        searchExperiencesUseCase: SearchExperiencesUseCase? =  nil
    ) {
        self.getRecommendedExperiencesUseCase = getRecommendedExperiencesUseCase
        self.getRecentExperiencesUseCase = getRecentExperiencesUseCase
        self.searchExperiencesUseCase = searchExperiencesUseCase
        super.init()
    }
    
    // MARK: - get  Recommended Experiences
    func getRecommendedExperiences() {
        getRecommendedExperiencesUseCase.willProcess = { [weak self] in
            guard let self = self else {return}
            self.state = .loading()
        }
        getRecommendedExperiencesUseCase.execute(BaseModel<[ExperiencesData]>.self)
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
                
                if (resulte.meta.code ?? 0) == 200 {
                    self.recommendedExperiencesItems =  resulte.data?.map({$0.mapToPlaceCardModel()}) ?? []
                } else {
                    self.state = .failed(.server(statusCode: (resulte.meta.code ?? 0), data: nil))
                }
                
            }.store(in: &cancellables)
    }
    
    
    // MARK: - get  Recent Experiences
    func getRecentexperiences() {
        getRecentExperiencesUseCase.willProcess = { [weak self] in
            guard let self = self else {return}
            self.state = .loading()
        }
        getRecentExperiencesUseCase.execute(BaseModel<[ExperiencesData]>.self)
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
                
                if (resulte.meta.code ?? 0) == 200 {
                    self.mostRecent =  resulte.data?.map({$0.mapToPlaceCardModel()}) ?? []
                } else {
                    self.state = .failed(.server(statusCode: (resulte.meta.code ?? 0), data: nil))
                }
                
            }.store(in: &cancellables)
    }
    
    // MARK: - search Experiences
    func searchExperiences() {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {return}
        searchExperiencesUseCase = SearchExperiencesUseCase(searchText: searchText)
        searchExperiencesUseCase?.willProcess = { [weak self] in
            guard let self = self else {return}
            self.state = .loading()
        }
        searchExperiencesUseCase?.execute(BaseModel<[ExperiencesData]>.self)
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
                
                if (resulte.meta.code ?? 0) == 200 {
                    self.searchItems =  resulte.data?.map({$0.mapToPlaceCardModel()}) ?? []
                } else {
                    self.state = .failed(.server(statusCode: (resulte.meta.code ?? 0), data: nil))
                }
                
            }.store(in: &cancellables)
    }
}
