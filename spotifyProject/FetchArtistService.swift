//
//  FetchArtistService.swift
//  spotifyProject
//
//  Created by Natalia Goyes on 26/05/22.
//

import Foundation

protocol FetchArstistWebRequestProtocol: AnyObject {
    func getArtist()
}


class FetchArstistWebRequest {
    let webClient: WebClient
    
    init(webClient: WebClient) {
        self.webClient = webClient
    }
    
    
    
}

extension FetchArstistWebRequest: FetchArstistWebRequestProtocol {
    
    func getArtist() {
        //
    }
    
    
}
