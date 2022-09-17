//
//  FavProductsViewController.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 16/09/22.
//

import UIKit

class FavProductsViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setUpUI()
        setConstraints()
        favProductsCollectionView.dataSource = self
        favProductsCollectionView.register(FavProductCollectionViewCell
            .self, forCellWithReuseIdentifier: FavProductCollectionViewCell.cellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favProductsCollectionView.reloadData()
    }
    
    
    private func setViews() {
        view.addSubview(navView)
        view.addSubview(favProductsCollectionView)
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = Colors.yellow
        self.navigationItem.title = ""
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navView.topAnchor.constraint(equalTo: view.topAnchor),
            navView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            
            favProductsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            favProductsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favProductsCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            favProductsCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8)
        ])
    }
}

extension FavProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavList.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favProductsCollectionView.dequeueReusableCell(withReuseIdentifier: FavProductCollectionViewCell.cellID, for: indexPath) as! FavProductCollectionViewCell
        let productsArr = Array(FavList.list)
        let item = productsArr[indexPath.row]
        cell.product = item
  
        return cell
    }
}
