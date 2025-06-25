//
//  BaseAPIRequest.swift
//

import Foundation

open class BaseAPIRequest: APIRequestProtocol {
    public  var queryParamss: [String: String]?
    public var scheme: String?
    public var baseDomain: String
    public  var portNumber: Int?
    public var path: String
    public var authorization: APIAuthorization
    public var method: HTTPMethod
    public  var queryBody: Any?
    public var headers: [String: String]
    open var queryItems: [URLQueryItem]? {
        return queryParams()?.map({ URLQueryItem.init(name: $0.key, value: $0.value)})
    }
    public var url: URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.path = "\(self.path)"
        urlComponents.host = self.baseDomain
        urlComponents.queryItems = self.queryItems
        print(self.baseDomain)
        return urlComponents.url!
    }
    public var requestURL: URLRequest {
        let timeoutInterval = 20.0
        print(url)
        var request = URLRequest(url: self.url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: timeoutInterval)
        switch authorization {
        case .bearerToken:
            guard let header = authorization.authData as? [String: String] else {
                fatalError("bearerToken header must be as [String:String] ")
            }
            headers.merge(header) { (_, new) in new }
        case .none:
            break
        }
        request.allHTTPHeaderFields = headers
        request.httpMethod = self.method.rawValue
        var bodyData: Data?
        if let queryBody = self.queryBody as? [String: Any] {
            bodyData = try? JSONSerialization.data(withJSONObject: queryBody, options: [])
        } else if let queryBody = self.queryBody as? String {
            bodyData = queryBody.data(using: .utf8)
        }
        request.httpBody = bodyData
        return request
    }
    public init() {
        scheme = "https"
        baseDomain = APIUrls.baseDomain
        authorization = .none
        headers = ["Content-Type": "application/json","Accept" : "application/json","Accept-Platform" : "ios"
        ]
        path = ""
        method = .get
    }
    open func queryParams() -> [String: String]? {
        return nil
    }
    public var description: String {
        "RequestURL : \(requestURL.url?.absoluteString ?? "")"
    }
}

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
