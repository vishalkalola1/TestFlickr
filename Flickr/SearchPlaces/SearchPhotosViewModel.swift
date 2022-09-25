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
    
    /// Page status
    private enum LoadStatus {
        case ready (nextPage: Int)
        case loading (page: Int)
        case parseError
        case done
    }
    
    /// Title of view
    var title: String {
        "Search Photos"
    }
    
    /// Published any error or list of photos
    @Published var photos: [Photo] = []
    @Published var error: Error?
    
    private var loadStatus = LoadStatus.ready(nextPage: 1)
    private let photosRepository: PhotosRepositoryProtocol
    
    /// init method for view model dependant on ``PhotosRepository``
    init(photosRepository: PhotosRepositoryProtocol = PhotosRepository()) {
        self.photosRepository = photosRepository
        fetchPhotos()
    }
    
    /// Save recent search and if already exist ignore
    private func saveRecentSearch(_ text: String) {
        if text != "" {
            var recentSearch = recentSearch
            if !recentSearch.contains(where: { $0.lowercased() == text.lowercased()}) {
                recentSearch.append(text)
            }
            UserDefaults.standard.set(recentSearch, forKey: "recentSearches")
        }
    }
    
    /// Get recent search array
    var recentSearch: [String] {
        return UserDefaults.standard.object(forKey: "recentSearches") as? [String] ?? []
    }
    
    /// This function check pagination api call need to send or not and bind with view
    @discardableResult
    func loadMoreMovies(currentItem: Photo, text: String) -> Bool {
        let isLoadingData = shouldLoadMoreData(currentItem: currentItem)
        if isLoadingData {
            fetchPhotos(text)
        }
        return isLoadingData
    }
    
    /// Search text from intial page and save recent search
    func seachText(_ text: String) {
        loadStatus = LoadStatus.ready(nextPage: 1)
        self.photos = []
        fetchPhotos(text)
        saveRecentSearch(text)
    }
}

private extension SearchPhotosViewModel {
    
    /// Fetch photos
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
    
    /// Get Page number
    var page: Int? {
        guard case let .ready(page) = loadStatus else {
            return nil
        }
        return page
    }
    
    /// This function check that scroll reach to last 4th item.
    func shouldLoadMoreData(currentItem: Photo) -> Bool {
        let pageEnd = photos.count - 4
        if pageEnd >= 0, currentItem.id == photos[pageEnd].id {
            return true
        }
        return false
    }
    
    /// This function append data paginated photos and publish to view.
    func handleSuccess(result: Photos?) {
        guard let result = result, var photos = result.photo, !photos.isEmpty, let page = result.page, let pages = result.pages else {
            self.loadStatus = .done
            return
        }
        
        /// Check photos has duplicate or not
        photos = contains(photos)
        self.photos = photos
        
        /// Increment page if there is next page.
        self.loadStatus = page == pages ? .done : .ready(nextPage: page + 1)
    }
    
    func contains(_ photos: [Photo]) -> [Photo] {
        var tmpPhotos: [Photo] = []
        /// ignore duplicate id and append other
        for photo in photos {
            if !(self.photos.contains(where: {$0.id == photo.id })) {
                tmpPhotos.append(photo)
            }
        }
        return tmpPhotos
    }
}
