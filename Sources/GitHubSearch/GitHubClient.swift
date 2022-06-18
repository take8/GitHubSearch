//
//  GitHubClient.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/19.
//

import Foundation

class GitHubClient {
    private let httpClient: HTTPClient

    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    public func send<Request : GitHubRequest>(request: Request, completion: @escaping (Result<Request.Response, GitHubClientError>) -> Void) {
        let urlRequest = request.buildURLRequest()
        
        httpClient.sendRequest(urlRequest) { result in
            switch result {
            case .success((let data, let urlResponse)):
                do {
                    let response = try request.response(from: data, urlResponse: urlResponse)
                    completion(.success(response))
                } catch let error as GitHubAPIError {
                    completion(.failure(.apiError(error)))
                } catch {
                    completion(.failure(.responseParseError(error)))
                }
            case .failure(let error):
                completion(.failure(.connectionError(error)))
            }
        }
    }
}
