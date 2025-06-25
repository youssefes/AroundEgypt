//
//  APIRequestProviderProtocols.swift


import Foundation
import Combine
public protocol APIRequestProviderProtocol {
    typealias APIRequestCompletion = (_ result: Result<Data, APIRequestProviderError>) -> Void
    func perform(apiRequest: APIRequestProtocol, completion: @escaping APIRequestCompletion)
}
