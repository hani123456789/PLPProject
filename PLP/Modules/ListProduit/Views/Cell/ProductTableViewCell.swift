//
//  ProductTableViewCell.swift
//  PLP
//
//  Created by HaniMac on 03/08/2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(product: Product) {
        productNameLabel.text = product.product_name
        productNameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        productPriceLabel.text = "\(product.price ?? 100) €"
        productPriceLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        productDescriptionLabel.text = product.description
        productImageView.loadImageUsingCache(withUrl: product.images_url?.small ?? "", placeholder: "")
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
    }
}
