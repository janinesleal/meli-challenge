//
//  HomeView.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 21/09/22.
//

import UIKit

class HomeView: UIView {
    lazy var searchView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = Colors.yellow
        return element
    }()
    
    lazy var cartButton: UIBarButtonItem = {
        let element = UIBarButtonItem()
        element.image = UIImage(systemName: Icons.cart.rawValue)
        element.tintColor = .darkGray
        return element
    }()
    
    lazy var searchBar: UISearchBar = {
        let element = UISearchBar()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.placeholder = "Buscar no Mercado Livre"
        element.searchTextField.backgroundColor = .white
        element.searchTextField.clipsToBounds = true
        element.searchTextField.layer.cornerRadius = 16
        return element
    }()
    
    lazy var productsTableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.rowHeight = UITableView.automaticDimension
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
        addSubview(searchView)
        addSubview(productsTableView)
        productsTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: CellIdsStrings.productTV.rawValue)
    }
    
    
    //MARK: CONSTRAINTS
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchView.topAnchor.constraint(equalTo: topAnchor),
            searchView.bottomAnchor.constraint(equalTo: topAnchor, constant: 120),
            
            productsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productsTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            productsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
