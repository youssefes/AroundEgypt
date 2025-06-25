//
//  BaseError.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 24/06/2025.
//

import Foundation

 struct BaseError: Error {
    let message: String
    init(message: String) {
        self.message = message
    }
}

extension BaseError: Equatable {
    public static func == (lhs: BaseError, rhs: BaseError) -> Bool {
        lhs.message == rhs.message
    }
    
    static var noInternet: NSError {
        NSError(domain: "NoInternetError",
                code: 5005,
                userInfo: nil)

    }
}


