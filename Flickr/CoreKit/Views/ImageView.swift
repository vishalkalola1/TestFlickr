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
        AsyncImage(url: url) { image in
            VStack {
                image
                    .resizable()
            }
        } placeholder: {
            VStack {
                Image(systemName: "photo")
                    .resizable()
            }
        }
    }
}
