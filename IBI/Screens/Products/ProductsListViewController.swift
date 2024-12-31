//
//  ProductsListViewController.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit
import SDWebImage

final class ProductsListViewController: UIViewController {
    
    private lazy var tableView = newTableView()
    
    // MARK: - Initialization
    init() {
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseID, for: indexPath) as? ProductTableViewCell else {
            preconditionFailure("could not dequeue ProductTableViewCell for \(indexPath) ")
        }
        let product = Product.dummyProduct
        cell.titleLabel.text = product.title
        cell.descriptionLabel.text = product.description
        cell.priceLabel.text = "\(product.price)"
        cell.brandLabel.text = product.brand
        cell.productImageView.sd_setImage(with: URL(string: product.thumbnail)!, placeholderImage: nil)

        return cell
    }
}

extension ProductsListViewController: UITableViewDelegate {
    
}

    

