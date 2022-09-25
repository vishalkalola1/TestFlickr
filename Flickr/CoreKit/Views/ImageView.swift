//
//  FlickrApp.swift
//  Flickr
//
//  Created by vishal on 9/22/22.
//

import SwiftUI

struct ImageView: View {
    
    let url: URL?
    
    var body: some View {
        
        if let url = url, let image = ImageCache[url] {
            image
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .clipped()
                .cornerRadius(10)
        } else {
            AsyncImage(url: url) { image in
                cacheImage(image)
            } placeholder: {
                VStack {
                    Image(systemName: "photo")
                        .resizable()
                }
            }
            .aspectRatio(1, contentMode: .fill)
            .clipped()
            .cornerRadius(10)
        }
    }
    
    func cacheImage(_ image: Image) -> some View {
        ImageCache[url!] = image
        return image
                .resizable()
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]

    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
