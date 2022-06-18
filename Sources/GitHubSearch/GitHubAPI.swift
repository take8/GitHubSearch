//
//  GitHubAPI.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/18.
//

import Foundation

public final class GitHubAPI {
    public struct SearchRepositories : GitHubRequest {
        public let keyword: String

        // GitHubRequestが要求する連想型
        public typealias Response = SearchResponse<Repository>

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/search/repositories"
        }

        public var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "q", value: keyword)]
        }
    }
}
