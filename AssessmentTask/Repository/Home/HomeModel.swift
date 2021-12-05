//
//  HomeModel.swift
//  AssessmentTask
//
//  Created by Adel Aref on 05/12/2021.
//
//swiftlint:disable identifier_name
import Foundation
struct HomeModel: Decodable {
    let id: String
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let download_url: String?
}
