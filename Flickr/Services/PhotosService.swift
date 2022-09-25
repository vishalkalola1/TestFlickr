//
//  FlickrApp.swift
//  Flickr
//
//  Created by vishal on 9/22/22.
//

import Foundation

/// Define here the PhotoServices Request Data
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
        [URLQueryItem(name: "method", value: "flickr.photos.search"),
         URLQueryItem(name: "api_key", value: CommonMovieService.apiKey),
         URLQueryItem(name: "format", value: CommonMovieService.format),
         URLQueryItem(name: "nojsoncallback", value: CommonMovieService.nojsoncallback),
         URLQueryItem(name: "per_page", value: "100"),
         URLQueryItem(name: "media", value: "photos"),
         URLQueryItem(name: "page", value: "\(page)"),
         URLQueryItem(name: "text", value: title)]
    }
    
    var timeout: TimeInterval? {
        30
    }
    
    var path: String {
        ""
    }
    
    private var page: Int
    private var title: String
    
    internal init(page: Int, title: String) {
        self.page = page
        self.title = title
    }
}
