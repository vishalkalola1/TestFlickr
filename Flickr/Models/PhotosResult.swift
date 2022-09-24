//
//  PhotosResult.swift
//  Flickr
//
//  Created by vishal on 8/18/22.
//

import Foundation

struct PhotosResult: Codable {
    let photos: Photos?
    let stat: String?
}

struct Photos: Codable {
    let page: Int?
    let pages: String?
    let perpage: Int?
    let total: String?
    let photo: [Photo]?
}

struct Photo: Codable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let ispublic: Bool?
    let isfriend: Bool?
    let isfamily: Bool?
}
