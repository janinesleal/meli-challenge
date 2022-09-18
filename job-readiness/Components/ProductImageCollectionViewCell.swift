//
//  ProductImageCollectionViewCell.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 16/09/22.
//

import UIKit

class ProductImageCollectionViewCell: UICollectionViewCell {
    
    lazy var productImage : UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(productImage)
        
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 183),
            productImage.widthAnchor.constraint(equalToConstant: 297),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
