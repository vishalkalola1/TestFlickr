//
//  FlickrApp.swift
//  Flickr
//
//  Created by vishal on 9/22/22.
//

import Foundation

protocol PhotosRepositoryProtocol {
    typealias PhotosResultHandler = (Result<Photos?, Error>) -> Void
    func searchPhotos(by page: Int, title: String, completion: @escaping PhotosResultHandler)
}

struct PhotosRepository: PhotosRepositoryProtocol {
    
    private var networkProvider: NetworkProviderProtocol
    
    init(networkProvider: NetworkProviderProtocol = NetworkProvider()) {
        self.networkProvider = networkProvider
    }
    
    func searchPhotos(by page: Int, title: String, completion: @escaping PhotosResultHandler) {
        let searchServices = PhotosService(page: page, title: title)
        searchPhotos(service: searchServices, completion: completion)
    }
}

private extension PhotosRepository {
    func searchPhotos(service: NetworkService, completion: @escaping PhotosResultHandler) {
        networkProvider.request(dataType: PhotosResult.self, service: service, onQueue: .main) { results in
            do {
                let photosResult = try results.get()
                completion(.success(photosResult.photos))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
