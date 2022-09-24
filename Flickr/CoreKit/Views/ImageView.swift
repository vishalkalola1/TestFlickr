//
//  ImageView.swift
//  Locale
//
//  Created by vishal on 8/21/22.
//

import SwiftUI

struct ImageView: View {
    
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
        } placeholder: {
            Image(systemName: "photo")
                .resizable()
        }
    }
}
