//  Network.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation
import Alamofire

struct Network {
    static var reachability: CheckConnection!
    enum Status: String {
        case unreachable, wifi, wwan
    }
    enum Error: Swift.Error {
        case failedToSetCallout
        case failedToSetDispatchQueue
        case failedToCreateWith(String)
        case failedToInitializeWith(sockaddr_in)
    }
}
