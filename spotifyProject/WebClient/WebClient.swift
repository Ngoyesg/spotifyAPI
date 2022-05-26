//
//  WebClient.swift
//  spotifyProject
//
//  Created by Natalia Goyes on 26/05/22.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

struct Endpoint {
    let url: String
    let httpMethod: HTTPMethod
    let bodyParams: Data?
}

enum WebServiceError: Error {
    case invalidRequest, invalidStatusCodeResponse, errorDecodingData, errorEncodingData
}

protocol WebClient {
    func performRequest(endpoint: Endpoint, onSuccess: @escaping (Data?)-> Void, onError: @escaping (WebServiceError)-> Void)
}
