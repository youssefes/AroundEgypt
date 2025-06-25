//
//  APIManagerError.swift

import Foundation

public enum APIManagerError: Error {
    case requestFailed(message: String)
    case errorModel(errorModel: APIErrorModel)
    case noInternet(message: String)

    var message: String {
        switch self {
        case .requestFailed(let message):
            return message
        case .errorModel(let errorModel):
            return errorModel.message ?? ""
        case .noInternet(let message):
            return message
        }
    }
}
