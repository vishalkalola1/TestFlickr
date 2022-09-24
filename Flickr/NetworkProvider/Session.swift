//
//  SessionProtocol.swift
//  NetworkProvider
//
//  Created by Vishal on 8/18/22.
//

import Foundation

public class Session: SessionProtocol {
    
    public let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func dataTask<T: Decodable>(_ request: URLRequest, dataType: T.Type, completion: @escaping (Result<T, LocalError>) -> Void) -> URLSessionDataTask {
        return session.dataTask(with: request) { [weak self] data, response, error in
            let result = Result { [weak self] () throws -> T in
                guard let self = self else {
                    throw LocalError.operationCancelled
                }
                
                if let requestError = error {
                    throw LocalError.requestFailed(error: requestError)
                }
                
                try self.validate(response: response, statusCodes: Environment.successStatusCodeRange)
                return try self.decode(data: data, type: dataType)
            }.mapError { err in
                return err as! LocalError
            }
            completion(result)
        }
    }
}

private extension Session {
    func validate(response: URLResponse?, statusCodes: Range<Int>) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw LocalError.unknownStatusCode
        }
        
        if !statusCodes.contains(httpResponse.statusCode) {
            throw LocalError.unexpectedStatusCode(code: httpResponse.statusCode)
        }
    }
    
    func decode<T: Decodable>(data: Data?, type: T.Type) throws -> T {
        guard let data = data, !data.isEmpty else {
            throw LocalError.contentEmptyData
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw LocalError.contentDecoding(error: error)
        }
    }
}
