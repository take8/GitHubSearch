//
//  SearchResponse.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/18.
//

import Foundation

public struct SearchResponse<Item : Decodable> : Decodable {
    public var totalCount: Int
    public var items: [Item]
    
    public enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
