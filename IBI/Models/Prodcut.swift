//
//  Prodcut.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import Foundation

struct Products: Codable {
    let products: [Product]
}

struct Product: Codable {
    let title: String
    let description: String
    let price: Double
    let brand: String?
    let thumbnail: String
    let images: [String]
}

extension Product {
    static let dummyProduct = Product(title: "Product Title",
                                      description: "Product Description",
                                        price: 100.0,
                                        brand: "Product Brand",
                                        thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png",
                                        images: ["Image1", "Image2", "Image3"])
}
