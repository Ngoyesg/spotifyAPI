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
    typealias onSuccess = (Data?)-> Void
    typealias onError = (WebServiceError)-> Void
    func performRequest(endpoint: Endpoint, onSuccess: @escaping onSuccess, onError: @escaping onError)
}
