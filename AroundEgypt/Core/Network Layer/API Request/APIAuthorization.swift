//
//  APIAuthorization.swift
//

import Foundation

public enum APIAuthorization {
    case none
    case bearerToken
    var authData: Any {
        switch self {
        case .none:
            return ["Accept": "application/json"]
        case .bearerToken:
            let token = ""
            print("token: \(token)")
            return ["Authorization": "Bearer \(token)"]
        }
    }
}
