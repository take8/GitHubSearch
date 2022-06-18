//
//  SearchResponseTests.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/18.
//

import Foundation
import XCTest

import GitHubSearch

class SearchResponseTests: XCTestCase {
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func testDecodeRepositories() throws {
        let jsonDecoder = JSONDecoder()
        let data = SearchResponse<Repository>.exampleJSON.data(using: .utf8)!
        let searchResponse = try jsonDecoder.decode(SearchResponse<Repository>.self, from: data)

        XCTAssertEqual(searchResponse.totalCount, 241659)
        XCTAssertEqual(searchResponse.items.count, 3)

        let firstRepository = searchResponse.items.first
        XCTAssertEqual(firstRepository?.id, 44838949)
        XCTAssertEqual(firstRepository?.name, "swift")
        XCTAssertEqual(firstRepository?.fullName, "apple/swift")
        XCTAssertEqual(firstRepository?.owner.id, 10639145)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}
