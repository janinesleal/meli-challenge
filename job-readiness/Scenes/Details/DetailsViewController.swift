//
//  DetailsViewController.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 12/09/22.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    var mainView: DetailsView { return self.view as! DetailsView }
    var product: ProductResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setCollectionView()
    }
    
    override func loadView() {
        view = DetailsView()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        mainView.productTitleLabel.text = product?.body?.title
        mainView.productPriceLabel.text = product?.body?.price?.toBRL()
        checkIsFav()
        mainView.favButton.addTarget(self, action: #selector(setAsFav), for: .touchUpInside)
//        navigationItem.backButtonTitle = ""
    }
    
    private func setCollectionView() {
        mainView.imagesCollectionView.dataSource = self
        mainView.imagesCollectionView.register(ProductImageCollectionViewCell
            .self, forCellWithReuseIdentifier: CellIdsStrings.productImageCV.rawValue)
        mainView.imagesCollectionView.showsHorizontalScrollIndicator = false
      
    }
    
    func checkIsFav() {
        let isFav = FavList.list.contains { productList in
            self.product?.body?.id == productList.body?.id
        }
        
        mainView.favButton.setImage(UIImage(systemName: isFav ? Icons.heartFilled.rawValue : Icons.heart.rawValue), for: .normal)
    }
    
    @objc
    func setAsFav(_ sender: Any) {
        
        guard let product = product else { return }
        
        if FavList.list.insert(product).inserted {
            setUserDefaults()
            mainView.favButton.setImage(UIImage(systemName: Icons.heartFilled.rawValue), for: .normal)
        } else {
            FavList.list.remove(product)
            setUserDefaults()
            mainView.favButton.setImage(UIImage(systemName: Icons.heart.rawValue), for: .normal)
        }
    }
    
    func setUserDefaults() {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(FavList.list) {
            defaults.set(encoded, forKey: UserDefaultsKeys.favList.rawValue)
        }
    }
}

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let productPicsList = product?.body?.pictures else { return 0 }
        return productPicsList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdsStrings.productImageCV.rawValue, for: indexPath) as! ProductImageCollectionViewCell
        
        if let productPicsList = product?.body?.pictures {
            cell.productImage.kf.setImage(with: productPicsList[indexPath.row].url?.toHttps())
        }
        return cell
    }
}
