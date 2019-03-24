//
//  ProductCell.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 18/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }

    var product: ProductObject? {
        didSet {
            if let product = product {
                self.imageView.image = product.image
                self.productLabel.text = product.name
            }
        }
    }

}
