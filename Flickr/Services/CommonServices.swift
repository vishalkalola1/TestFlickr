//
//  FlickrApp.swift
//  Flickr
//
//  Created by vishal on 9/22/22.
//

import Foundation

/// Define static data here
enum CommonMovieService {
    
    static var baseURL: String {
        "https://www.flickr.com/services/rest"
    }

    static var apiKey: String {
        "86860772a5b7baf5c70156a3934e55cb"
    }
    
    static var formate: String {
        "json"
    }
    
    static var nojsoncallback: String {
        "1"
    }
}
