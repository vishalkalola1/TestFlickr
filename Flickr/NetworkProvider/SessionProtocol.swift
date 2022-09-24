//
//  SessionProtocol.swift
//  NetworkProvider
//
//  Created by Vishal on 8/18/22.
//

import Foundation

public protocol SessionProtocol {
    func dataTask<T: Decodable>(_ request: URLRequest, dataType: T.Type, completion: @escaping (Result<T, LocalError>) -> Void) -> URLSessionDataTask
}

