//
//  ErrorModel.swift
import Foundation

public struct APIErrorModel: APIErrorModelProtocol {

    public var code: Int? {
        return mCode
    }

    public var errorDetail: String? {
        return mErrorDetail
    }

    public var errorType: String? {
        return mErrorType
    }
    public var errormessage: String? {
        return message
    }

    let mCode: Int?
    let mErrorDetail: String?
    let mErrorType: String?
    public let message: String?

    public init(code: Int, errorDetail: String, errormessage: String) {
        self.mCode = code
        self.mErrorDetail  = errorDetail
        self.mErrorType = ""
        self.message = errormessage
    }
}
public protocol APIErrorModelProtocol: Codable {
    
    var code: Int? {get }
    var errorDetail: String? {get}
    var errorType: String? {get}
    var message: String? {get}
    init(code: Int, errorDetail: String, errormessage: String)
}
