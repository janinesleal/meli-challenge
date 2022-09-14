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
    //o controle da imagem vai ser feito por estar ou nao no userDefaults
    
    private func setUpUI() {
        favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        objectTitleLabel.text = product?.body?.title
        objectValueLabel.text = "\(product?.body?.price ?? 0)"
    
    }
    

    @IBAction func setAsFav(_ sender: Any) {
        let defaults = UserDefaults.standard
//        if vehicles.insert(vehicle).inserted
        defaults.set(product, forKey: <#T##String#>)
    }
    

}
