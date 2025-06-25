//
//  NetworkManagerProtocol.swift

import Foundation
import Combine

 public protocol NetworkManagerProtocol: AnyObject {
    func perform<T: Codable>(apiRequest: APIRequestProtocol,
                             provider: APIRequestProviderProtocol,
                             outputType: T.Type) -> Future<T, Error>
}
