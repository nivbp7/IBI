//
//  ProductTableViewCell.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {

    static let reuseID = "ProductTableViewCell"
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    let brandLabel = UILabel()
    let productImageView = UIImageView()
    
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
    }
    
    // MARK: - Layout
    private func layoutViews() {
        contentView.add(subviews: [titleLabel, descriptionLabel, priceLabel, brandLabel, productImageView])
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            brandLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            brandLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
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
        
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
    }
}
