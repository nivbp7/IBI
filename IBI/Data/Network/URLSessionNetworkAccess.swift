//
//  URLSessionNetworkAccess.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import Foundation

public protocol NetworkAccessing {
    func fetchData(for request: Request) async throws -> Data
}

public enum NetworkError: Error {
    case networkError(text: String?)
    case responseError
    case invalidData
}

public class URLSessionNetworkAccess: NetworkAccessing {
    
    private let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    /// Fetch the data from the network using async/await
    /// - Parameter request: A Request that includes the URL and HTTP Method
    /// - Returns: The Data object from this URL
    public func fetchData(for request: Request) async throws -> Data {
        do {
            let (data, response) = try await session.data(for: request.build())
            guard let
                    networkResponse = response as? HTTPURLResponse,
                  networkResponse.statusCode == 200
            else {
                throw NetworkError.responseError
            }
            return data
            
        } catch {
            throw NetworkError.networkError(text: error.localizedDescription)
        }
    }
}
