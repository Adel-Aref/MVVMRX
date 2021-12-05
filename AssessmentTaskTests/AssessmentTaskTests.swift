//
//  AssessmentTaskTests.swift
//  AssessmentTaskTests
//
//  Created by Adel Aref on 04/12/2021.
//

import XCTest
@testable import AssessmentTask

class AssessmentTaskTests: XCTestCase {

    let model = HomeModel(id: "1", author: "Alejandro Escamilla",
                          width: 5616, height: 3744,
                          url: "https://unsplash.com/photos/yC-Yzbqy7PY",
                          download_url: "https://picsum.photos/id/0/5616/3744")

    var sut: HomeViewModel! // system under test
    override func setUp() {
        sut = HomeViewModel()
    }
    // test auther count happy use case
    func testStarWarsSuccess() {
        sut.cachedMovies = [model]
        let count = sut.cachedMovies.count
        XCTAssert(count == 1, "authers count not equal 1")

    }
    // test auther count unhappy use case
    func testStarWarsFail() {
        sut.cachedMovies = [model]
        let count = sut.cachedMovies.count
        XCTAssert(count != 2, "authers count not equal 1")
    }
}
