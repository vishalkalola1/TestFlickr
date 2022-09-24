//
//  FlickrApp.swift
//  Flickr
//
//  Created by vishal on 9/22/22.
//

import Foundation
import Combine

protocol SearchPhotosViewModelProtocol: ObservableObject {
    var photos: [Photo] { get }
}

final class SearchPhotosViewModel: SearchPhotosViewModelProtocol {
    
    private enum LoadStatus {
        case ready (nextPage: Int)
        case loading (page: Int)
        case parseError
        case done
    }
    
    var title: String {
        "Search Photos"
    }
    
    @Published var photos: [Photo] = []
    @Published var error: Error?
    
    private var loadStatus = LoadStatus.ready(nextPage: 1)
    private let photosRepository: PhotosRepositoryProtocol
    
    init(photosRepository: PhotosRepositoryProtocol = PhotosRepository()) {
        self.photosRepository = photosRepository
        fetchPhotos()
    }
    
    private func saveRecentSearch(_ text: String) {
        if text != "" {
            var recentSearch = recentSearch
            if !recentSearch.contains(where: { $0.lowercased() == text.lowercased()}) {
                recentSearch.append(text)
            }
            UserDefaults.standard.set(recentSearch, forKey: "recentSearches")
        }
    }
    
    var recentSearch: [String] {
        return UserDefaults.standard.object(forKey: "recentSearches") as? [String] ?? []
    }
    
    @discardableResult
    func loadMoreMovies(currentItem: Photo, text: String) -> Bool {
        let isLoadingData = shouldLoadMoreData(currentItem: currentItem)
        if isLoadingData {
            fetchPhotos(text)
        }
        return isLoadingData
    }
    
    func seachText(_ text: String) {
        loadStatus = LoadStatus.ready(nextPage: 1)
        self.photos = []
        fetchPhotos(text)
        saveRecentSearch(text)
    }
}

private extension SearchPhotosViewModel {
    
    func fetchPhotos(_ text: String = "") {
        guard let page = page else { return }
        loadStatus = .loading(page: page)
        photosRepository.searchPhotos(by: page, title: text) { [weak self] results in
            guard let self = self else { return }
            do {
                let photosResult = try results.get()
                self.handleSuccess(result: photosResult)
            } catch {
                self.loadStatus = .parseError
                self.error = error
            }
        }
    }
    
    var page: Int? {
        guard case let .ready(page) = loadStatus else {
            return nil
        }
        return page
    }
    
    func shouldLoadMoreData(currentItem: Photo) -> Bool {
        let pageEnd = photos.count - 4
        if pageEnd >= 0, currentItem.id == photos[pageEnd].id {
            return true
        }
        return false
    }
    
    func handleSuccess(result: Photos?) {
        guard let result = result, let photos = result.photo, !photos.isEmpty, let page = result.page, let pages = result.pages else {
            self.loadStatus = .done
            return
        }
        
        for photo in photos {
            if !(self.photos.contains(where: {$0.id == photo.id })) {
                self.photos.append(photo)
            }
        }
        
        self.loadStatus = page == pages ? .done : .ready(nextPage: page + 1)
    }
}
