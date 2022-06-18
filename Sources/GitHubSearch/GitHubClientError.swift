//
//  GitHubClientError.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/18.
//

import Foundation

public enum GitHubClientError {
    // 通信に失敗
    case connectionError(Error)

    // レスポンスの解釈に失敗
    case responseParseError(Error)

    // APIからエラーレスポンスを受け取った
    case apiError(GitHubAPIError)
}
