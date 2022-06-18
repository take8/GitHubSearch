//
//  UserTests.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/18.
//

import Foundation
import XCTest

import GitHubSearch

class UserTests: XCTestCase {
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = User.exampleJSON.data(using: .utf8)!
        let user = try jsonDecoder.decode(User.self, from: data)
        XCTAssertEqual(user.id, 10639145)
        XCTAssertEqual(user.login, "apple")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}
