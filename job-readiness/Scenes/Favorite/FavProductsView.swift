//
//  FavProductsView.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 21/09/22.
//

import UIKit

class FavProductsView: UIView {
    //MARK: COMPONENTS
    lazy var navView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = Colors.yellow
        return element
    }()
    
    lazy var favProductsCollectionView : UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.itemSize = CGSize(width: 160, height: 300)
        viewLayout.minimumInteritemSpacing = 0
        let element = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        element.backgroundColor = .white
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
        addSubview(favProductsCollectionView)
    }
    
    //MARK: CONSTRAINTS
    private func setConstraints() {
        NSLayoutConstraint.activate([
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navView.topAnchor.constraint(equalTo: topAnchor),
            navView.bottomAnchor.constraint(equalTo: topAnchor, constant: 120),
            
            favProductsCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            favProductsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            favProductsCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            favProductsCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ])
    }
}
