//
//  GitHubClientTests.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/19.
//

import XCTest
import Foundation
import GitHubSearch

class GitHubClientTests: XCTestCase {
    var httpClient: StubHTTPClient!
    var gitHubClient: GitHubClient!

    override func setUp() {
        super.setUp()
        httpClient = StubHTTPClient()
        gitHubClient = GitHubClient(httpClient: httpClient)
    }

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func testSuccess() throws {
        httpClient.result = makeHTTPClientResult(
            statusCode: 200,
            json: GitHubAPI.SearchRepositories.Response.exampleJSON)

        let request = GitHubAPI.SearchRepositories(keyword: "swift")
        let apiExpectation = expectation(description: "")
        gitHubClient.send(request: request) { result in
            switch result {
            case .success(let response):
                let repository = response.items.first
                XCTAssertEqual(repository?.fullName, "apple/swift")
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }

        wait(for: [apiExpectation], timeout: 3)
    }

    // 通信に失敗した場合
    func testFailureByConnectionError() throws {
        httpClient.result = .failure(URLError(.cannotConnectToHost))

        let request = GitHubAPI.SearchRepositories(keyword: "swift")
        let apiExpectation = expectation(description: "")
        gitHubClient.send(request: request) { result in
            switch result {
            case .failure(.connectionError):
                break;
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }

        wait(for: [apiExpectation], timeout: 3)
    }

    // レスポンスの解釈に失敗した場合
    func testFailureByResponseParseError() throws {
        httpClient.result = makeHTTPClientResult(
            statusCode: 200,
            json: "{}")

        let request = GitHubAPI.SearchRepositories(keyword: "swift")
        let apiExpectation = expectation(description: "")
        gitHubClient.send(request: request) { result in
            switch result {
            case .failure(.responseParseError):
                break;
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }

        wait(for: [apiExpectation], timeout: 3)
    }

    // エラーレスポンスを受け取った場合
    func testFailureByAPIError() throws {
        httpClient.result = makeHTTPClientResult(
            statusCode: 400,
            json: GitHubAPIError.exampleJSON)

        let request = GitHubAPI.SearchRepositories(keyword: "swift")
        let apiExpectation = expectation(description: "")
        gitHubClient.send(request: request) { result in
            switch result {
            case .failure(.apiError):
                break;
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }

        wait(for: [apiExpectation], timeout: 3)
    }

    private func makeHTTPClientResult(statusCode: Int, json: String) -> Result<(Data, HTTPURLResponse), Error> {
        return .success((
            json.data(using: .utf8)!,
            HTTPURLResponse(
                url: URL(string: "https://api.github.com/search/repositories")!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil)!
        ))
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}
