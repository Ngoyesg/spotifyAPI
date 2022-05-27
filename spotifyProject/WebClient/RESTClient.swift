//
//  RESTClient.swift
//  spotifyProject
//
//  Created by Natalia Goyes on 26/05/22.
//

import Foundation

class RESTClient: WebClient {
    
    typealias TaskResponse = (data: Data?, response: URLResponse?, error: Error?)
    private let invalidResponseStatusCodes = (200..<300)
    
    func performRequest(endpoint: Endpoint, onSuccess: @escaping onSuccess, onError: @escaping onError) {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        let url = URL(string: endpoint.url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        let task = urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.process(taskResponse: (data: data, response: response, error: error), onSuccess: onSuccess, onError: onError)
            }
        }
        task.resume()
    }
    
    func process(taskResponse: TaskResponse, onSuccess: @escaping onSuccess, onError: @escaping onError) {
        if taskResponse.error != nil {
            onError(WebServiceError.invalidRequest)
            return
        }
        if let responseStatus = taskResponse.response as? HTTPURLResponse, !(invalidResponseStatusCodes).contains(responseStatus.statusCode) {
            onError(WebServiceError.invalidStatusCodeResponse)
            return
        }
        onSuccess(taskResponse.data)
    }
    
}
