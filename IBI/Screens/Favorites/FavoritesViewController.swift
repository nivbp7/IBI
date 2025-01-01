//
//  FavoritesViewController.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit

final class FavoritesViewController: ProductsListViewController {
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    // MARK: - Configure
    func configure() {
        productsViewModel.loadFavoriteProducts()
        tableView.reloadData()
    }
}

extension FavoritesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsViewModel.numberOfRowsInSection(for: .favorites)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseID, for: indexPath) as? ProductTableViewCell else {
            preconditionFailure("could not dequeue ProductTableViewCell for \(indexPath)")
        }
        let product = productsViewModel.product(at: indexPath, for: .favorites)
        cell.titleLabel.text = product.title
        cell.descriptionLabel.text = product.description
        cell.priceLabel.text = "\(product.price)"
        cell.brandLabel.text = product.brand
        cell.productImageView.sd_setImage(with: URL(string: product.thumbnail)!, placeholderImage: nil)

        return cell
    }
}

extension FavoritesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = productsViewModel.product(at: indexPath, for: .favorites)
        let productDetailViewController = ProductsDetailViewController(product: product, productsViewModel: productsViewModel)
        navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}
