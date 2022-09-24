//
//  FlickrApp.swift
//  Flickr
//
//  Created by vishal on 9/22/22.
//

import SwiftUI
import MapKit

struct SearchPhotosView: View {
    
    @StateObject var viewModel = SearchPhotosViewModel()
    
    private let twoColumnGrid = [
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40))
    ]
    
    var body: some View {
        Navigation(title: viewModel.title, style: .inline) {
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: twoColumnGrid, alignment: .center) {
                        ForEach(0...100, id: \.self) { item in
                            GeometryReader { gr in
                                ImageView(url: URL(string: "https://cdn.pixabay.com/photo/2018/08/14/13/23/ocean-3605547_1280.jpg"))
                                    .frame(height: gr.size.width)
                                    .cornerRadius(10)
                            }
                            .clipped()
                            .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                .padding(8)
            }
        }
    }
}

struct SearchPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPhotosView()
    }
}
