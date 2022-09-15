//
//  DetailsViewController.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 12/09/22.
//

import UIKit

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
    }
    
    private func setUpUI() {
        objectTitleLabel.text = product?.body?.title
        objectValueLabel.text = "\(product?.body?.price ?? 0)"
        checkIsFav()
    }
    
    func checkIsFav() {
        let isFav = FavList.list.contains { productList in
            self.product?.body?.id == productList.body?.id
        }
        
        isFav ? favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : favButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    @IBAction func setAsFav(_ sender: Any) {
        
        guard let product = product else { return }
        
        if FavList.list.insert(product).inserted {
            setUserDefaults()
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            FavList.list.remove(product)
            setUserDefaults()
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func setUserDefaults() {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(FavList.list) {
            defaults.set(encoded, forKey: "FavList")
        }
    }
}
