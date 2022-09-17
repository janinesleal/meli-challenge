//
//  ProductTableViewCell.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 16/09/22.
//

import UIKit
import Kingfisher

class ProductTableViewCell : UITableViewCell {
    static let cellID = "productCell"
    
    var product : ProductResponse? {
        didSet {
            productImage.kf.setImage(with: product?.body?.thumbnail?.toHttps())
            productNameLabel.text = product?.body?.title
            productPriceLabel.text = product?.body?.price?.toBRL()
        }
    }
    
    lazy var productNameLabel : UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .black
        element.font = element.font.withSize(18)
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    
    lazy var productPriceLabel : UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .black
        element.font = UIFont.systemFont(ofSize: 16)
        element.textAlignment = .left
        element.numberOfLines = 0
        return element
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        stack.contentMode = .scaleToFill
        stack.alignment = .leading
        stack.distribution = .fill
        [self.productNameLabel,
         self.productPriceLabel,
        ].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    
    lazy var productImage : UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        contentView.addSubview(productImage)
        contentView.addSubview(stackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productImage.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
