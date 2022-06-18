//
//  GitHubRequest.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/18.
//

import Foundation

public protocol GitHubRequest {
    associatedtype Response: Decodable

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}

public extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}
