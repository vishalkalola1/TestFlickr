//
//  FlickrApp.swift
//  Flickr
//
//  Created by vishal on 9/22/22.
//

import Foundation

enum CommonMovieService {
    
    static var baseURL: String {
        "https://www.flickr.com/services/rest/"
    }

    static var apiKey: String {
        "1011eebe1638a23ce9e0a70d5b44a70d"
    }
    
    static var authToken: String {
        "72157720858437440-084ab17823ee0420"
    }
    
    static var apiSig: String {
        "e53a29fa62498c78b18c8b8024c2bd06"
    }
    
    static var formate: String {
        "json"
    }
    
    static var nojsoncallback: String {
        "1"
    }
}
