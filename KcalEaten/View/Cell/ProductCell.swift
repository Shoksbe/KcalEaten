//
//  ProductCell.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 18/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nutriScoreImage: UIImageView!
    @IBOutlet weak var novaImage: UIImageView!

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productMarque: UILabel!
    @IBOutlet weak var kcalConsume: UILabel!

    var product: ProductObject? {
        didSet {
            if let product = product {
                self.productImage.image = product.image
                self.productName.text = product.name
                self.kcalConsume.text = String(product.kCalByGrams * 100) + " / 100gr" 
            }
        }
    }

}
