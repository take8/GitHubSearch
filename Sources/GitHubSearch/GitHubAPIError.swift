//
//  GitHubAPIError.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/18.
//

import Foundation

public struct GitHubAPIError : Decodable {
    public struct Error : Decodable {
        public var resource: String
        public var field: String
        public var code: String
    }

    public var message: String
    public var errors: [Error]
}
