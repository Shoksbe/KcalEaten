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

                let KcalConsumeBy100GrWithoutComma = Int(product.kCalByGrams * 100)
                self.kcalConsume.text = String(KcalConsumeBy100GrWithoutComma) + "kcal" + " / 100gr"

                if let nutriScore = product.nutriScore {
                    self.nutriScoreImage.image = UIImage(named: "NutriScore\(nutriScore)")
                } else {
                    self.nutriScoreImage.isHidden = true
                }

                if product.novaGroup == 1 ||
                   product.novaGroup == 2 ||
                   product.novaGroup == 3 ||
                   product.novaGroup == 4  {
                    self.novaImage.image = UIImage(named: "Nova\(product.novaGroup)")
                } else {
                    self.novaImage.isHidden = true
                }
            }
        }
    }

}
