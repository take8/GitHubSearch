//
//  HTTPClient.swift
//  
//
//  Created by Takeya Shimizu on 2022/06/18.
//

import Foundation

public protocol HTTPClient {
    func sendRequest(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
}

extension URLSession : HTTPClient {
    public func sendRequest(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        let task = dataTask(with: urlRequest) { data, urlResponse, error in
            switch (data, urlResponse, error) {
            case (_, _, let error?):
                completion(Result.failure(error))
            case (let data?, let urlResponse as HTTPURLResponse, _):
                completion(Result.success((data, urlResponse)))
            default:
                fatalError("invalid response combination \(String(describing: (data, urlResponse, error))).")
            }
        }

        task.resume()
    }
}

class StubHTTPClient : HTTPClient {
    var result: Result<(Data, HTTPURLResponse), Error> = .success((
        Data(),
        HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)!
    ))

    func sendRequest(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
            completion(self.result)
        }
    }
}
