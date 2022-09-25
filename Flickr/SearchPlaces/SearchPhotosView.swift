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
                if !viewModel.recentSearch.isEmpty && isTextFieldFocused {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recent search")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem(.flexible())], alignment: .center) {
                                ForEach(viewModel.recentSearch, id: \.self) { item in
                                    Text(item)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .clipShape(Capsule())
                                        .onTapGesture {
                                            queryString = item
                                            isTextFieldFocused = false
                                            viewModel.seachText(queryString)
                                        }
                                }
                            }
                            .padding(5)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                ScrollView(.vertical) {
                    LazyVGrid(columns: twoColumnGrid, alignment: .center) {
                        ForEach(viewModel.photos, id: \.id) { item in
                            ImageView(url: item.url)
                                .onAppear {
                                    self.viewModel.loadMoreMovies(currentItem: item, text: queryString)
                                }
                        }
                    }
                }
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
