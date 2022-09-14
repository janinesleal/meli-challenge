//
//  ProductTableViewCell.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 12/09/22.
//

import UIKit

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
    
    func setCell(title: String, value: String) {
        //TODO: SETAR IMAGEM
        objectTitleLabel.text = title
        let fullPrice = "R$\(value)" // fazer extensão
        objectValueLabel.text = fullPrice
    }
}
