//
//  DetailsView.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 21/09/22.
//

import UIKit

class DetailsView: UIView {
    
    //MARK: COMPONENTS
    lazy var navView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = Colors.yellow
        return element
    }()
    
    lazy var contentView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var imagesCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.itemSize = CGSize(width: 297, height: 184)
        viewLayout.minimumInteritemSpacing = 0
        viewLayout.scrollDirection = .horizontal
        let element = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var productTitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.numberOfLines = 0
        element.lineBreakMode = .byWordWrapping
        element.font = UIFont(name: Font.regular, size: 15)
        return element
    }()
    
    lazy var productPriceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFont(name: Font.medium, size: 18)
        return element
    }()
    
    lazy var productInfoStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.translatesAutoresizingMaskIntoConstraints = false
        element.spacing = 8
        element.contentMode = .scaleToFill
        element.alignment = .leading
        element.distribution = .fill
        [productTitleLabel,
         productPriceLabel,
        ].forEach { element.addArrangedSubview($0) }
        
        return element
    }()
    
    lazy var favButton: UIButton = {
        let btnTitle = NSMutableAttributedString(string: "Favoritar", attributes:[
            NSAttributedString.Key.font: UIFont(name: Font.regular, size: 14) as Any,
            NSAttributedString.Key.foregroundColor: Colors.darkBlue,
            ])
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setAttributedTitle(btnTitle, for: .normal)
        return element
    }()
    
    lazy var shareButton: UIButton = {
        let btnTitle = NSMutableAttributedString(string: "Compartilhar", attributes:[
            NSAttributedString.Key.font: UIFont(name: Font.regular, size: 14) as Any,
            NSAttributedString.Key.foregroundColor: Colors.darkBlue,
            ])
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setAttributedTitle(btnTitle, for: .normal)
        return element
    }()
    
    lazy var buttonStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.translatesAutoresizingMaskIntoConstraints = false
        element.spacing = 8
        element.contentMode = .center
        element.alignment = .center
        element.distribution = .fillEqually
        [favButton,
         shareButton,
        ].forEach { element.addArrangedSubview($0) }
        
        return element
    }()
    
    lazy var productDescriptionLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Teste"
        element.font = UIFont(name: Font.regular, size: 15)
        return element
    }()
    
    lazy var buyButton: UIButton = {
        let btnTitle = NSMutableAttributedString(string: "Comprar agora", attributes:[
            NSAttributedString.Key.font: UIFont(name: Font.regular, size: 14) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            ])
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = Colors.darkBlue
        element.layer.cornerRadius = 8
        element.setAttributedTitle(btnTitle, for: .normal)
        return element
    }()
    
    lazy var addCartButton: UIButton = {
        let btnTitle = NSMutableAttributedString(string: "Adicionar ao carrinho", attributes:[
            NSAttributedString.Key.font: UIFont(name: Font.regular, size: 14) as Any,
            NSAttributedString.Key.foregroundColor: Colors.darkBlue,
            ])
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = Colors.lightBlue
        element.layer.cornerRadius = 8
        element.setAttributedTitle(btnTitle, for: .normal)
        return element
    }()
    
    lazy var buyButtonStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.translatesAutoresizingMaskIntoConstraints = false
        element.spacing = 8
        element.contentMode = .center
        element.alignment = .center
        element.distribution = .fillEqually
        [buyButton,
         addCartButton,
        ].forEach { element.addArrangedSubview($0) }
        
        return element
    }()
    
    lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.translatesAutoresizingMaskIntoConstraints = false
        
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        addSubview(navView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imagesCollectionView)
        contentView.addSubview(productInfoStack)
        contentView.addSubview(buttonStack)
        contentView.addSubview(productDescriptionLabel)
        contentView.addSubview(buyButtonStack)
        
    }
    
    //MARK: CONSTRAINTS
    private func setConstraints() {
        NSLayoutConstraint.activate([
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navView.topAnchor.constraint(equalTo: topAnchor),
            navView.bottomAnchor.constraint(equalTo: topAnchor, constant: 120),
            
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            scrollView.topAnchor.constraint(equalTo: navView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -90),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 700),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imagesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imagesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagesCollectionView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 150),
            
            productInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productInfoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productInfoStack.topAnchor.constraint(equalTo: imagesCollectionView.bottomAnchor, constant: 16),

            buttonStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buttonStack.topAnchor.constraint(equalTo: productInfoStack.bottomAnchor, constant: 16),
            buttonStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            productDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productDescriptionLabel.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 16),
            
            addCartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addCartButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            buyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            buyButton.heightAnchor.constraint(equalToConstant: 40),
            
            buyButtonStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buyButtonStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            buyButtonStack.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 32),
        ])
    }
}
