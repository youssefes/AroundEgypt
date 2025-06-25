//
//  APIRequestProtocol.swift

import Foundation

public protocol APIRequestProtocol: AnyObject, CustomStringConvertible {
    var scheme: String? { get set}
    var portNumber: Int? { get }
    var baseDomain: String { get }
    var path: String { get }
    var url: URL { get }
    var method: HTTPMethod { get }
    var queryBody: Any? { get }
    var headers: [String: String] { get set }
    var authorization: APIAuthorization { get }
    var requestURL: URLRequest { get }
    func queryParams() -> [String: String]?

}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
