//
//  NETWORK+ENDPOINTS.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation

extension Endpoint {
    static func getHomeData(_ page: Int) -> Endpoint {
        let path = "/list?page=\(page)&limit=10"
        return Endpoint(base: Environment.baseURL, path: path)
    }
}
