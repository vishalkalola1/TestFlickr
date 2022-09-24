//
//  PlacesRepository.swift
//  Locale
//
//  Created by vishal on 8/18/22.
//

import Foundation

protocol PhotosRepositoryProtocol {
    typealias PhotosResultHandler = (Result<PhotosResult, LocalError>) -> Void
    func searchPhotos(by page: Int, completion: @escaping PhotosResultHandler)
}

struct PhotosRepository: PhotosRepositoryProtocol {
    
    private var networkProvider: NetworkProviderProtocol
    
    init(networkProvider: NetworkProviderProtocol = NetworkProvider()) {
        self.networkProvider = networkProvider
    }
    
    func searchPhotos(by page: Int, completion: @escaping PhotosResultHandler) {
        let searchServices = PhotosService(page: page)
        searchPhotos(service: searchServices, completion: completion)
    }
}

private extension PhotosRepository {
    func searchPhotos(service: NetworkService, completion: @escaping PhotosResultHandler) {
        networkProvider.request(dataType: PhotosResult.self, service: service, onQueue: .main) { result in
            completion(result)
        }
    }
}
