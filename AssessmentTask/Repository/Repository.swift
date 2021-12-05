//
//  Repository.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation
import UIKit
import Alamofire
// swiftlint:disable all
protocol Repository {
    var networkClient: APIRouter { get }
    var cacher: Cacher { get }
    func getData<T: Cachable>(withRequest: URLRequest,
                              name: String?,
                              decodingType: T.Type,
                              strategy: Strategy,
                              completion: @escaping RepositoryCompletion)
    where T: Codable
}

extension Repository {
    typealias RepositoryCompletion = (RequestResult<Decodable, RequestError>) -> Void
    func getData<T: Decodable>(withRequest: URLRequest,
                              name: String?,
                              decodingType: T.Type,
                              strategy: Strategy = .networkOnly,
                              completion: @escaping RepositoryCompletion) {
        networkClient.makeRequest(withRequest: withRequest, decodingType: decodingType) { (result) in
            switch result {
            case .success(let data):
                completion(result)
            case .failure(.timeOut):
                showAlertConnectionError(withMessege: "The request timed out.")
            case .failure(.connectionError):
                showAlertConnectionError(withMessege: "No Internet connection.")
            case .failure(.jsonConversionFailure):
                print("jsonConversionFailure")
            default :
                return
            }
            completion(result)
        }
    }
}
func showAlertConnectionError(withMessege: String) {
    let alertController =
        UIAlertController(title: nil, message: withMessege, preferredStyle: UIAlertController.Style.alert)
    let okAction =
        UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil)
    alertController.addAction(okAction)
    UIApplication.getTopViewController()?.present(alertController, animated: true, completion: nil)
}
