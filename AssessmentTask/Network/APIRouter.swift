//  APIRouter.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation

//func decode<D: Decodable>(_ type: D.Type, from data: Data) throws -> D
import Alamofire
// swiftlint:disable all
protocol APIRouter {
    func makeRequest<T: Decodable>(withRequest: URLRequest,
                                  decodingType: T.Type,
                                  completion: @escaping JSONDecodableCompletionHandler)
}

extension APIRouter {
    typealias JSONDecodableCompletionHandler = (RequestResult<Decodable, RequestError>) -> Void
    func makeRequest<T: Decodable>(withRequest: URLRequest,
                                  decodingType: T.Type,
                                  completion: @escaping JSONDecodableCompletionHandler) {
        AF.request(withRequest)
            .responseJSON(completionHandler: { (response) in
                if let error = response.error {
                    if error.localizedDescription == "The request timed out." {
                        completion(.failure(.timeOut))
                    } else {
                        completion(.failure(.connectionError))
                    }
                } else if let data = response.data {
                    print(response)
                    if let code = response.response?.statusCode {
                        switch code {
                        case 200:
                            self.decodeJsonResponse(
                                decodingType: decodingType,
                                jsonObject: data,
                                completion: completion)
                            print()
                        case 400 ... 499:
                            completion(.failure(.authorizationError))
                        case 500 ... 599:
                            completion(.failure(.serverError))
                        default:
                            completion(.failure(.unknownError))
                        }
                    }
                }
            })
    }

    func decodeJsonResponse<T: Decodable>(decodingType: T.Type,
                                         jsonObject: Data,
                                         completion: @escaping JSONDecodableCompletionHandler) {
        do {
            let genericModel = try JSONDecoder().decode(decodingType, from: jsonObject)
            completion(.success(genericModel))
        } catch {
            completion(.failure(.jsonConversionFailure))
        }
    }
    
}
func makeRequest(url: URL, headers: Any?, parameters: Any?, query: [URLQueryItem]?, type: HTTPMethod) -> URLRequest? {
    print(url.absoluteURL)


    var urll = URLComponents(url: url, resolvingAgainstBaseURL: true)
    if let query = query {
        urll?.queryItems = query
    }
    guard let finalURL = urll?.url else { return nil }
    var urlRequest = URLRequest(url: finalURL, timeoutInterval: 10)
    do {
        urlRequest.httpMethod = type.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let parameters = parameters {
            urlRequest.httpBody   = try JSONSerialization.data(withJSONObject: parameters)
        }
        if let headers = headers as? [String: String] {
            urlRequest.allHTTPHeaderFields = headers
        }
//        if let accessToken = UserDefaults.standard.user?.token {
//            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        }
        return urlRequest
    } catch let error {
        print("Error : \(error.localizedDescription)")
    }
    return urlRequest
}
