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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String, price: String, image: String) {
        guard let http = URL(string: image) else { return }
        guard var comps = URLComponents(url: http, resolvingAgainstBaseURL: false) else { return }
        comps.scheme = "https"
        guard let imageURL = comps.url else { return }
        let fullPrice = "R$\(price)" // TODO: fazer extensão
        
        objectTitleLabel.text = title
        objectValueLabel.text = fullPrice
        objectImageView.kf.setImage(with: imageURL)
    }
}
