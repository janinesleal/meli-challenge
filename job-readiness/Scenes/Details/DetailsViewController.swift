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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func setAsFav(_ sender: Any) {
    }
    

}
