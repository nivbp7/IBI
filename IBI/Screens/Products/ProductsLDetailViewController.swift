//
//  ProductsLDetailViewController.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit
import SDWebImage

class ProductsLDetailViewController: UIViewController {

    let product: Product
    
    private let productDescriptionLabel = UILabel()
    private let productPriceLabel = UILabel()
    private let productBrandLabel = UILabel()
    private let favoriteButton = UIButton()
    
    // MARK: - Initialization
    init(product: Product) {
        self.product = product
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
        layoutButton()
        layoutLabels()
    }
    
    private func layoutButton() {
        view.add(subviews: [favoriteButton])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func layoutLabels() {
        view.add(subviews: [productPriceLabel, productBrandLabel, productDescriptionLabel])
        
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 8),
            productPriceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            productPriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            productPriceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            productBrandLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 8),
            productBrandLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            productBrandLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            productBrandLabel.heightAnchor.constraint(equalToConstant: 20),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productBrandLabel.bottomAnchor, constant: 8),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            productDescriptionLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // MARK: - Setup
    private func setup() {
        setupView()
        setupButton()
        setupLabels()
        setupImages()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        self.title = product.title
    }
    
    private func setupButton() {
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    private func setupLabels() {
        productPriceLabel.text = "Price: \(product.price)"
        productPriceLabel.textColor = .label
        productPriceLabel.textAlignment = .left
        
        if let brand = product.brand {
            productBrandLabel.text = "Brand: \(brand)"
        } else {
            productBrandLabel.text = "Brand: Unknown"
        }
        productBrandLabel.textColor = .label
        productBrandLabel.textAlignment = .left
        
        productDescriptionLabel.text = product.description
        productDescriptionLabel.textColor = .label
        productDescriptionLabel.textAlignment = .left
        productDescriptionLabel.numberOfLines = 0
    }
    
    //TODO: - Might be better to implement as a collection view
    private func setupImages() {
        let stackView = createVerticalStackView()
        view.add(subviews: [stackView])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    //MARK: - Actions
    @objc private func favoriteButtonTapped() {
        let image = favoriteButton.imageView?.image
        if image == UIImage(systemName: "heart") {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    //MARK: - Helpers
    private func createVerticalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        for imageName in product.images {
            let imageView = UIImageView()
            imageView.sd_setImage(with: URL(string: imageName)!, placeholderImage: nil)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true // Set a fixed height
            imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true // Set a fixed width
            stackView.addArrangedSubview(imageView)
        }
        
        return stackView
    }
}
