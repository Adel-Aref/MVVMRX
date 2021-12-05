//
//  MagixResponse.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation

// swiftlint:disable all
struct MagixResponse<T: Codable>: Codable, Cachable {
    var fileName: String? = String(describing: T.self)
    var responseException: ResponseException?
    var result: T?
}
struct ResponseException: Codable {
    var exceptionMessage: String?
}
struct UserID: Codable {
    var userid: String
}
