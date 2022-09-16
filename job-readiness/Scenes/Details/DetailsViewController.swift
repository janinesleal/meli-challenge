//
//  DetailsViewController.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 12/09/22.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var objectTitleLabel: UILabel!
    @IBOutlet weak var objectValueLabel: UILabel!
    @IBOutlet weak var objectDescriptionLabel: UILabel!
    @IBOutlet weak var objectImgsCollectionVIew: UICollectionView!
    @IBOutlet weak var favButton: UIButton!
    
    var product: ProductResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setCollectionView()
    }
    
    private func setUpUI() {
        objectTitleLabel.text = product?.body?.title
        objectValueLabel.text = product?.body?.price?.toBRL()
        checkIsFav()
    }
    
    private func setCollectionView() {
        objectImgsCollectionVIew.dataSource = self
        objectImgsCollectionVIew.register(ProductImageCollectionViewCell
            .self, forCellWithReuseIdentifier: ProductImageCollectionViewCell.cellID)
        objectImgsCollectionVIew.showsHorizontalScrollIndicator = false
        let layout = objectImgsCollectionVIew.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 297, height: 184)
        layout.scrollDirection = .horizontal
    }
    
    func checkIsFav() {
        let isFav = FavList.list.contains { productList in
            self.product?.body?.id == productList.body?.id
        }
        
        favButton.setImage(UIImage(systemName: isFav ? Icons.heartFilled.rawValue : Icons.heart.rawValue), for: .normal)
    }
    
    @IBAction func setAsFav(_ sender: Any) {
        
        guard let product = product else { return }
        
        if FavList.list.insert(product).inserted {
            setUserDefaults()
            favButton.setImage(UIImage(systemName: Icons.heartFilled.rawValue), for: .normal)
        } else {
            FavList.list.remove(product)
            setUserDefaults()
            favButton.setImage(UIImage(systemName: Icons.heart.rawValue), for: .normal)
        }
    }
    
    func setUserDefaults() {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(FavList.list) {
            defaults.set(encoded, forKey: "FavList")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImageCollectionViewCell.cellID, for: indexPath) as! ProductImageCollectionViewCell
        
        if let productPicsList = product?.body?.pictures {
            cell.productImage.kf.setImage(with: productPicsList[indexPath.row].url?.toHttps())
        }
        return cell
    }
}
