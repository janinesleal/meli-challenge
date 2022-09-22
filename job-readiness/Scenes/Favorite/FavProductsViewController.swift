//
//  FavProductsViewController.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 16/09/22.
//

import UIKit

class FavProductsViewController: UIViewController {
    var mainView: FavProductsView { return self.view as! FavProductsView }
    
    //MARK: SETTING
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainView.favProductsCollectionView.reloadData()
    }
    
    override func loadView() {
        view = FavProductsView()
    }
    
    private func setCollectionView() {
        mainView.favProductsCollectionView.dataSource = self
        mainView.favProductsCollectionView.register(FavProductCollectionViewCell
            .self, forCellWithReuseIdentifier: CellIdsStrings.favProductCV.rawValue)
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = Colors.yellow
        let textAttributes = [NSAttributedString.Key.font: UIFont(name: Font.regular, size: 15) as Any]
        navigationItem.title = InitialVCStrings.favProductsVCTitle.rawValue
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

//MARK: EXTENSIONS
extension FavProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavList.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.favProductsCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdsStrings.favProductCV.rawValue, for: indexPath) as! FavProductCollectionViewCell
        let productsArr = Array(FavList.list)
        let item = productsArr[indexPath.row]
        cell.product = item
  
        return cell
    }
}
