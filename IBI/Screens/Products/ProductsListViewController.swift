//
//  ProductsListViewController.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit
import SDWebImage

final class ProductsListViewController: UIViewController {
    
    private let productsViewModel: ProductsViewModel
    
    private lazy var tableView = newTableView()
    
    // MARK: - Initialization
    init(productsViewModel: ProductsViewModel) {
        self.productsViewModel = productsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setup()
        configureProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - View layout
    private func layout() {
        tableView.snap(to: view)
    }
    
    // MARK: - Setup
    private func setup() {
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }

    // MARK: - Configure
    private func configureProducts() {
        productsViewModel.fetchProducts { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard error == nil else {
                    self.presentInformationAlertController(title: "Error fetching products", message: error?.localizedDescription)
                    return
                }
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Factory
    private func newTableView() -> UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }
}

extension ProductsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsViewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseID, for: indexPath) as? ProductTableViewCell else {
            preconditionFailure("could not dequeue ProductTableViewCell for \(indexPath) ")
        }
        guard indexPath.row < productsViewModel.products.count else {
            preconditionFailure("product out of bounds for \(indexPath)")
        }
        let product = productsViewModel.products[indexPath.row]
        cell.titleLabel.text = product.title
        cell.descriptionLabel.text = product.description
        cell.priceLabel.text = "\(product.price)"
        cell.brandLabel.text = product.brand
        cell.productImageView.sd_setImage(with: URL(string: product.thumbnail)!, placeholderImage: nil)

        return cell
    }
}

extension ProductsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row < productsViewModel.products.count else {
            preconditionFailure("product out of bounds for \(indexPath)")
        }
        let product = productsViewModel.products[indexPath.row]
        let productDetailViewController = ProductsDetailViewController(product: product, productsViewModel: productsViewModel)
        navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}
