//
//  ProductsViewModel.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import Foundation

final class ProductsViewModel {
    
    private let networkAccess: NetworkAccessing
    
    var products: [Product] = []
    
    // MARK: - Initialization
    init(networkAccess: NetworkAccessing) {
        self.networkAccess = networkAccess
    }
    
    // MARK: - Public
    func fetchProducts(with completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            completion(NetworkError.invalidURL)
            return
        }
        let request = Request(url: url, method: .get)
        
        Task {
            do {
                let data = try await self.networkAccess.fetchData(for: request)
                let result: Result<Products, Error> = data.parse()
                switch result {
                case .success(let products):
                    self.products = products.products
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            } catch {
                completion(error)
            }
        }
    }
}
