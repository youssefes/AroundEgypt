//
//  APIManager.swift

import Foundation
import Combine
public class APIManager: NetworkManagerProtocol {
    public func perform<T>(apiRequest: APIRequestProtocol, provider: APIRequestProviderProtocol, outputType: T.Type) -> Future<T, Error> where T: Decodable, T: Encodable {
        return call(provider: provider, outputType: outputType, apiRequest: apiRequest)
    }
    private func call<T: Codable>(provider: APIRequestProviderProtocol,
                                  outputType: T.Type,
                                  apiRequest: APIRequestProtocol) -> Future<T, Error> {
       return  Future<T, Error> { subject in
           provider.perform(apiRequest: apiRequest, completion: { [weak self] respond in
               if let result =  self?.validate(result: respond, outputType: outputType) {
                   print(result)
                   switch result {
                   case .success(let data):
                       subject(.success(data))
                   case .failure(let error):
                       subject(.failure(error))
                   }
               }
           })
        }
    }

    private func validate<T: Codable>(result: Result<Data, APIRequestProviderError>,
                                      outputType: T.Type ) -> Result<T, APIManagerError> {
        let returnedresult: Result<T, APIManagerError>

        switch result {
        case .failure(let error):
            switch error {
            case .noInternet(let message):
                returnedresult = .failure(.noInternet(message: message))
            case .server(let statusCode, let data):
                let decoder = JSONDecoder()
                if let data = data, let error =  try? decoder.decode(APIErrorModel.self, from: data) {
                    returnedresult = .failure(.errorModel(errorModel: error))
                } else {
                    let error = APIErrorModel(code: statusCode, errorDetail: "APIFailureError", errormessage: "")
                    returnedresult = .failure(.errorModel(errorModel: error))
                }
            case .requestFailed(error: let error):
                print(error)
                #if DEBUG
                // to catch it in DEBUG mode
                returnedresult = .failure(.requestFailed(message: error.localizedDescription))

                #else
                returnedresult = .failure(.requestFailed(message: "APIFailureError".localized))
                #endif

            }
        case .success(let data):
            do {
                let decoded = try JSONDecoder().decode(outputType, from: data)
                print(decoded)
            } catch {
                print(error)
            }

            if let decoded = try? JSONDecoder().decode(outputType, from: data) {
                returnedresult = .success(decoded)
            } else if let error =  try? JSONDecoder().decode(APIErrorModel.self, from: data) {
                returnedresult = .failure(.errorModel(errorModel: error))
            } else if let decoded = String(bytes: data, encoding: .utf8) as? T {
                returnedresult = .success(decoded)
            } else {
                returnedresult = .failure(.requestFailed(message: "APIFailureError"))
            }
        }
        return returnedresult
    }

}
