//
//  PopularMoviesService.swift
//  Movies
//
//  Created by xdmgzdev on 19/04/2021.
//

import Foundation

struct PhotosService: NetworkService {
    
    var baseURL: String {
        CommonMovieService.baseURL
    }
    
    var method: HttpMethod {
        .get
    }
    
    var httpBody: Encodable? {
        nil
    }
    
    var headers: [String: String]? {
        nil
    }
    
    var queryParameters: [URLQueryItem]? {
        [URLQueryItem(name: "method", value: path),
         URLQueryItem(name: "api_key", value: CommonMovieService.apiKey),
         URLQueryItem(name: "format", value: CommonMovieService.formate),
         URLQueryItem(name: "nojsoncallback", value: CommonMovieService.nojsoncallback),
         URLQueryItem(name: "auth_token", value: CommonMovieService.authToken),
         URLQueryItem(name: "api_sig", value: CommonMovieService.apiSig),
         URLQueryItem(name: "per_page", value: "100"),
         URLQueryItem(name: "page", value: "\(page)")]
    }
    
    var timeout: TimeInterval? {
        30
    }
    
    var path: String {
        "flickr.photos.search"
    }
    
    private var page: Int
    
    internal init(page: Int) {
        self.page = page
    }
}
