//
//  ExampleJSON.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/18.
//

import GitHubSearch

extension User {
    static var exampleJSON: String {
        return """
        {
            "login": "apple",
            "id": 10639145
        }
        """
    }
}

extension Repository {
    static var exampleJSON: String {
        return """
        {
            "id": 44838949,
            "name": "swift",
            "full_name": "apple/swift",
            "owner": {
                "login": "apple",
                "id": 10639145
            }
        }
        """
    }
}

extension SearchResponse where Item == Repository {
    static var exampleJSON: String {
        return """
        {
            "total_count": 241659,
            "items": [
                \(Repository.exampleJSON),
                {
                    "id": 790019,
                    "name": "swift",
                    "full_name": "openstack/swift",
                    "owner": {
                        "login": "openstack",
                        "id": 324574
                    }
                },
                {
                    "id": 130902948,
                    "name": "swift",
                    "full_name": "tensorflow/swift",
                    "owner": {
                        "login": "tensorflow",
                        "id": 15658638
                    }
                }
            ]
        }
        """
    }
}

extension GitHubAPIError {
    static var exampleJSON: String {
        return """
        {
            "message": "Validation Failed",
            "errors": [
                {
                    "resource": "Search",
                    "field": "q",
                    "code": "missing"
                }
            ],
            "documentation_url": "https://developer.github.com/v3/search"
        }
        """
    }
}
