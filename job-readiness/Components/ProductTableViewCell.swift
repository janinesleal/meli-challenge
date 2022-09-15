//
//  ProductTableViewCell.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 12/09/22.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var objectTitleLabel: UILabel!
    @IBOutlet weak var objectValueLabel: UILabel!
    @IBOutlet weak var objectImageView: UIImageView!
    
    func setCell(title: String, price: Double, image: String) {
        objectTitleLabel.text = title
        objectValueLabel.text = price.toBRL()
        objectImageView.kf.setImage(with: image.toHttps())
    }
}
