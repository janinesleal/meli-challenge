//
//  FavProductCollectionViewCell.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 17/09/22.
//

import UIKit

class FavProductCollectionViewCell: UICollectionViewCell {
    static let cellID = "favCell"
    
    var product : ProductResponse? {
        didSet {
            productImage.kf.setImage(with: product?.body?.thumbnail?.toHttps())
            productNameLabel.text = product?.body?.title
            productPriceLabel.text = product?.body?.price?.toBRL()
        }
    }
    
    lazy var productImage : UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    lazy var productNameLabel : UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .black
        element.font = UIFont(name: Font.medium, size: 15)
        element.numberOfLines = 0
        element.lineBreakMode = .byTruncatingTail
        element.textAlignment = .left
        return element
    }()
    
    lazy var productPriceLabel : UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .black
        element.font = UIFont(name: Font.regular, size: 14)
        element.textAlignment = .left
        element.numberOfLines = 0
        return element
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.contentMode = .scaleToFill
        stack.alignment = .leading
        stack.distribution = .fill
        [self.productNameLabel,
         self.productPriceLabel,
        ].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        contentView.addSubview(productImage)
        contentView.addSubview(stackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -120),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
