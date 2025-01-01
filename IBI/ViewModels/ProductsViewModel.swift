//
//  ProductsViewModel.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import Foundation

final class ProductsViewModel {
    
    static let baseURL = "https://dummyjson.com/products"

    private let networkAccess: NetworkAccessing
    private let productStore: ProductStoring
    
    private var currentPage = 0
    private let limit = 10
    var products: [Product] = []
    var favoriteProducts: [Product] = []
    
    // MARK: - Initialization
    init(networkAccess: NetworkAccessing, productStore: ProductStoring) {
        self.networkAccess = networkAccess
        self.productStore = productStore
    }
    
    // MARK: - Public - load products
    func fetchProducts(with completion: @escaping (Error?) -> Void) {
        let urlString = "\(ProductsViewModel.baseURL)?limit=\(limit)&skip=\(currentPage * limit)"
        guard let url = URL(string: urlString) else {
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
                    self.products.append(contentsOf: products.products)
                    self.currentPage += 1
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            } catch {
                completion(error)
            }
        }
    }
    
    func loadFavoriteProducts() {
        favoriteProducts = productStore.favoriteProducts()
    }
    
    // MARK: - Public - products actions
    func didFavoriteProduct(with id: Int) -> Bool? {
        if productStore.isFavorite(productID: id) {
            productStore.remove(productID: id)
            return false
        } else {
            guard let product = products.first(where: { $0.id == id }) else {return nil}
            productStore.add(product: product)
            return true
        }
    }
    
    func isFavorite(product: Product) -> Bool {
        return productStore.isFavorite(productID: product.id)
    }
    
    //MARK: - Table view
    func numberOfRowsInSection(for productList: ProductList) -> Int {
        switch productList {
        case .all: return products.count
        case .favorites: return favoriteProducts.count
        }
    }
    
    func product(at indexPath: IndexPath, for productList: ProductList) -> Product {
        switch productList {
        case .all:
            guard indexPath.row < products.count else {
                preconditionFailure("product out of bounds for \(indexPath)")
            }
            return products[indexPath.row]
        case .favorites:
            guard indexPath.row < favoriteProducts.count else {
                preconditionFailure("product out of bounds for \(indexPath)")
            }
            return favoriteProducts[indexPath.row]
        }
    }
}

enum ProductList {
    case all
    case favorites
}
