//
//  FlickrApp.swift
//  Flickr
//
//  Created by vishal on 9/22/22.
//

import SwiftUI

struct SearchPhotosView: View {
    
    @StateObject var viewModel = SearchPhotosViewModel()

    @State var queryString = ""
    @FocusState private var isTextFieldFocused: Bool
    
    private let twoColumnGrid = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]
    
    var body: some View {
        Navigation(title: viewModel.title, style: .inline) {
            VStack {
                TextField("Search here....", text: $queryString)
                    .onSubmit {
                        viewModel.seachText(queryString)
                    }
                    .focused($isTextFieldFocused)
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.red, style: StrokeStyle(lineWidth: 1.0)))
                ScrollView(.vertical) {
                    LazyVGrid(columns: twoColumnGrid, alignment: .center) {
                        ForEach(viewModel.photos, id: \.id) { item in
                            ImageView(url: item.url)
                                .aspectRatio(1, contentMode: .fill)
                                .clipped()
                                .cornerRadius(10)
                                .onAppear {
                                    self.viewModel.loadMoreMovies(currentItem: item, text: queryString)
                                }
                        }
                    }
                }
                .overlay(content: {
                    if !viewModel.recentSearch.isEmpty && isTextFieldFocused && queryString == "" {
                        List {
                            ForEach(0..<viewModel.recentSearch.count, id: \.self) { i  in
                                Text(viewModel.recentSearch[i])
                                    .onTapGesture {
                                        queryString = viewModel.recentSearch[i]
                                        isTextFieldFocused = false
                                        viewModel.seachText(queryString)
                                    }
                            }
                        }
                    }
                })
            }
            .errorAlert(error: $viewModel.error)
            .padding(8)
        }
    }
}

struct SearchPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPhotosView()
    }
}
