//
//  Repository.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/18.
//

import Foundation

public struct Repository : Decodable {
    public var id: Int
    public var name: String
    public var fullName: String
    public var owner: User

    // TODO: 他にもある

    public enum CodingKeys : String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
    }
}
