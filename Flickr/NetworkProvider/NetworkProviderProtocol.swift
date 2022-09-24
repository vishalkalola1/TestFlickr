//
//  NetworkProviderProtocol.swift
//  NetworkProvider
//
//  Created by Vishal on 8/18/22.
//

import Foundation

public protocol NetworkProviderProtocol {    
    func request<T: Decodable>(dataType: T.Type, service: NetworkService, onQueue: DispatchQueue, completion: @escaping (Result<T, LocalError>) -> Void)
}
