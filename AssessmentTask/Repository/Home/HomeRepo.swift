//
//  HomeRepo.swift
//  AssessmentTask
//
//  Created by Adel Aref on 05/12/2021.
//

import Foundation
class HomeRepo: Repository {
    var networkClient: APIRouter
    var cacher: Cacher

    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("HomeRepo"))
    }
    func getHomeData(page: Int, completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getHomeData(page).url else { return }
        if let request = makeRequest(url: url, headers: nil, parameters: nil, query: nil, type: .get) {
            getData(withRequest: request,
                    name: String(describing: HomeModel.self),
                    decodingType: [HomeModel].self, strategy:
                        .networkOnly, completion: completion)
        }
    }
}
