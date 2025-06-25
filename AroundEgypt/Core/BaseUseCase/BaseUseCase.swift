////
////  BaseUseCase.swift
////  POMacArch
////
////  Created by mohamed gamal on 22/12/2021.
////
//
import Foundation
import Combine

protocol BaseUseCaseProtocol {
    var willProcess: (() -> Void)? {get set}
    func execute<T>(_ outputType: T.Type) -> Future<T, Error>
}

open class BaseUseCase: BaseUseCaseProtocol {
    var network: NetworkManagerProtocol =  APIManager()
    var internetManager: InternetManagerProtocol = InternetConnectionManager()
    lazy var provider: APIRequestProviderProtocol = APIRequestProvider(internetManager: internetManager)
    var willProcess: (() -> Void)?
    func extract() {}
    func validate() throws {
        guard internetManager.isInternetConnectionAvailable() else {
            throw BaseError.noInternet
        }
    }
    func process<T>(_ outputType: T.Type) -> Future<T, Error> {
        fatalError("You must implement this method in the sub class")
    }
    func execute<T>(_ outputType: T.Type) -> Future<T, Error> {
        do {
            extract()
            try validate()
            willProcess?()
            return process(outputType)
        } catch let error {
            return Future<T, Error> { subject in subject(.failure(error))}
        }
    }
    func process<T: Codable>(_ outputType: T.Type) -> Future<T, Error> {
        fatalError("You must implement this method in the sub class")
    }
    func execute<T: Codable>(_ outputType: T.Type) -> Future<T, Error> {
        do {
            extract()
            try validate()
            willProcess?()
            return process(outputType)
        } catch let error {
            return  Future<T, Error> { subject in subject(.failure(error))}
        }
    }
    func perform<T: Codable>(apiRequest: APIRequestProtocol) -> Future<T, Error> {
        network.perform(apiRequest: apiRequest, provider: self.provider, outputType: T.self)
    }
}
