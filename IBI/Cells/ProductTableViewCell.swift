//
//  ProductTableViewCell.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    static let reuseID = "ProductTableViewCell"
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    let brandLabel = UILabel()
    let productImageView = UIImageView()
    let favoriteButton = UIButton()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.autoresizingMask = [.flexibleHeight,.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin,.flexibleTopMargin,.flexibleWidth]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Layout
    private func layoutViews() {
        contentView.add(subviews: [titleLabel, descriptionLabel, priceLabel, brandLabel, productImageView, favoriteButton])
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            brandLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            brandLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            favoriteButton.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            favoriteButton.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            
        ])
    }
    
    // MARK: - Setup
    private func setupViews() {
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
        
        titleLabel.textColor = .label
        descriptionLabel.textColor = .label
        priceLabel.textColor = .label
        brandLabel.textColor = .label
    }
}
