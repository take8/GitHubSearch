//
//  main.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/19.
//

import Foundation
import GitHubSearch

print("Enter your query here> ", terminator: "")

// 入力された検索クエリの取得
guard let keyword = readLine(strippingNewline: true) else {
    exit(1)
}

let client = GitHubClient(httpClient: URLSession.shared)

let request = GitHubAPI.SearchRepositories(keyword: keyword)

client.send(request: request) { result in
    switch result {
    case .success(let response):
        for item in response.items {
            print(item.owner.login + "/" + item.name)
        }
        exit(0)
    case .failure(let error):
        print(error)
        exit(1)
    }
}

let timeoutInterval: TimeInterval = 60
// タイムアウトまでメインスレッドを停止
Thread.sleep(forTimeInterval: timeoutInterval)

print("Connection Timeout")
exit(1)
