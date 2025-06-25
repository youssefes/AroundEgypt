//
//  APIRequestProviderError.swift

import Foundation

public enum APIRequestProviderError: Error {
    case noInternet(message: String)
    case server(statusCode: Int, data: Data?)
    case requestFailed(error: Error)

    var reason: String {
        switch self {
        case .requestFailed(let error):
            return error.localizedDescription
        case .server(let statusCode, _):
            return "Request Failed with status Code \(statusCode)"
        case .noInternet(let eMessage):
            return eMessage
        }
    }
}
