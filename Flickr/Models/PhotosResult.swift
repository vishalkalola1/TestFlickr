//
//  FlickrApp.swift
//  Flickr
//
//  Created by vishal on 9/22/22.
//

import Foundation

struct PhotosResult: Codable {
    let photos: Photos?
    let stat: String?
}

struct Photos: Codable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
    let photo: [Photo]?
}

struct Photo: Codable, Identifiable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let ispublic: Int?
    let isfriend: Int?
    let isfamily: Int?
    
    var url: URL? {
        guard let farm = farm, let server = server, let id = id, let secret = secret else { return nil }
        return URL(string: "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg")!
    }
}
