//
//  RESTClient.swift
//  spotifyProject
//
//  Created by Natalia Goyes on 26/05/22.
//

import Foundation

class RESTClient: WebClient {
    
    func performRequest(endpoint: Endpoint, onSuccess: @escaping (Data?) -> Void, onError: @escaping (WebServiceError) -> Void) {
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
    
    func process(taskResponse: (data: Data?, response: URLResponse?, error: Error?), onSuccess: @escaping (Data?) -> Void, onError: @escaping (WebServiceError) -> Void) {
        if taskResponse.error != nil {
            onError(WebServiceError.invalidRequest)
            return
        }
        if let responseStatus = taskResponse.response as? HTTPURLResponse, !(200..<300).contains(responseStatus.statusCode) {
            onError(WebServiceError.invalidStatusCodeResponse)
            return
        }
        onSuccess(taskResponse.data)
    }
}
