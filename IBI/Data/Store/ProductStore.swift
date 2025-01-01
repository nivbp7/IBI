//
//  ProductStore.swift
//  IBI
//
//  Created by niv ben-porath on 01/01/2025.
//

import Foundation

protocol ProductStoring {
    func add(product: Product)
    func remove(productID: Int)
    func favoriteProducts() -> [Product]
    func isFavorite(productID: Int) -> Bool
}

final class ProductStore: ProductStoring {
    
    private let defaults = UserDefaults.standard
    static private let productsKey = "savedProducts"
    
    func isFavorite(productID: Int) -> Bool {
        let products = loadProducts()
        return products.contains { $0.id == productID }
    }
    
    func favoriteProducts() -> [Product] {
        return loadProducts()
    }
    
    func add(product: Product) {
        var products = loadProducts()
        products.append(product)
        save(products: products)
    }
    
    func remove(productID: Int) {
        var products = loadProducts()
        products.removeAll { $0.id == productID }
        save(products: products)
    }
    
    private func save(products: [Product]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(products)
            defaults.set(data, forKey: ProductStore.productsKey)
        } catch {
            print("Failed to save products: \(error)")
        }
    }
    
    private func loadProducts() -> [Product] {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: ProductStore.productsKey) {
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode([Product].self, from: data)
                return products
            } catch {
                print("Failed to load products: \(error)")
            }
        }
        return []
    }

}
