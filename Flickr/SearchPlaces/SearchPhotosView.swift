//
//  FlickrApp.swift
//  Flickr
//
//  Created by vishal on 9/22/22.
//

import SwiftUI

struct SearchPhotosView: View {
    
    @StateObject var viewModel = SearchPhotosViewModel()
    @State private var queryString = ""
    @FocusState private var isTextFieldFocused: Bool
    
    private let twoColumnGrid = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]
    
    var body: some View {
        Navigation(title: viewModel.title, style: .inline) {
            VStack {
                searchField
                if !viewModel.recentSearch.isEmpty && isTextFieldFocused {
                    recentSearchView
                }
                photogrid
            }
            .errorAlert(error: $viewModel.error)
            .padding(8)
        }
    }
    
    var searchField: some View {
        TextField("Search here....", text: $queryString)
            .onSubmit {
                viewModel.seachText(queryString)
            }
            .focused($isTextFieldFocused)
            .padding(8)
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.red, style: StrokeStyle(lineWidth: 1.0)))
    }
    
    var photogrid: some View {
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
    
    var recentSearchView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Recent search...")
                .foregroundColor(.gray)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], alignment: .center) {
                    ForEach(viewModel.recentSearch, id: \.self) { item in
                        Text(item)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                            .overlay(RoundedRectangle(cornerRadius: 20.0).strokeBorder(Color.red, style: StrokeStyle(lineWidth: 1.0)))
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
}

struct SearchPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPhotosView()
    }
}
